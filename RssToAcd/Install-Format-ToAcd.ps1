# Caminho de instalação do usuário
$modulePath = "$env:USERPROFILE\Documents\PowerShell\Modules\Format-RssToAcd"

# Cria a pasta se não existir
if (-Not (Test-Path $modulePath)) {
    New-Item -ItemType Directory -Path $modulePath | Out-Null
    Write-Host "Pasta criada em: $modulePath"
}

# Copia os arquivos do diretório atual para o destino
Copy-Item -Path ".\Format-RssToAcd.psm1", ".\Format-RssToAcd.psd1" -Destination $modulePath -Force

Write-Host "`n✅ Módulo FormatToAcd instalado em $modulePath"
Write-Host "ℹ️ Para carregar o módulo em sua sessão atual, execute:"
Write-Host "`nImport-Module FormatToAcd`n"
