$url = 'https://github.com/mrsprinkler/mods/tree/master'
$destination = "$env:APPDATA\.minecraft\mods"
param(
    [string],
    [string]
)

# Define the temporary file path to save the ZIP file
$tempZipPath = "$env:TEMP\downloaded.zip"

# Download the ZIP file from the URL
Invoke-WebRequest -Uri $url -OutFile $tempZipPath

# Check if the file was downloaded successfully
if (Test-Path $tempZipPath) {
    # Extract the ZIP file to the destination folder
    Expand-Archive -Path $tempZipPath -DestinationPath $destination -Force
    
    # Remove the temporary ZIP file
    Remove-Item -Path $tempZipPath

    # Delete install.ps1 if it exists in the destination
    $installPs1Path = Join-Path -Path $destination -ChildPath "install.ps1"
    if (Test-Path $installPs1Path) {
        Remove-Item -Path $installPs1Path
        Write-Host "install.ps1 deleted from the destination."
    }

    Write-Host "ZIP file downloaded and extracted successfully to $destination."
} else {
    Write-Host "Failed to download the ZIP file."
}
