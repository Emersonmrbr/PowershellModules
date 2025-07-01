function Format-RssToAcd {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [switch]$CreateBackup
    )

    if (-Not (Test-Path $FilePath)) {
        Write-Error "Arquivo '$FilePath' não encontrado."
        return
    }

    # Caminho fixo do RegexMap no diretório do módulo
    $regexFile = Join-Path $PSScriptRoot 'RegexMap.json'


    if (-Not (Test-Path $regexFile)) {
        Write-Error "Arquivo de regex '$regexFile' não encontrado."
        return
    }

    $jsonContent = Get-Content $regexFile -Raw
    if ([string]::IsNullOrWhiteSpace($jsonContent)) {
        Write-Error "O arquivo de regex '$regexFile' está vazio."
        return
    }
    try {
        $regexList = $jsonContent | ConvertFrom-Json
    }
    catch {
        Write-Error "Erro ao analisar o arquivo JSON '$regexFile': $_"
        return
    }

    if ($CreateBackup) {
        $backupPath = "$FilePath.bak"
        Copy-Item $FilePath $backupPath -Force
        Write-Verbose "Backup criado em: $backupPath"
    }

    $content = Get-Content $FilePath -Raw

    foreach ($regex in $regexList) {
        Write-Verbose "Substituindo: $($regex.Pattern) ➝ $($regex.Replacement)"
        $content = $content -replace $regex.Pattern, $regex.Replacement
    }
    Set-Content $FilePath $content -Encoding UTF8

    Write-Host "`n[OK] Substituições concluídas no arquivo $FilePath"
}
Export-ModuleMember -Function Format-RssToAcd
