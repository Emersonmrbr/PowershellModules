<#
.SYNOPSIS
    Executes the Clear-Temporary module installation script.

.DESCRIPTION
    Locates and executes the installation script for the Clear-Temporary module
    from the module's subdirectory.

.NOTES
    File Name      : Install-All-Module.ps1
    Author         : Emerson Martins Brito
    Module Version : 1.0.0
    Date           : 2025-07-04

.EXAMPLE
    .\Invoke-Installation.ps1
    Runs the Clear-Temporary module installation script.
#>

function Install-All-Module {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [string] $Path
  )

  try {
    if (-not (Test-Path -Path $Path)) {
      throw "Installation script not found at: $Path"
    }

    Write-Verbose -Message "Found installation script at: $Path"
    & $Path
  }
  catch {
    Write-Error -Message "Failed to execute installation: $_"
    exit 1
  }
}

$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "src\PlcTools\Format-TextByRegex\Install-Format-TextByRegex.ps1"
Install-All-Module -Path $scriptPath
$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "src\UtilityTools\Clear-Temporary\Install-Clear-Temporary.ps1"
Install-All-Module -Path $scriptPath