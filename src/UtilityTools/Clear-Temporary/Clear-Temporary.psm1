<#
.SYNOPSIS
    Cleans temporary files and optionally performs system maintenance tasks.
.DESCRIPTION
    The Clear-Temporary function removes temporary files from system locations and can optionally:
    - Run Disk Cleanup utility
    - Restart or shutdown the computer
    - Create a log of cleaned files
.PARAMETER Quiet
    Suppresses non-essential output. [Alias: Q]
.PARAMETER Log
    Creates a log file with cleaning results in %TEMP%. [Alias: L]
.PARAMETER Restart
    Restarts the computer after cleaning (10 second countdown). [Alias: R]
.PARAMETER Shutdown
    Shuts down the computer after cleaning (10 second countdown). [Alias: S]
.PARAMETER ClearDisk
    Runs Windows Disk Cleanup utility with comprehensive settings. [Alias: C]
.EXAMPLE
    PS> Clear-Temporary
    Cleans temporary files from default locations with normal output.
.EXAMPLE
    PS> Clear-Temporary -ClearDisk -Log
    Cleans temporary files, runs Disk Cleanup, and creates a log file.
.EXAMPLE
    PS> Clear-Temporary -Restart -Quiet
    Cleans temporary files and restarts the computer without confirmation.
.INPUTS
    None. You cannot pipe input to this function.
.OUTPUTS
    System.Management.Automation.PSCustomObject showing cleaning results for each location.
.NOTES
    - Requires administrative privileges for full functionality
    - Disk Cleanup uses preset configuration (sageset:65535)
    - Default temp locations cleaned: %TEMP% and C:\Windows\Temp
    - Log files are saved in %TEMP% with timestamp
    - Restart/Shutdown have 10 second countdown
#>

function Clear-Temporary {
  [CmdletBinding(SupportsShouldProcess = $true)]
  [OutputType([System.Collections.Generic.List[PSObject]])]
  [OutputType([void])]
  param(
    [Alias("Q")][switch] $Quiet,
    [Alias("L")][switch] $Log,
    [Alias("R")][switch] $Restart,
    [Alias("S")][switch] $Shutdown,
    [Alias("C")][switch] $ClearDisk
  )

  $tempPaths = @("$env:TEMP", "$env:windir\Temp")
  $results = [System.Collections.Generic.List[PSObject]]::new()

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

  function Optimize-File {
    param([string]$Path)
    $content = Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
    $originalSizeMB = ($content | Measure-Object Length -Sum).Sum / 1MB
    $originalCount = $content.Count

    $content | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

    $remaining = Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
    $remainingSizeMB = ($remaining | Measure-Object Length -Sum).Sum / 1MB

    return [PSCustomObject]@{
      Path             = $Path
      "Date Processed" = Get-Date -UFormat "%F %T"
      "Total Deleted"  = $originalCount - $remaining.Count
      "Released (MB)"  = [decimal]($originalSizeMB - $remainingSizeMB)
    }
  }

  function Initialize-Countdown {
    param([string]$ActionText)
    Start-Sleep 10
    0..9 | ForEach-Object { Write-Status -Message "[INFO] $ActionText in $_ seconds..." }
  }

  try {
    foreach ($path in $tempPaths) {
      if ((Test-Path $path) -and ($PSCmdlet.ShouldProcess($path, "Remove temporary files"))) {
        $results.Add((Optimize-File $path))
      }
    }
    Write-Status -Message "[OK] Temporary files deleted successfully" -Type "OK"
  }
  catch {
    Write-Status -Message "Failed to delete temporary files: $_" -Type "ERROR"
  }

  if (($ClearDisk) -and ($PSCmdlet.ShouldProcess("Disk Cleanup", "Run cleanmgr"))) {
    try {
      Start-Process cleanmgr -ArgumentList "/sageset:65535" -Wait
      Start-Process cleanmgr -ArgumentList "/sagerun:65535" -WindowStyle Normal -Wait
      Start-Process cleanmgr.exe -ArgumentList "/lowdisk /sagerun:65535" -WindowStyle Normal -Wait
      Write-Status -Message "[OK] Disk Cleanup completed successfully" -Type "OK"
    }
    catch {
      Write-Status -Message "Disk Cleanup operation failed: $_" -Type "ERROR"
    }
  }
  else {
    Write-Status -Message "[INFO] Disk Cleanup not performed"
  }

  if ($Restart) {
    Write-Status -Message "System will restart in 10 seconds..." -Type "INFO" -InformationAction "Continue"
    Start-Countdown "Restarting"
    Restart-Computer -Force
  }
  elseif ($Shutdown) {
    Write-Status -Message "System will shut down in 10 seconds..." -Type "INFO" -InformationAction "Continue"
    Start-Countdown "Shutting down"
    Stop-Computer -Force
  }

  if ($Log) {
    $logPath = Join-Path $env:TEMP "Clear-Temporary_$(Get-Date -UFormat '%Y%m%d_%H%M%S').log"
    foreach ($item in $results) {
      $logMessage = "$($item.'Date Processed') - Cleared $($item.'Total Deleted') files from $($item.Path) ($($item.'Released (MB)') MB)"
      Add-Content -Path $logPath -Value $logMessage
    }
    Write-Status -Message "[Ok] Log saved to $logPath" -Type "OK"
  }

  if (-not $Quiet) {
    return $results
  }
}

Export-ModuleMember -Function Clear-Temporary