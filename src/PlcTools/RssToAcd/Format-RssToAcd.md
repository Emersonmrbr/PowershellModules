---
external help file: Format-RssToAcd-help.xml
Module Name: Format-RssToAcd
online version:
schema: 2.0.0
---

# Format-RssToAcd

## SYNOPSIS

Converts RSS (Rockwell Software) format files to ACD (Allen-Bradley ControlLogix project) format using customizable regular expression mappings.

## SYNTAX

```
Format-RssToAcd [-Path] <String> [-Backup] [-Extension] <string> [-RegexMapPath <string>] [-Quiet] [-Log] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The Format-RssToAcd module provides a function to automate the conversion of files from the RSS format to the ACD format, commonly used in PLC migration or integration scenarios. The function reads a set of regular expression patterns and replacements from a JSON file (`RegexMap.json`) and applies them to the target file(s). Optional backup creation is supported before making changes. The module now provides detailed output, including the total number of regex replacements per file and an overall summary at the end of execution. Additional parameters such as `-RegexMapPath`, `-Quiet`, `-Log`, and `-ProgressAction` are supported for greater flexibility and control. This tool is useful for engineers and developers working with industrial automation projects who need to modernize or migrate legacy PLC programs.

> [!NOTE]
> The `RegexMap.json` file must be present in the same directory as the module, unless a custom path is specified with `-RegexMapPath`. Each entry in the JSON must contain both `Pattern` and `Replacement` properties.

## EXAMPLES

### Example 1

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles.xml"
```

Formats the file `PlcFiles.xml`, applies the regex replacements using the default RegexMap.json, and does not create a backup. The function will convert formats like "{::[LinkName]B3:0/0}" to "{::[LinkName]B3[0].0}". At the end, it displays the number of replacements made.

### Example 2

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles.xml" -Backup
```

Formats the file `PlcFiles.xml`, applies the regex replacements, and creates a backup before making changes.

### Example 3

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```

Processes all `.xml` files in the `C:\Temp\PlcFiles` directory, applies the regex replacements defined in RegexMap.json, and does not create backups. Useful for converting multiple files at once.

### Example 4

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```

Processes all `.txt` files in the directory, applying the regex replacements.

### Example 5

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```

Processes all `.csv` files in the directory, creates a backup for each file, and applies the regex replacements.

### Example 6

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

Processes all `.xml` files in the directory using a custom regex map file and suppresses output to the host, returning only the result object.

### Example 7

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet -Log
```

Processes all `.xml` files in the directory using a custom regex map file, suppresses output to the host, returns only the result object, and creates a log file saved in the same directory.

## PARAMETERS

### -Path

The full path to the file to be modified, or to a directory containing files to process.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Extension

The file extension filter to use when searching for files in a directory. Default is `*.xml`. Ignored if `-Path` is a file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Ex

Required: False
Position: Named
Default value: *.xml
Accept pipeline input: False
Accept wildcard characters: False
```

### -Backup

Creates a backup of the original file with a .bak extension before making any changes.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: B

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RegexMapPath

(Optional) The full path to a custom RegexMap.json file. If not specified, uses the default in the module directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases: R, RegexMap

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quiet

Suppresses output to the host. Only returns the result object.

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

Creates a detailed log file of the processing, saved in the same directory specified in `-Path` with the name `Format-RssToAcd_<date>.log`.

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

### -ProgressAction

Determines how PowerShell responds to progress updates generated by a script, cmdlet, or provider, such as the progress bars generated by the Write-Progress cmdlet. The ProgressAction parameter was added in PowerShell 7.4.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

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

## OUTPUTS

### Object[]

Returns an array of objects with details about each file processed, including file path, whether it was changed, the number of regex patterns applied (`RegexCount`), the total number of replacements made (`ReplacementCount`), and any error message if processing failed.

## NOTES

- The log file is saved in the same directory specified in `-Path`.
- The final summary is displayed by default unless `-Quiet` is used.
- The module supports multi-language help (en-US and pt-BR).
- For advanced usage, see the README in the module directory.

## RELATED LINKS
