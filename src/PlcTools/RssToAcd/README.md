# 📦 Format-RssToAcd

PowerShell tool for performing bulk replacements in XML files using pre-configured regular expressions.  
Ideal for automating updates of versions, authors, dates, and other fields in RSS configuration files for ACD systems.

---

## 📋 Prerequisites

- **Windows PowerShell 5.1** or higher
- Permission to run scripts (`Set-ExecutionPolicy RemoteSigned` or equivalent)

---

## 📦 Installation (Step-by-step)

1. **Download or Clone the Repository**

   Download this repository as a ZIP and extract, or use Git:

   ```powershell
   git clone https://github.com/Emersonmrbr/PowershellModules.git
   ```

2. **Copy the Module Folder**

   Copy the `Format-RssToAcd` folder (containing `Format-RssToAcd.psm1`, `Format-RssToAcd.psd1`, `RegexMap.json`, `README.md`, etc.) to your PowerShell modules directory:

   ```
   C:\Users\<YourUser>\Documents\WindowsPowerShell\Modules\
   ```

   The final structure should look like:

   ```
   C:\Users\<YourUser>\Documents\WindowsPowerShell\Modules\
   └── Format-RssToAcd\
       ├── Format-RssToAcd.psm1
       ├── Format-RssToAcd.psd1
       ├── RegexMap.json
       ├── Install-Format-RssToAcd.ps1
       └── README.md
   ```

3. **(Optional) Install via Script**

   If provided, you can run the install script:

   ```powershell
   .\Install-Format-RssToAcd.ps1
   ```

4. **Import the Module**

   Open a new PowerShell session and run:

   ```powershell
   Import-Module Format-RssToAcd
   ```

---

## 🚀 How to use

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

---

## 🧑‍💻 Usage Examples

### Example 1

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles.xml"
```
Formats the file `PlcFiles.xml` using the default RegexMap.json, without creating a backup.

### Example 2

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles.xml" -Backup
```
Formats the file `PlcFiles.xml` and creates a backup before making changes.

### Example 3

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```
Processes all `.xml` files in the directory, applying the regex replacements.

### Example 4

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```
Processes all `.txt` files in the directory, applying the regex replacements.

### Example 5

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```
Processes all `.csv` files in the directory, creating a backup for each file.

### Example 6

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```
Processes all `.xml` files in the directory using a custom regex map file and suppresses output to the host, returning only the result object.

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

## 📄 License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) — feel free to use, modify, and distribute.

---

## 👨‍💻 Author

**Emerson Brito**  
[LinkedIn](https://www.linkedin.com/in/emersonbrito)