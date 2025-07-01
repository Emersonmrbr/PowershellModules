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

Run the function, passing the XML file to be processed:

```powershell
Format-RssToAcd -FilePath "C:\Path\To\config.xml" -CreateBackup
```

**Parameters:**

- `-FilePath` (required) — full path to the XML file
- `-CreateBackup` (optional) — creates a `.bak` file before overwriting

---

## 📑 Configuring RegexMap.json

All regular expressions and replacements are configured in the `RegexMap.json` file, located in the same directory as the module.

**Example:**

```json
[
  {
    "Pattern": "<version>.*?</version>",
    "Replacement": "<version>2.0.0</version>"
  },
  {
    "Pattern": "<author>.*?</author>",
    "Replacement": "<author>Emerson Brito</author>"
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

## 👨‍💻 Author# 📦 Format-RssToAcd

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

Run the function, passing the XML file to be processed:

```powershell
Format-RssToAcd -FilePath "C:\Path\To\config.xml" -CreateBackup
```

**Parameters:**

- `-FilePath` (required) — full path to the XML file
- `-CreateBackup` (optional) — creates a `.bak` file before overwriting

---

## 📑 Configuring RegexMap.json

All regular expressions and replacements are configured in the `RegexMap.json` file, located in the same directory as the module.

**Example:**

```json
[
  {
    "Pattern": "<version>.*?</version>",
    "Replacement": "<version>2.0.0</version>"
  },
  {
    "Pattern": "<author>.*?</author>",
    "Replacement": "<author>Emerson Brito</author>"
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
