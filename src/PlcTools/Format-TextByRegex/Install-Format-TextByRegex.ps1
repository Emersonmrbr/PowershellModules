<#
.SYNOPSIS
Installs the Format-TextByRegex PowerShell module to the user's module directory.

.DESCRIPTION
This script creates the Format-TextByRegex module folder in the user's PowerShell Modules directory if it does not already exist, and copies the module files (.psm1, .psd1, .xml and .md) to that location. It provides instructions for importing the module after installation.

.NOTES
File Name      : Install-Format-TextByRegex.ps1
Author         : Emerson Martins Brito
Module Version : 1.0.0
Date           : 2025-07-04

.EXAMPLE
.\Install-Format-TextByRegex.ps1

Installs the Format-TextByRegex module for the current user.

#>
function Install-Format-TextByRegex {
  param(
    [Parameter(Mandatory = $true)]
    [string] $Path
  )

  # User's module installation path
  $modulePath = "$env:USERPROFILE\Documents\PowerShell\Modules"

  # Create the folder if it doesn't exist
  if (-Not (Test-Path $modulePath)) {
    New-Item -ItemType Directory -Path $modulePath | Out-Null
    Write-Host "Folder created at: $modulePath"
  }

  # Copy the files from the current directory to the destination
  Copy-Item -Path $Path -Destination $modulePath -Force -Recurse -Exclude "*.md", "*.ps1", "*.bak" -ErrorAction Stop


  Write-Host "Format-TextByRegex module installed at $modulePath"
  Write-Host "To load the module in your current session, run:"
  Write-Host "Import-Module Format-TextByRegex"
}

Install-Format-TextByRegex $PSScriptRoot