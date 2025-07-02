<#
.SYNOPSIS
Installs the Format-RssToAcd PowerShell module to the user's module directory.

.DESCRIPTION
This script creates the Format-RssToAcd module folder in the user's PowerShell Modules directory if it does not already exist, and copies the module files (.psm1 and .psd1) to that location. It provides instructions for importing the module after installation.

.NOTES
File Name      : Install-Format-RssToAcd.ps1
Author         : [Your Name]
Module Version : [Specify version if applicable]
Date           : [Date]

.EXAMPLE
.\Install-Format-RssToAcd.ps1

Installs the Format-RssToAcd module for the current user.

#>
# User's module installation path
$modulePath = "$env:USERPROFILE\Documents\PowerShell\Modules\Format-RssToAcd"

# Create the folder if it doesn't exist
if (-Not (Test-Path $modulePath)) {
  New-Item -ItemType Directory -Path $modulePath | Out-Null
  Write-Host "Folder created at: $modulePath"
}

# Copy the files from the current directory to the destination
Copy-Item -Path ".\Format-RssToAcd.psm1", ".\Format-RssToAcd.psd1", ".\Format-RssToAcd-help.xml", ".\RegexMap.json" -Destination $modulePath -Force

Write-Host "Format-RssToAcd module installed at $modulePath"
Write-Host "To load the module in your current session, run:"
Write-Host "Import-Module Format-RssToAcd"