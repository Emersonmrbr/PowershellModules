# User's module installation path
$modulePath = "$env:USERPROFILE\Documents\PowerShell\Modules\Format-RssToAcd"

# Create the folder if it doesn't exist
if (-Not (Test-Path $modulePath)) {
    New-Item -ItemType Directory -Path $modulePath | Out-Null
    Write-Host "Folder created at: $modulePath"
}

# Copy the files from the current directory to the destination
Copy-Item -Path ".\Format-RssToAcd.psm1", ".\Format-RssToAcd.psd1" -Destination $modulePath -Force

Write-Host "Format-RssToAcd module installed at $modulePath"
Write-Host "To load the module in your current session, run:"
Write-Host "Import-Module Format-RssToAcd"