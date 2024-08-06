# Load configuration
. config.ps1

# Check arguments
if ([string]::IsNullOrWhiteSpace($smtpServer)) {
    Write-Error "SMTP server address not configured in the config.ps1 file of the Email custom tool."
    exit 1
}

# Function to check if an email address is in the white list
function Is-Whitelisted {
    param (
        [string]$email
    )

    foreach ($pattern in $whiteList) {
        if ($email -like $pattern) {
            return $true
        }
    }
    return $false
}

# Email parameters
$agentName = $env:ARGS_AGENTNAME.ToLower().Replace(" ", ".")
$displayName = $env:ARGS_AGENTNAME
$from = "$displayName <$agentName@$fromEmailDomain>"
$to = $env:ARGS_RECIPIENTS.Replace(",", ";") -split ";" | Where-Object { $_ -ne "" }
$cc = $env:ARGS_CC.Replace(",", ";") -split ";" | Where-Object { $_ -ne "" }
$bcc = $env:ARGS_BCC.Replace(",", ";") -split ";" | Where-Object { $_ -ne "" }
$subject = $env:ARGS_SUBJECT
$body = $env:ARGS_BODY + $postScriptum
$attachments = $env:ARGS_ATTACHMENTS.Replace("""", "") -split ";" | Where-Object { $_ -ne "" }

# Path to the secure password file
$secureCredentialFile = "$env:ARGS_TOOLPATH\secure_credential.xml"

# Check if recipients are whitelisted
if ($whiteList.Count -gt 0) {
    $allRecipients = "$env:ARGS_RECIPIENTS;$env:ARGS_CC;$env:ARGS_BCC" -split ";" | Where-Object { $_ -ne "" }
    foreach ($recipient in $allRecipients) {
        if (-not (Is-Whitelisted -email $recipient)) {
            Write-Error "Recipient '$recipient' is not in the white list."
            exit 1
        }
    }
}

# Check if the secure password file exists
$saveCredentials = $false
if (-Not (Test-Path -Path $secureCredentialFile)) {
    # Prompt the user for the password
    $credential = Get-Credential -Message "Enter your credentials for the SMTP server '$smtpServer' (required only once)"
    $saveCredentials = $true
} else {
    # Retrieve the secure password from the file
    $credential = Import-Clixml -Path $secureCredentialFile
}

# Try to send the email
try {
    # Prepare the parameters for Send-MailMessage
    $mailParams = @{
        SmtpServer  = $smtpServer
        Port        = $smtpPort
        From        = $from
        To          = $to
        Subject     = $subject
        Body        = $body
        Credential  = $credential
        UseSsl      = $true
        Encoding    = [System.Text.Encoding]::UTF8
        ErrorAction = 'Stop'
    }

    # Add ReplyTo if provided
    if (-not [string]::IsNullOrWhiteSpace($replyTo)) {
        $mailParams.ReplyTo = $replyTo
    }

    # Add Cc if provided
    if ($cc.Count -gt 0) {
        $mailParams.Cc = $cc
    }

    # Add Bcc if provided
    if ($bcc.Count -gt 0) {
        $mailParams.Bcc = $bcc
    }

    # Add attachments if provided
    if ($attachments.Count -gt 0) {
        $mailParams.Attachments = $attachments
    }
    
    # Send the email
    Send-MailMessage @mailParams
    Write-Host "Email sent successfully"

    # Save the credentials only if email is sent successfully
    if ($saveCredentials) {
        $credential | Export-Clixml -Path $secureCredentialFile
    }
} catch {
    Write-Host "Failed to send email. Error: $_"
}