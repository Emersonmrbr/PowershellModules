function Format-TextByRegex {
  [CmdletBinding(SupportsShouldProcess = $true)]
  param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [Alias("P")]
    [string] $Path,

    [Alias("Ex")]
    [string] $Extension = '*.xml',

    [Alias("B")]
    [switch] $Backup,

    [Alias("R", "RegexMap")]
    [string] $RegexMapPath,

    [Alias("Q")]
    [switch] $Quiet,

    [Alias("L")]
    [switch] $Log
  )

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

  function Get-RegexList {
    param($Path)
    if (-not (Test-Path $Path)) {
      throw "Regex file '$Path' not found."
    }
    $json = Get-Content $Path -Raw
    if ([string]::IsNullOrWhiteSpace($json)) {
      throw "Regex file '$Path' is empty."
    }
    return $json | ConvertFrom-Json
  }

  function Get-FilesToProcess {
    param($Path, $Extension)
    if (-not (Test-Path $Path)) {
      throw "File or directory '$Path' not found."
    }
    return (Test-Path $Path -PathType Leaf) ? @(Get-Item $Path) : (Get-ChildItem $Path -Filter $Extension -File -Recurse)
  }

  function New-Backup {
    param($Files)
    if (-not $Files -or $Files.Count -eq 0) {
      Write-Status "No files to backup." "INFO" "Continue"
      return
    }
    $previousBackup = Get-ChildItem -Path $Path -Include "*.bak" -File -Recurse -ErrorAction SilentlyContinue 
    if ($previousBackup.Length -gt 0) {
      Write-Status "Previous backup files found. Do you want to overwrite them?" "INFO" "Continue"
      Write-Status "Previous backup files found. Do you want to overwrite them?" "INFO" "Inquire"
    }
    foreach ($file in $Files) {
      Copy-Item $file.FullName "$($file.FullName).bak" -Force
    }
    Write-Status "[OK] Creating backup for $($Files.Count) file(s)..." "OK"
  }

  function Set-File {
    param($file, $regexList, $Quiet)
    $raw = [System.IO.File]::ReadAllBytes($file.FullName)
    $encoding = ($raw[0..2] -eq @(0xEF, 0xBB, 0xBF)) ? 'UTF8' : 'ASCII'
    $content = Get-Content $file.FullName -Raw
    $original = $content
    $applied = @()
    $replacements = 0

    foreach ($rx in $regexList) {
      if (-not ($rx.Pattern -and $rx.Replacement)) { continue }
      $count = [regex]::Matches($content, $rx.Pattern).Count
      if ($count -gt 0) {
        $applied += $rx.Pattern
        $replacements += $count
        Write-Status "[INFO] Applied: $($rx.Pattern) ➝ $($rx.Replacement) ($count)"
        $content = $content -replace $rx.Pattern, $rx.Replacement
      }
    }

    if (($content -ne $original) -and ($PSCmdlet.ShouldProcess($file.FullName, "Update"))) {
      Set-Content $file $content -Encoding $encoding -Force
      Write-Status "[INFO] File '$($file.Name)' updated."
    }

    return [PSCustomObject]@{
      File             = $file.FullName
      DateProcessed    = (Get-Date -UFormat "%F %T").ToString()
      Size             = [Math]::Round($content.Length / 1MB, 2)
      Lenght           = $content.Length
      Changed          = ($content -ne $original)
      RegexApplied     = $applied
      RegexCount       = $applied.Count
      ReplacementCount = $replacements
      Encoding         = $encoding
      ContentHash      = [System.BitConverter]::ToString([System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($content))).Replace("-", "")
      Measurement      = $content | Measure-Object -Character -Line -Word
    }
  }

  $regexPath = if ($RegexMapPath) { $RegexMapPath } else { Join-Path $PSScriptRoot 'RegexMap.json' }
  $regexList = Get-RegexList -Path $regexPath
  $files = Get-FilesToProcess -Path $Path -Extension $Extension
  if ($files.Count -eq 0) { throw "No files found at path '$Path'." }
  Write-Status "[INFO] Found $($files.Count) files in '$Path'" 
  if ($Backup) { New-Backup -Files $files }

  $results = [System.Collections.Generic.List[PSObject]]::new()
  foreach ($file in $files) {
    try {
      $result = Set-File -file $file -regexList $regexList -Quiet:$Quiet
      $results += $result
      Write-Status "[INFO] [$($file.Name)] Total replacements: $($result.ReplacementCount)"
    }
    catch {
      Write-Error "Error processing '$($file.FullName)': $_"
    }
  }

  if ($Log) {
    $logPath = Join-Path ( (Test-Path $Path -PathType Leaf) ? (Split-Path $Path -Parent) : $Path) "Format-TextByRegex_$(Get-Date -UFormat '%Y%m%d_%H%M%S').log"
    $results | ConvertTo-Json -Depth 5 | Out-File $logPath -Encoding UTF8
    Write-Status "[OK] Log file created at: $logPath" "OK"
  }

  $changedCount = ($results | Where-Object { $_.Changed }).Count
  $totalReplacements = ($results | Measure-Object -Property ReplacementCount -Sum).Sum
  $results = $results | Select-Object File, Changed, RegexCount, ReplacementCount | Format-Table -AutoSize
  Write-Status "[OK] Processed $($files.Count) file(s) in path '$Path'" "OK"
  Write-Status "[OK] Updated $changedCount file(s)" "OK"
  Write-Status "[OK] Total replacements: $totalReplacements" "OK"
  if (-not $Quiet) {
    return $results
  }

}

Export-ModuleMember -Function Format-TextByRegex