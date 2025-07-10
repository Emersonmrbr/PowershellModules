---
external help file: Clear-Temporary-help.xml
Module Name: Clear-Temporary
online version:
schema: 2.0.0
---

# Clear-Temporary

## SYNOPSIS

Removes temporary files from system directories, optionally runs Disk Cleanup, and can restart or shut down the computer.

## SYNTAX

```
Clear-Temporary [[-Quiet]] [[-Log]] [[-Restart]] [[-Shutdown]] [[-ClearDisk]] [<CommonParameters>]
```

## DESCRIPTION

The `Clear-Temporary` function deletes temporary files from standard Windows directories, optionally executes the Windows Disk Cleanup utility (`cleanmgr`), and can restart or shut down the system upon completion.

Temporary file deletion is performed safely with `ShouldProcess` support. You can enable detailed logging of file counts and sizes per directory and optionally suppress host output for quiet operation.

## EXAMPLES

### Example 1

```powershell
PS C:\> Clear-Temporary
```

Removes temporary files from system temp folders and displays standard success messages.

### Example 2

```powershell
PS C:\> Clear-Temporary -ClearDisk
```

Removes temporary files and runs the Windows Disk Cleanup utility.

### Example 3

```powershell
PS C:\> Clear-Temporary -Restart
```

Removes temporary files and restarts the computer after a brief delay.

### Example 4

```powershell
PS C:\> Clear-Temporary -Log
```

Removes temporary files and logs details for each folder to a file in the system TEMP directory.

### Example 5

```powershell
PS C:\> Clear-Temporary -Quiet
```

Performs the operation while suppressing standard output messages, displaying verbose messages only.

## PARAMETERS

### -Quiet

Suppresses standard messages displayed by the function, outputting only verbose messages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Q
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Log

Generates a log file in the system TEMP directory detailing the number and size of files deleted from each directory.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: L
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Restart

Restarts the computer after cleaning temporary files and (optionally) running Disk Cleanup.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: R
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Shutdown

Shuts down the computer after cleaning temporary files and (optionally) running Disk Cleanup.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: S
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClearDisk

Runs the Windows Disk Cleanup utility (`cleanmgr.exe`) using predefined settings.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: C
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept input from the pipeline.

## OUTPUTS

### Object[]

Returns an array of objects with details about each directory processed, including the path, file count, and total size in megabytes.

## NOTES

- Requires administrative privileges for Disk Cleanup, restart, and shutdown actions.
- Uses `ShouldProcess` for confirmation before performing destructive operations.
- Log files are saved to the system TEMP directory as `Clear-Temporary.log`.
- The Prefetch folder is no longer processed to preserve system stability.
- The module supports multi-language help (en-US and pt-BR).

## RELATED LINKS

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item)
[Get-ChildItem](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem)
[Measure-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object)
[Restart-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer)
[Stop-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-computer)
[cleanmgr.exe](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cleanmgr)
