$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "Clear-Temporary\Install-Clear-Temporary.ps1"
Write-Host "$scriptPath"
Invoke-Expression $scriptPath
