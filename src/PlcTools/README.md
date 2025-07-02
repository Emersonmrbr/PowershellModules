# PlcTools

This section of the repository is dedicated to the development of PowerShell tools and modules focused on PLC (Programmable Logic Controller) programming and automation tasks.

## Overview

**PlcTools** aims to provide a modular and extensible set of utilities to assist engineers and developers working with industrial automation systems. The tools in this section are designed to simplify common tasks such as data conversion, integration, and manipulation related to PLC programming environments.

## Structure

Each tool or module is organized in its own subfolder within `PlcTools`. For example:

- [`RssToAcd`](RssToAcd/): A module for converting RSS files to ACD format using configurable regular expressions.

## Getting Started

1. Browse the available modules in this directory.
2. Refer to each module's README for specific usage instructions and requirements.
3. Modules can be imported and used individually as needed.

## Example Usage

```powershell
Import-Module .\RssToAcd\Format-RssToAcd.psm1

# Process a single file and create a backup
Format-RssToAcd -Path "C:\Temp\PlcFiles.xml" -Backup

# Process all .csv files in a directory, using a custom regex map, and suppress output
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.csv" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

## Contributing

Contributions are welcome! If you have ideas for new tools, improvements, or bug fixes, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](../../LICENSE) file for details.