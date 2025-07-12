<#
.SYNOPSIS
    Executes the Format-TextByRegex module installation script.

.DESCRIPTION
    Locates and executes the installation script for the Format-TextByRegex module
    from the module's subdirectory.

.NOTES
    File Name      : Invoke-Installation.ps1
    Author         : Emerson Martins Brito
    Module Version : 1.0.0
    Date           : 2025-07-04

.EXAMPLE
    .\Invoke-Installation.ps1
    Runs the Format-TextByRegex module installation script.
#>

function Install-PlcTools {
  [CmdletBinding()]
  param()

  try {
    $scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "Format-TextByRegex\Install-Format-TextByRegex.ps1"
        
    if (-not (Test-Path -Path $scriptPath)) {
      throw "Installation script not found at: $scriptPath"
    }

    Write-Verbose -Message "Found installation script at: $scriptPath"
    & $scriptPath
  }
  catch {
    Write-Error -Message "Failed to execute installation: $_"
    exit 1
  }
}

Install-PlcTools 

