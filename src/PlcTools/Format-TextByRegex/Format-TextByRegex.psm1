<#
.SYNOPSIS
    Applies regex transformations to text files based on a mapping configuration.
.DESCRIPTION
    The Format-TextByRegex function processes files (typically XML) by applying regular expression
    replacements defined in a JSON configuration file. It supports backup creation, logging,
    and quiet operation modes.
.PARAMETER -Path
    Specifies the path to a file or directory to process. [Alias: P]
.PARAMETER -Extension
    Specifies the file extension filter when processing directories (default: '*.xml'). [Alias: Ex]
.PARAMETER -Backup
    Creates backup copies of files before processing (with .bak extension). [Alias: B]
.PARAMETER -RegexMapPath
    Specifies the path to the JSON file containing regex patterns and replacements.
    Defaults to 'RegexMap.json' in the script directory. [Alias: R, RegexMap]
.PARAMETER -Quiet
    Suppresses non-essential output. [Alias: Q]
.PARAMETER -Log
    Creates a JSON log file with processing results. [Alias: L]
.EXAMPLE
    PS> Format-TextByRegex -Path "C:\Files" -Extension "*.txt" -Backup
    Processes all .txt files in C:\Files, creating backups before modifications.
.EXAMPLE
    PS> Format-TextByRegex -Path "config.xml" -RegexMapPath "custom_regex.json" -Log
    Processes config.xml using patterns from custom_regex.json and generates a log file.
.INPUTS
    None. You cannot pipe input to this function.
.OUTPUTS
    System.Management.Automation.PSCustomObject showing processing results for each file.
.NOTES
    - The regex configuration file should be a JSON array with objects containing
      "Pattern" and "Replacement" properties.
    - When processing directories, the function works recursively.
    - Backup files are created with .bak extension in the same location.
    - Log files are created in the same directory as the processed files.
#>

function Format-TextByRegex {
  [CmdletBinding(SupportsShouldProcess = $true)]
  [OutputType([System.Collections.Generic.List[PSObject]])]
  [OutputType([void])]
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

  function Add-Backup {
    param($Files)
    if (-not $Files -or $Files.Count -eq 0) {
      Write-Status -Message "No files to backup." -Type "INFO" -InformationAction "Continue"
      return
    }
    $previousBackup = Get-ChildItem -Path $Path -Include "*.bak" -File -Recurse -ErrorAction SilentlyContinue
    if ($previousBackup.Length -gt 0) {
      Write-Status -Message "Previous backup files found. Do you want to overwrite them?" -Type "INFO" -InformationAction "Continue"
      Write-Status -Message "Previous backup files found. Do you want to overwrite them?" -Type "INFO" -InformationAction "Inquire"
    }
    foreach ($file in $Files) {
      Copy-Item $file.FullName "$($file.FullName).bak" -Force
    }
    Write-Status -Message "[OK] Creating backup for $($Files.Count) file(s)..." -Type "OK"
  }

  function Format-File {
    param($file, $regexList)
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
        Write-Status -Message "[INFO] Applied: $($rx.Pattern) ➝ $($rx.Replacement) ($count)"
        $content = $content -replace $rx.Pattern, $rx.Replacement
      }
    }

    if (($content -ne $original) -and ($PSCmdlet.ShouldProcess($file.FullName, "Update"))) {
      Set-Content $file $content -Encoding $encoding -Force
      Write-Status -Message "[INFO] File '$($file.Name)' updated."
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
  Write-Status -Message "[INFO] Found $($files.Count) files in '$Path'"
  if ($Backup) { Add-Backup -Files $files }

  $results = [System.Collections.Generic.List[PSObject]]::new()
  foreach ($file in $files) {
    try {
      $result = Format-File -file $file -regexList $regexList -Quiet:$Quiet
      $results += $result
      Write-Status -Message "[INFO] [$($file.Name)] Total replacements: $($result.ReplacementCount)"
    }
    catch {
      Write-Status -Message  "Error processing '$($file.FullName)': $_" -Type "ERROR"
    }
  }

  if ($Log) {
    $logPath = Join-Path ( (Test-Path $Path -PathType Leaf) ? (Split-Path $Path -Parent) : $Path) "Format-TextByRegex_$(Get-Date -UFormat '%Y%m%d_%H%M%S').log"
    $results | ConvertTo-Json -Depth 5 | Out-File $logPath -Encoding UTF8
    Write-Status -Message "[OK] Log file created at: $logPath" -Type "OK"
  }

  $changedCount = ($results | Where-Object { $_.Changed }).Count
  $totalReplacements = ($results | Measure-Object -Property ReplacementCount -Sum).Sum
  $results = $results | Select-Object File, Changed, RegexCount, ReplacementCount | Format-Table -AutoSize
  Write-Status -Message "[OK] Processed $($files.Count) file(s) in path '$Path'" -Type "OK"
  Write-Status -Message "[OK] Updated $changedCount file(s)" -Type "OK"
  Write-Status -Message "[OK] Total replacements: $totalReplacements" -Type "OK"
  if (-not $Quiet) {
    return $results
  }

}

Export-ModuleMember -Function Format-TextByRegex