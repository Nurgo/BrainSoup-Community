# Load configuration
. config.ps1

# Check arguments
if ([string]::IsNullOrWhiteSpace($WebHook)) {
    Write-Error "WebHook is not set in the config.ps1 file of the Discord custom tool."
    exit 1
}

# Build request
$Headers = @{
    'Content-Type' = 'application/json; charset=utf-8'
}
$Body = @{
    username = $env:ARGS_AGENTNAME
    content  = $env:ARGS_MESSAGE
    avatar_url = $env:ARGS_AGENTAVATARURL
} | ConvertTo-Json

# Encode body to UTF8 to make sure non-ASCII characters are handled correctly
$BodyUtf8 = [System.Text.Encoding]::UTF8.GetBytes($Body)

# Send request
$Response = Invoke-WebRequest -Method Post -Uri $WebHook -Headers $Headers -Body $BodyUtf8