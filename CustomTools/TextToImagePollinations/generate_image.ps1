$ApiEndpoint = "https://pollinations.ai/prompt/"

# Escape the prompt to be URL safe
$escapedPrompt = [System.Uri]::EscapeDataString($env:ARGS_PROMPT)

# Generate a GUID for the seed
$seed = [System.Guid]::NewGuid().ToString()

# Build request by adding $escapedPrompt and $seed to the $ApiEndpoint
$Url = $ApiEndpoint + $escapedPrompt + "?seed=" + $seed

# Create a file name of the form "image_pollinationsai_yyyyMMddHHmmssfff.jpg"
$FileName = "image_pollinationsai_" + (Get-Date).ToString("yyyyMMddHHmmssfff") + ".jpg"

# Send a GET request to download the image
Invoke-WebRequest -Uri $Url -OutFile $FileName

# Print the file name to the console
$Result = "file://./" + $FileName
Write-Host $Result