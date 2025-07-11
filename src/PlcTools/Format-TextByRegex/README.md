# 📦 Format-TextByRegex

---

## English (en-US)

PowerShell tool for performing bulk replacements in XML files using pre-configured regular expressions.  
Ideal for automating updates of versions, authors, dates, and other fields in RSS configuration files for ACD systems.

---

### 📋 Prerequisites

- **Windows PowerShell 5.1** or higher
- Permission to run scripts (`Set-ExecutionPolicy RemoteSigned` or equivalent)

---

### 📦 Installation (Step-by-step)

1. **Download or Clone the Repository**

   Download this repository as a ZIP and extract, or use Git:

   ```powershell
   git clone https://github.com/Emersonmrbr/PowershellModules.git
   ```

2. **Copy the Module Folder**

   Copy the `Format-TextByRegex` folder (containing `Format-TextByRegex.psm1`, `Format-TextByRegex.psd1`, `RegexMap.json`, `README.md`, etc.) to your PowerShell modules directory:

   ```
   C:\Users\<YourUser>\Documents\WindowsPowerShell\Modules\
   ```

   The final structure should look like:

   ```
   C:\Users\<YourUser>\Documents\WindowsPowerShell\Modules\
   └── Format-TextByRegex\
       ├── Format-TextByRegex.psm1
       ├── Format-TextByRegex.psd1
       ├── RegexMap.json
       ├── Install-Format-TextByRegex.ps1
       └── README.mdE
   ```

3. **(Optional) Install via Script**

   If provided, you can run the install script:

   ```powershell
   .\Install-Format-TextByRegex.ps1
   ```

4. **Import the Module**

   Open a new PowerShell session and run:

   ```powershell
   Import-Module Format-TextByRegex
   ```

---

### 🚀 How to use

Run the function, passing the file or directory to be processed:

```powershell
Format-TextByRegex -Path "C:\Path\To\File.xml" -Backup
```

**Parameters:**

- `-Path` (required) — full path to the file or directory to process
- `-Extension` (optional) — file extension filter when processing directories (default: `*.xml`)
- `-Backup` (optional) — creates a `.bak` file before overwriting
- `-RegexMapPath` (optional) — path to a custom RegexMap.json file
- `-Quiet` (optional) — suppresses output to the host, only returns the result object

---

### 🧑‍💻 Usage Examples

##### Examplo 1

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml"
```

Formats the file `PlcFiles.xml`, applies the regex replacements using the default RegexMap.json, and does not create a backup. The function will convert formats like "{::[LinkName]B3:0/0}" to "{::[LinkName]B3[0].0}". At the end, it displays the number of replacements made.

##### Examplo 2

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml" -Backup
```

Formats the file `PlcFiles.xml`, applies the regex replacements, and creates a backup before making changes.

##### Examplo 3

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```

Processes all `.xml` files in the `C:\Temp\PlcFiles` directory, applies the regex replacements defined in RegexMap.json, and does not create backups. Useful for converting multiple files at once.

##### Examplo 4

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```

Processes all `.txt` files in the directory, applying the regex replacements.

##### Examplo 5

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```

Processes all `.csv` files in the directory, creates a backup for each file, and applies the regex replacements.

##### Examplo 6

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

Processes all `.xml` files in the directory using a custom regex map file and suppresses output to the host, returning only the result object.

##### Examplo 7

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet -Log
```

Processes all `.xml` files in the directory using a custom regex map file, suppresses output to the host, returns only the result object, and creates a log file saved in the same directory.

---

### 📑 Configuring RegexMap.json

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

### 📄 License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) — feel free to use, modify, and distribute.

---

### 👨‍💻 Author

**Emerson Brito**  
[LinkedIn](https://www.linkedin.com/in/emersonbrito)

---

---

# 📦 Format-TextByRegex (Português - pt-BR)

Ferramenta PowerShell para realizar substituições em massa em arquivos XML usando expressões regulares pré-configuradas.  
Ideal para automatizar atualizações de versões, autores, datas e outros campos em arquivos de configuração RSS para sistemas ACD.

---

### 📋 Pré-requisitos

- **Windows PowerShell 5.1** ou superior
- Permissão para executar scripts (`Set-ExecutionPolicy RemoteSigned` ou equivalente)

---

### 📦 Instalação (Passo a passo)

1. **Baixe ou clone o repositório**

   Baixe este repositório como ZIP e extraia, ou use Git:

   ```powershell
   git clone https://github.com/Emersonmrbr/PowershellModules.git
   ```

2. **Copie a pasta do módulo**

   Copie a pasta `Format-TextByRegex` (contendo `Format-TextByRegex.psm1`, `Format-TextByRegex.psd1`, `RegexMap.json`, `README.md`, etc.) para o diretório de módulos do PowerShell:

   ```
   C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
   ```

   A estrutura final deve ficar assim:

   ```
   C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
   └── Format-TextByRegex\
       ├── Format-TextByRegex.psm1
       ├── Format-TextByRegex.psd1
       ├── RegexMap.json
       ├── Install-Format-TextByRegex.ps1
       └── README.md
   ```

3. **(Opcional) Instale via script**

   Se desejar, execute o script de instalação:

   ```powershell
   .\Install-Format-TextByRegex.ps1
   ```

4. **Importe o módulo**

   Abra uma nova sessão do PowerShell e execute:

   ```powershell
   Import-Module Format-TextByRegex
   ```

---

### 🚀 Como usar

Execute a função, informando o arquivo ou diretório a ser processado:

```powershell
Format-TextByRegex -Path "C:\Caminho\Para\Arquivo.xml" -Backup
```

**Parâmetros:**

- `-Path` (obrigatório) — caminho completo do arquivo ou diretório a ser processado
- `-Extension` (opcional) — filtro de extensão ao processar diretórios (padrão: `*.xml`)
- `-Backup` (opcional) — cria um arquivo `.bak` antes de sobrescrever
- `-RegexMapPath` (opcional) — caminho para um arquivo RegexMap.json personalizado
- `-Quiet` (opcional) — suprime a saída no host, retornando apenas o objeto de resultado

---

### 🧑‍💻 Exemplos de uso

#### Examplo 1

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml"
```

Formata o arquivo `PlcFiles.xml`, aplica as substituições regex usando o RegexMap.json padrão e não cria backup. A função converte formatos como "{::[LinkName]B3:0/0}" para "{::[LinkName]B3[0].0}". Ao final, exibe o número de substituições realizadas.

#### Examplo 2

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml" -Backup
```

Formata o arquivo `PlcFiles.xml`, aplica as substituições regex e cria um backup antes de realizar alterações.

#### Examplo 3

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```

Processa todos os arquivos `.xml` no diretório `C:\Temp\PlcFiles`, aplica as substituições regex definidas no RegexMap.json e não cria backups. Útil para converter múltiplos arquivos de uma vez.

#### Examplo 4

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```

Processa todos os arquivos `.txt` no diretório, aplicando as substituições regex.

#### Examplo 5

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```

Processa todos os arquivos `.csv` no diretório, cria um backup para cada arquivo e aplica as substituições regex.

#### Examplo 6

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

Processa todos os arquivos `.xml` no diretório usando um arquivo de regex personalizado e suprime a saída no host, retornando apenas o objeto de resultado.

#### Examplo 7

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet -Log
```

Processa todos os arquivos `.xml` no diretório usando um arquivo de regex personalizado, suprime a saída no host, retorna apenas o objeto de resultado e cria um arquivo de log salvo no mesmo diretório.

---

### 📑 Configurando o RegexMap.json

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

### 📄 Licença

Este projeto está licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT) — sinta-se à vontade para usar, modificar e distribuir.

---

### 👨‍💻 Autor

**Emerson Brito**  
[LinkedIn](https://www.linkedin.com/in/emersonbrito)
