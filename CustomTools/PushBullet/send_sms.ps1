# Load configuration
. config.ps1

# Check arguments
if ([string]::IsNullOrWhiteSpace($AccessToken)) {
    Write-Error "AccessToken is not set in the config.ps1 file of the PushBullet custom tool."
    exit 1
}
if ([string]::IsNullOrWhiteSpace($DeviceIden)) {
    Write-Error "DeviceIden is not set in the config.ps1 file of the PushBullet custom tool."
    exit 1
}

# Build request
$Headers = @{
    'Access-Token' = $AccessToken
    'Content-Type' = 'application/json; charset=utf-8'
}
$Body = @{
    data = @{
        guid  = [guid]::NewGuid().ToString()
        addresses = @($env:ARGS_NUMBER)
        message = $env:ARGS_MESSAGE
        target_device_iden = $DeviceIden
    }
} | ConvertTo-Json

# Encode body to UTF8 to make sure non-ASCII characters are handled correctly
$BodyUtf8 = [System.Text.Encoding]::UTF8.GetBytes($Body)

# Send request
$Response = Invoke-WebRequest -Method Post -Uri 'https://api.pushbullet.com/v2/texts' -Headers $Headers -Body $BodyUtf8