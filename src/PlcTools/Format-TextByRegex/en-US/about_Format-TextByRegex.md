# Format-TextByRegex

## about_Format-TextByRegex

# TOPIC

about_Format-TextByRegex

# SHORT DESCRIPTION

Converts RSS (Rockwell Software) format files to ACD (Allen-Bradley ControlLogix project) format using customizable regular expression mappings.

# LONG DESCRIPTION

The Format-TextByRegex module provides a function to automate the conversion of files from the RSS format to the ACD format, commonly used in PLC migration or integration scenarios. The function reads a set of regular expression patterns and replacements from a JSON file (`RegexMap.json`) and applies them to the target file(s). Optional backup creation is supported before making changes. The module now provides detailed output, including the total number of regex replacements per file and an overall summary at the end of execution. Additional parameters such as `-RegexMapPath`, `-Quiet`, `-Log`, and `-ProgressAction` are supported for greater flexibility and control. This tool is useful for engineers and developers working with industrial automation projects who need to modernize or migrate legacy PLC programs.

> [!NOTE]
> The `RegexMap.json` file must be present in the same directory as the module, unless a custom path is specified with `-RegexMapPath`. Each entry in the JSON must contain both `Pattern` and `Replacement` properties.

## Optional Subtopics

{{ Optional Subtopic Placeholder }}

# EXAMPLES

## Example 1

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml"
```

Formats the file `PlcFiles.xml`, applies the regex replacements using the default RegexMap.json, and does not create a backup. The function will convert formats like "{::[LinkName]B3:0/0}" to "{::[LinkName]B3[0].0}". At the end, it displays the number of replacements made.

## Example 2

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml" -Backup
```

Formats the file `PlcFiles.xml`, applies the regex replacements, and creates a backup before making changes.

## Example 3

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```

Processes all `.xml` files in the `C:\Temp\PlcFiles` directory, applies the regex replacements defined in RegexMap.json, and does not create backups. Useful for converting multiple files at once.

## Example 4

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```

Processes all `.txt` files in the directory, applying the regex replacements.

## Example 5

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```

Processes all `.csv` files in the directory, creates a backup for each file, and applies the regex replacements.

## Example 6

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

Processes all `.xml` files in the directory using a custom regex map file and suppresses output to the host, returning only the result object.

## Example 7

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet -Log
```

Processes all `.xml` files in the directory using a custom regex map file, suppresses output to the host, returns only the result object, and creates a log file saved in the same directory.

# NOTE

- The log file is saved in the same directory specified in `-Path`.
- The final summary is displayed by default unless `-Quiet` is used.
- The module supports multi-language help (en-US and pt-BR).
- For advanced usage, see the README in the module directory.

# TROUBLESHOOTING NOTE

# SEE ALSO

# KEYWORDS
