# &".\PlcTools\Install-PlcTools.ps1"
# &".\UtilityTools\Install-UtilityTools.ps1"

# Script principal

$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "PlcTools\Format-TextByRegex\Install-Format-TextByRegex.ps1"
Write-Host "$scriptPath"
Invoke-Expression $scriptPath
& $scriptPath
$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "UtilityTools\Clear-Temporary\Install-Clear-Temporary.ps1"
Write-Host "$scriptPath"
Invoke-Expression $scriptPath
