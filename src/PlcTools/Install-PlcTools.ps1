$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "Edit-PlcFile\Install-Edit-PlcFile.ps1"
Write-Host "$scriptPath"
Invoke-Expression $scriptPath

