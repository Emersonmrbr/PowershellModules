function Clear-Temporary {
  [CmdletBinding(SupportsShouldProcess = $true)]
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
    param([string]$Message, [string]$Type = "INFO", [string]$InformationAction = "Continue")
    if (-not $Quiet) {
      switch ($Type.ToUpper()) {
        "INFO" { Write-Information $Message -InformationAction $InformationAction }
        "OK" { Write-Host $Message -ForegroundColor Green }
        "ERROR" { Write-Error $Message }
        default { Write-Verbose $Message }
      }
    }
  }

  function Remove-Files {
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

  function Start-Countdown {
    param([string]$ActionText)
    Start-Sleep 10
    0..9 | ForEach-Object { Write-Status "$ActionText in $_ seconds..." }
  }

  try {
    foreach ($path in $tempPaths) {
      if ((Test-Path $path) -and ($PSCmdlet.ShouldProcess($path, "Remove temporary files"))) {
        $results.Add((Remove-Files $path))
      }
    }
    Write-Status "Temporary files deleted successfully" "OK"
  }
  catch {
    Write-Status "Failed to delete temporary files: $_" "ERROR"
  }

  if (($ClearDisk) -and ($PSCmdlet.ShouldProcess("Disk Cleanup", "Run cleanmgr"))) {
    try {
      Start-Process cleanmgr -ArgumentList "/sageset:65535" -Wait
      Start-Process cleanmgr -ArgumentList "/sagerun:65535" -WindowStyle Normal -Wait
      Start-Process cleanmgr.exe -ArgumentList "/lowdisk /sagerun:65535" -WindowStyle Normal -Wait
      Write-Status "Disk Cleanup completed successfully" "OK"
    }
    catch {
      Write-Status "Disk Cleanup operation failed: $_" "ERROR"
    }
  }
  else {
    Write-Status "Disk Cleanup not performed"
  }

  if ($Restart) {
    Write-Status "System will restart in 5 seconds..."
    Start-Countdown "Restarting"
    Restart-Computer -Force
  }
  elseif ($Shutdown) {
    Write-Status "System will shut down in 5 seconds..."
    Start-Countdown "Shutting down"
    Stop-Computer -Force
  }

  if ($Log) {
    $logPath = Join-Path $env:TEMP "Clear-Temporary_$(Get-Date -UFormat '%Y%m%d_%H%M%S').log"
    foreach ($item in $results) {
      $logMessage = "$($item.'Date Processed') - Cleared $($item.'Total Deleted') files from $($item.Path) ($($item.'Released (MB)') MB)"
      Add-Content -Path $logPath -Value $logMessage
    }
    Write-Status "Log saved to $logPath"
  }

  return $results
}

Export-ModuleMember -Function Clear-Temporary