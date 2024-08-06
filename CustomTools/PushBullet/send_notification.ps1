# Load configuration
. config.ps1

# Check arguments
if ([string]::IsNullOrWhiteSpace($AccessToken)) {
    Write-Error "AccessToken is not set in the config.ps1 file of the PushBullet custom tool."
    exit 1
}

# Build request
$Headers = @{
    'Access-Token' = $AccessToken
    'Content-Type' = 'application/json; charset=utf-8'
}
if ([string]::IsNullOrWhiteSpace($env:ARGS_URL)) {
    $type = 'note'
}
else {
    $type = 'link'
}
$Body = @{
    type  = $type
    title = $env:ARGS_TITLE
    body  = $env:ARGS_BODY
    url   = $env:ARGS_URL
    device_iden = $DeviceIden
} | ConvertTo-Json

# Encode body to UTF8 to make sure non-ASCII characters are handled correctly
$BodyUtf8 = [System.Text.Encoding]::UTF8.GetBytes($Body)

# Send request
$Response = Invoke-WebRequest -Method Post -Uri 'https://api.pushbullet.com/v2/pushes' -Headers $Headers -Body $BodyUtf8