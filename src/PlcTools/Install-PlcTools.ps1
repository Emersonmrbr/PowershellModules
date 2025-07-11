$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "Format-TextByRegex\Install-Format-TextByRegex.ps1"
Write-Host "$scriptPath"
Invoke-Expression $scriptPath

