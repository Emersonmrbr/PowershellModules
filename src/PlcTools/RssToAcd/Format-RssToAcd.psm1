function Format-RssToAcd {
  [CmdletBinding(SupportsShouldProcess = $true)]
  param(
    [Parameter(Mandatory = $true,
      HelpMessage = "Enter the full path of the file or directory.")]
    [ValidateNotNullOrEmpty()]
    [string]
    # The path to the file or directory containing XML files to process.
    [Alias("P")]
    $Path,

    [Alias("Ex")]
    [string]
    # The file extension to filter files. Default is '*.xml'.
    $Extension = '*.xml',

    [Alias("B")]
    [switch]
    # If specified, creates a backup of the original files before processing.
    # The backup files will have a '.bak' extension.
    $Backup,

    [Alias("R", "RegexMap")]
    [string]
    # The path to the JSON file containing regex patterns and replacements.
    # If not specified, defaults to 'RegexMap.json' in the same directory as the
    $RegexMapPath,

    [Alias("Q")]
    [switch]
    # If specified, suppresses verbose output and only shows errors.
    # Use this for quiet operation without detailed logs.
    $Quiet,

    [Alias("L")]
    [switch]
    # If specified, creates a log file with the results of the processing.
    # The log file will be saved in the same directory as the processed files.
    $Log
  )

  $IsFile = $false

  # RegexMap.json location (custom or default)
  $regexFile = if ($RegexMapPath) { $RegexMapPath } else { Join-Path $PSScriptRoot 'RegexMap.json' }

  # Validate input path
  if (-not (Test-Path $Path)) {
    Write-Error "File or directory '$Path' not found."
    return
  }
  if (-not (Test-Path $regexFile)) {
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

  # Get files to process
  if (Test-Path $Path -PathType Leaf) {
    $files = @(Get-Item $Path)
    $IsFile = $true
  }
  else {
    $files = Get-ChildItem -Path $Path -Filter $Extension -File -Recurse
  }
  if (-not $files -or $files.Count -eq 0) {
    Write-Error "No files found in the specified path: $Path"
    return
  }

  $results = @()
  $resultsLog = @()
  if (-not $Quiet) { Write-Verbose "[INFO] Found $($files.Count) files to process in path: $Path" }

  # Backup files if requested
  if ($Backup) {
    foreach ($file in $files) {
      try {
        $backupPath = "$($file.FullName).bak"
        Copy-Item $file.FullName $backupPath -Force
        if (-not $Quiet) { Write-Verbose "Backup created at: $backupPath" }
      }
      catch {
        Write-Error "Failed to create backup for '$($file.FullName)': $_"
        continue
      }
    }
  }

  # Process files
  foreach ($file in $files) {
    try {
      if (-not $Quiet) { Write-Verbose "Processing file: $($file.FullName)" }
      # Detect encoding (simple UTF8 BOM check, fallback to Default)
      $rawBytes = [System.IO.File]::ReadAllBytes($file.FullName)
      $encoding = if ($rawBytes.Length -ge 3 -and $rawBytes[0] -eq 0xEF -and $rawBytes[1] -eq 0xBB -and $rawBytes[2] -eq 0xBF) { 'UTF8' } else { 'ASCII' }
      $content = Get-Content $file.FullName -Raw
      $originalContent = $content
      $regexApplied = @()
      $totalReplacements = 0
      foreach ($regex in $regexList) {
        if (-not $regex.PSObject.Properties.Match('Pattern') -or -not $regex.PSObject.Properties.Match('Replacement')) {
          Write-Error "Invalid regex entry in '$regexFile': $($regex | ConvertTo-Json)"
          continue
        }
        if (-not ($regex.Pattern -and $regex.Replacement)) {
          Write-Error "Each regex entry must have 'Pattern' and 'Replacement'."
          continue
        }
        # Count how many occurrences will be replaced
        $elementMatches = [regex]::Matches($content, $regex.Pattern)
        $countMatches = $elementMatches.Count
        if ($countMatches -gt 0) {
          $regexApplied += $regex.Pattern
          $totalReplacements += $countMatches
          if (-not $Quiet) { Write-Verbose "Applied: $($regex.Pattern) ➝ $($regex.Replacement) ($countMatches replacement(s))" }
        }
        $content = $content -replace $regex.Pattern, $regex.Replacement
      }
      $changed = $content -ne $originalContent
      if ($changed -and $PSCmdlet.ShouldProcess($file.FullName, "Update file with regex replacements")) {
        if ($encoding -eq 'UTF8') {
          Set-Content $file $content -Encoding UTF8 -Force
        }
        else {
          Set-Content $file $content -Force
        }
        if (-not $Quiet) { Write-Verbose "[INFO] File '$($file.Name)' processed and updated." }
      }
      elseif (-not $changed) {
        if (-not $Quiet) { Write-Verbose "[INFO] File '$($file.Name)' processed but no changes were made." }
      }
      $results += [PSCustomObject]@{
        File             = $file.FullName
        Changed          = $changed
        RegexCount       = $regexApplied.Count
        ReplacementCount = $totalReplacements
      }
      $resultsLog += [PSCustomObject]@{
        File             = $file.FullName
        Changed          = $changed
        RegexApplied     = $regexApplied
        RegexCount       = $regexApplied.Count
        ReplacementCount = $totalReplacements
      }
      if (-not $Quiet) {
        Write-Host "[$($file.Name)] Total regex replacements: $totalReplacements"
      }
    }
    catch {
      Write-Error "Failed to process file '$($file.FullName)': $_"
      $results += [PSCustomObject]@{
        File             = $file.FullName
        Changed          = $false
        RegexApplied     = @()
        RegexCount       = 0
        ReplacementCount = 0
        Error            = $_.Exception.Message
      }
      continue
    }
  }

  $changedCount = ($results | Where-Object { $_.Changed }).Count
  $totalRegex = ($results | Measure-Object -Property ReplacementCount -Sum).Sum
  if (-not $Quiet) {
    Write-Host "[OK] [$changedCount] file(s) updated in path $Path"
    Write-Host "[INFO] Total regex replacements made: $totalRegex"
  }
  if ($Log) {
    $Time = Get-Date -Format "yyyyMMdd_HHmmss"
    $LogName = "Format-RssToAcd_$Time.log"
    $LogDirectory = if ($IsFile) { Split-Path -Path $Path -Parent -Resolve } else { $Path }
    $LogPath = Join-Path $LogDirectory $LogName
    $resultsLog | ConvertTo-Json -Depth 5 | Out-File -FilePath $LogPath -Encoding UTF8
    if (-not $Quiet) { Write-Host "[INFO] Log file created at: $LogPath" }
  }

  return $results
}

Export-ModuleMember -Function Format-RssToAcd