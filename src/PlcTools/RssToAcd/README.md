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

---

---

# 📦 Format-RssToAcd (pt-br)

Ferramenta PowerShell para realizar substituições em massa em arquivos XML usando expressões regulares pré-configuradas.  
Ideal para automatizar atualizações de versões, autores, datas e outros campos em arquivos de configuração RSS para sistemas ACD.

---

## 📋 Pré-requisitos

- **Windows PowerShell 5.1** ou superior
- Permissão para executar scripts (`Set-ExecutionPolicy RemoteSigned` ou equivalente)

---

## 📦 Instalação (Passo a passo)

1. **Baixe ou clone o repositório**

   Baixe este repositório como ZIP e extraia, ou use Git:

   ```powershell
   git clone https://github.com/Emersonmrbr/PowershellModules.git
   ```

2. **Copie a pasta do módulo**

   Copie a pasta `Format-RssToAcd` (contendo `Format-RssToAcd.psm1`, `Format-RssToAcd.psd1`, `RegexMap.json`, `README.md`, etc.) para o diretório de módulos do PowerShell:

   ```
   C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
   ```

   A estrutura final deve ficar assim:

   ```
   C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
   └── Format-RssToAcd\
       ├── Format-RssToAcd.psm1
       ├── Format-RssToAcd.psd1
       ├── RegexMap.json
       ├── Install-Format-RssToAcd.ps1
       └── README.md
   ```

3. **(Opcional) Instale via script**

   Se desejar, execute o script de instalação:

   ```powershell
   .\Install-Format-RssToAcd.ps1
   ```

4. **Importe o módulo**

   Abra uma nova sessão do PowerShell e execute:

   ```powershell
   Import-Module Format-RssToAcd
   ```

---

## 🚀 Como usar

Execute a função, informando o arquivo ou diretório a ser processado:

```powershell
Format-RssToAcd -Path "C:\Caminho\Para\Arquivo.xml" -Backup
```

**Parâmetros:**

- `-Path` (obrigatório) — caminho completo do arquivo ou diretório a ser processado
- `-Extension` (opcional) — filtro de extensão ao processar diretórios (padrão: `*.xml`)
- `-Backup` (opcional) — cria um arquivo `.bak` antes de sobrescrever
- `-RegexMapPath` (opcional) — caminho para um arquivo RegexMap.json personalizado
- `-Quiet` (opcional) — suprime a saída no host, retornando apenas o objeto de resultado

---

## 🧑‍💻 Exemplos de uso

### Exemplo 1

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles.xml"
```
Formata o arquivo `PlcFiles.xml` usando o RegexMap.json padrão, sem criar backup.

### Exemplo 2

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles.xml" -Backup
```
Formata o arquivo `PlcFiles.xml` e cria um backup antes de alterar.

### Exemplo 3

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```
Processa todos os arquivos `.xml` no diretório, aplicando as substituições regex.

### Exemplo 4

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```
Processa todos os arquivos `.txt` no diretório, aplicando as substituições regex.

### Exemplo 5

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```
Processa todos os arquivos `.csv` no diretório, criando backup para cada arquivo.

### Exemplo 6

```powershell
Format-RssToAcd -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```
Processa todos os arquivos `.xml` no diretório usando um arquivo de regex personalizado e suprime a saída no host, retornando apenas o objeto de resultado.

---

## 📑 Configurando o RegexMap.json

Todas as expressões regulares e substituições são configuradas no arquivo `RegexMap.json`, localizado no mesmo diretório do módulo (ou especifique com `-RegexMapPath`).

**Exemplo:**

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

Você pode adicionar ou remover padrões conforme necessário.

---

## 📄 Licença

Este projeto está licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT) — sinta-se à vontade para usar, modificar e distribuir.

---

## 👨‍💻 Autor

**Emerson Brito**  
[LinkedIn](https://www.linkedin.com/in/emersonbrito)