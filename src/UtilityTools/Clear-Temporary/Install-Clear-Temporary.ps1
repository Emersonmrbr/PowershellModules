<#
.SYNOPSIS
Installs the Clear-Temporary PowerShell module to the user's module directory.

.DESCRIPTION
Creates the Clear-Temporary module folder in the user's PowerShell Modules directory (if it doesn't exist),
then copies the module files (.psm1, .psd1, .xml) to that location. Instructions for importing are included.

.NOTES
File Name      : Install-Clear-Temporary.ps1
Author         : Emerson Martins Brito
Module Version : 1.0.0
Date           : 2025-07-04

.EXAMPLE
.\Install-Clear-Temporary.ps1

Installs the Clear-Temporary module for the current user.
#>
function Write-Status {
  param([string]$Message, [string]$Type = "VERBOSE", [string]$InformationAction = "SilentlyContinue")
  if (-not $Quiet) {
    switch ($Type.ToUpper()) {
      "INFO" { Write-Information $Message -InformationAction $InformationAction }
      "OK" { Write-Host $Message -ForegroundColor Green }
      "ERROR" { Write-Error $Message }
      default { Write-Verbose $Message }
    }
  }
}
function Install-Clear-Temporary {
  param(
    [Parameter(Mandatory = $true)]
    [string] $Path
  )
  # User's module installation path
  $Destination = Join-Path $env:USERPROFILE "Documents\PowerShell\Modules"
  
  # Create the folder if it doesn't exist
  if (-Not (Test-Path $Destination)) {
    New-Item -ItemType Directory -Path $Destination | Out-Null
    Write-Status "[OK] Folder created at: $Destination" "OK"
  }
  
  try {
    # Perform file copy, excluding unwanted extensions
    $excludeExtensions = @("*.md", "*.ps1", "*.bak")
    Copy-Item -Path $Path -Destination $Destination -Force -Recurse -Exclude $excludeExtensions -ErrorAction Stop
    
    Write-Status "[OK] Clear-Temporary module installed from $Path" "OK"
    Write-Status "[OK] Clear-Temporary module installed at $Destination" "OK"
    Write-Status "`n[OK] To load the module in your current session, run:" "OK"
    Write-Status "[OK] Import-Module Clear-Temporary" "OK"
    
  }
  catch {
    Write-Status "Failed to install Clear-Temporary module: $_" "ERROR"
  }
}

# Run the installer with current script path
Install-Clear-Temporary $PSScriptRoot