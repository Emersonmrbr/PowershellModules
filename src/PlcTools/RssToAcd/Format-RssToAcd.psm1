<#
.SYNOPSIS
Converts RSS (Rockwell Software) format files to ACD (Allen-Bradley ControlLogix project) format using customizable regular expression mappings.

.DESCRIPTION
The Format-RssToAcd function automates the conversion of files from RSS to ACD format, applying regex patterns and replacements defined in RegexMap.json. It supports processing single files or all files in a directory (with extension filtering), and can optionally create backups before making changes. The function returns a summary object with the results of the operation.

.PARAMETER Path
The full path to the file to be modified, or to a directory containing files to process.

.PARAMETER Extension
The file extension filter to use when searching for files in a directory. Default is '*.xml'. Ignored if Path is a file.

.PARAMETER Backup
Creates a backup of the original file with a .bak extension before making any changes.

.PARAMETER RegexMapPath
(Optional) The full path to a custom RegexMap.json file. If not specified, uses the default in the module directory.

.PARAMETER Quiet
Suppresses output to the host. Only returns the result object.

.EXAMPLE
Format-RssToAcd -Path "C:\Temp\PlcFiles.xml"
Formats the file PlcFiles.xml using RegexMap.json, without creating a backup.

.EXAMPLE
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
Processes all .csv files in the directory, creates backups, and applies the regex replacements.
#>

function Format-RssToAcd {
  [CmdletBinding(SupportsShouldProcess = $true)]
  param(
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [string]$Extension = '*.xml',
    [switch]$Backup,
    [string]$RegexMapPath,
    [switch]$Quiet
  )

  # RegexMap.json location (custom or default)
  $regexFile = if ($RegexMapPath) { $RegexMapPath } else { Join-Path $PSScriptRoot 'RegexMap.json' }

  # Validate input path
  if (-Not (Test-Path $Path)) {
    Write-Error "File or directory '$Path' not found."
    return
  }
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

  # Get files to process
  if (Test-Path $Path -PathType Leaf) {
    $files = @(Get-Item $Path)
  }
  else {
    $files = Get-ChildItem -Path $Path -Filter $Extension -File -Recurse
  }
  if (-not $files -or $files.Count -eq 0) {
    Write-Error "No files found in the specified path: $Path"
    return
  }

  $results = @()
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
        # Continue processing other files
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
      $encoding = if ($rawBytes.Length -ge 3 -and $rawBytes[0] -eq 0xEF -and $rawBytes[1] -eq 0xBB -and $rawBytes[2] -eq 0xBF) { 'UTF8' } else { 'Default' }
      $content = Get-Content $file.FullName -Raw
      $originalContent = $content
      $regexApplied = @()
      foreach ($regex in $regexList) {
        if (-not $regex.PSObject.Properties.Match('Pattern') -or -not $regex.PSObject.Properties.Match('Replacement')) {
          Write-Error "Invalid regex entry in '$regexFile': $($regex | ConvertTo-Json)"
          continue
        }
        if (-not ($regex.Pattern -and $regex.Replacement)) {
          Write-Error "Each regex entry must have 'Pattern' and 'Replacement'."
          continue
        }
        $newContent = $content -replace $regex.Pattern, $regex.Replacement
        if ($newContent -ne $content) {
          $regexApplied += $regex.Pattern
          if (-not $Quiet) { Write-Verbose "Applied: $($regex.Pattern) ➝ $($regex.Replacement)" }
        }
        $content = $newContent
      }
      $changed = $content -ne $originalContent
      if ($changed -and $PSCmdlet.ShouldProcess($file.FullName, "Update file with regex replacements")) {
        Set-Content $file $content -Encoding $encoding -Force
        if (-not $Quiet) { Write-Verbose "[INFO] File '$($file.Name)' processed and updated." }
      }
      elseif (-not $changed) {
        if (-not $Quiet) { Write-Verbose "[INFO] File '$($file.Name)' processed but no changes were made." }
      }
      $results += [PSCustomObject]@{
        File         = $file.FullName
        Changed      = $changed
        RegexApplied = $regexApplied
      }
    }
    catch {
      Write-Error "Failed to process file '$($file.FullName)': $_"
      $results += [PSCustomObject]@{
        File         = $file.FullName
        Changed      = $false
        RegexApplied = @()
        Error        = $_.Exception.Message
      }
      continue
    }
  }

  $changedCount = ($results | Where-Object { $_.Changed }).Count
  if (-not $Quiet) {
    Write-Host "[OK] [$changedCount] file(s) updated in path $Path"
  }

  return $results
}

Export-ModuleMember -Function Format-RssToAcd