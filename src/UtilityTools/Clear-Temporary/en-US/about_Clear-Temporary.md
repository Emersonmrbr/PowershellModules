# Clear-Temporary

## about_Clear-Temporary

# TOPIC

about_Clear-Temporary

# SHORT DESCRIPTION

Removes temporary files from system directories, optionally runs Disk Cleanup, and can restart or shut down the computer.

# LONG DESCRIPTION

The `Clear-Temporary` function deletes temporary files from standard Windows directories, optionally executes the Windows Disk Cleanup utility (`cleanmgr`), and can restart or shut down the system upon completion.

Temporary file deletion is performed safely with `ShouldProcess` support. You can enable detailed logging of file counts and sizes per directory and optionally suppress host output for quiet operation.

## Optional Subtopics

# EXAMPLES

## Example 1

```powershell
PS C:\> Clear-Temporary
```

Removes temporary files from system temp folders and displays standard success messages.

## Example 2

```powershell
PS C:\> Clear-Temporary -ClearDisk
```

Removes temporary files and runs the Windows Disk Cleanup utility.

## Example 3

```powershell
PS C:\> Clear-Temporary -Restart
```

Removes temporary files and restarts the computer after a brief delay.

## Example 4

```powershell
PS C:\> Clear-Temporary -Log
```

Removes temporary files and logs details for each folder to a file in the system TEMP directory.

## Example 5

```powershell
PS C:\> Clear-Temporary -Quiet
```

Performs the operation while suppressing standard output messages, displaying verbose messages only.

# NOTE

- Requires administrative privileges for Disk Cleanup, restart, and shutdown actions.
- Uses `ShouldProcess` for confirmation before performing destructive operations.
- Log files are saved to the system TEMP directory as `Clear-Temporary.log`.
- The Prefetch folder is no longer processed to preserve system stability.
- The module supports multi-language help (en-US and pt-BR).

# TROUBLESHOOTING NOTE

# SEE ALSO

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item)
[Get-ChildItem](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem)
[Measure-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object)
[Restart-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer)
[Stop-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-computer)
[cleanmgr.exe](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cleanmgr)

# KEYWORDS
