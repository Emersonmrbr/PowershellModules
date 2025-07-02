# 📦 Format-RssToAcd

PowerShell tool for performing bulk replacements in XML files using pre-configured regular expressions.  
Ideal for automating updates of versions, authors, dates, and other fields in RSS configuration files for ACD systems.

---

## 📋 Prerequisites

- **Windows PowerShell 5.1** or higher
- Permission to run scripts (`Set-ExecutionPolicy RemoteSigned` or equivalent)

---

## 📦 Installation

Clone this repository or download the files directly.

Copy the `Format-RssToAcd` folder containing the following files to:

```
C:\Users\<YourUser>\Documents\WindowsPowerShell\Modules\
```

**Folder contents:**

```
Format-RssToAcd\
├── Format-RssToAcd.psm1
├── Format-RssToAcd.psd1
├── RegexMap.json
└── Install-Format-RssToAcd.ps1
```

To install via script:

```powershell
.\Install-Format-RssToAcd.ps1
```

---

## 🚀 How to use

Import the module:

```powershell
Import-Module Format-RssToAcd
```

Run the function, passing the file or directory to be processed:

```powershell
Format-RssToAcd -Path "C:\Path\To\File.xml" -Backup
```

**Parameters:**

- `-Path` (required) — full path to the file or directory to process
- `-Extension` (optional) — file extension filter when processing directories (default: `*.xml`)
- `-Backup` (optional) — creates a `.bak` file before overwriting
- `-RegexMapPath` (optional) — path to a custom RegexMap.json file
- `-Quiet` (optional) — suppresses output to the host, only returns the result object

**Examples:**

```powershell
# Process a single file and create a backup
Format-RssToAcd -Path "C:\Temp\PlcFiles.xml" -Backup

# Process all .csv files in a directory, using a custom regex map, and suppress output
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.csv" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

---

## 📑 Configuring RegexMap.json

All regular expressions and replacements are configured in the `RegexMap.json` file, located in the same directory as the module (or specify with `-RegexMapPath`).

**Example:**

```json
[
  {
    "Pattern": "\\{::\\[(\\w+)\\](\\w+):(\\d+)\\/(\\d+)\\}",
    "Replacement": "{::[$1]$2[$3].$4}"
  },
  {
    "Pattern": "\\{::\\[(\\w+)\\](\\w+):(\\d+)\\}",
    "Replacement": "{::[$1]$2[$3]}"
  },
  {
    "Pattern": "\\{::\\[(\\w+)\\](\\w+):(\\d+)\\.(\\w+)\\}",
    "Replacement": "{::[$1]$2[$3].$4}"
  }
]
```

You can add or remove patterns as needed.

---

## 📂 Recommended directory structure

```
C:\Users\<YourUser>\Documents\WindowsPowerShell\Modules\
└── Format-RssToAcd\
    ├── Format-RssToAcd.psm1
    ├── Format-RssToAcd.psd1
    ├── RegexMap.json
    └── Install-Format-RssToAcd.ps1
```

---

## 📄 License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) — feel free to use, modify, and distribute.

---

## 👨‍💻 Author

**Emerson Brito**
[LinkedIn](https://www.linkedin.com/in/emersonbrito)