# TODO: Update file 'RegexMap.json' to match the regex map format.
function Format-RssToAcd {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [switch]$CreateBackup
    )

    if (-Not (Test-Path $FilePath)) {
        Write-Error "File '$FilePath' not found."
        return
    }

    # Fixed path to RegexMap in the module directory
    $regexFile = Join-Path $PSScriptRoot 'RegexMap.json'


    if (-Not (Test-Path $regexFile)) {
        Write-Error "Regex file '$regexFile' not found."
        return
    }

    $jsonContent = Get-Content $regexFile -Raw
    if ([string]::IsNullOrWhiteSpace($jsonContent)) {
        Write-Error "The regex file '$regexFile' is empty."
        return
    }
    try {
        $regexList = $jsonContent | ConvertFrom-Json
    }
    catch {
        Write-Error "Error parsing the JSON file '$regexFile': $_"
        return
    }

    if ($CreateBackup) {
        $backupPath = "$FilePath.bak"
        Copy-Item $FilePath $backupPath -Force
        Write-Verbose "Backup created at: $backupPath"
    }

    $content = Get-Content $FilePath -Raw

    foreach ($regex in $regexList) {
        Write-Verbose "Replacing: $($regex.Pattern) ➝ $($regex.Replacement)"
        $content = $content -replace $regex.Pattern, $regex.Replacement
    }
    Set-Content $FilePath $content -Encoding UTF8

    Write-Host "`n[OK] Replacements completed in file $FilePath"
}
Export-ModuleMember -Function Format-RssToAcd