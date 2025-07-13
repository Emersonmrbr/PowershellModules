# 🧹 Clear-Temporary

---

## English - en-US

Command-line tool for PowerShell that automates temporary file cleanup and performs system maintenance tasks. Ideal for keeping the operating system optimized and quickly and safely freeing up disk space.

---

### 📋 Prerequisites

- **Windows PowerShell 5.1** or higher
- Permission to run scripts (`Set-ExecutionPolicy RemoteSigned` or equivalent)

---

### 📦 Installation (Step by step)

1. **Download or clone the repository**

   Download this repository as a ZIP and extract it, or use Git:

   ```powershell
   git clone https://github.com/Emersonmrbr/PowershellModules.git
   ```

2. **Copy the module folder**

   Copy the `Clear-Temporary` folder (containing `Clear-Temporary.psm1`, `Clear-Temporary.psd1`, `README.md`, etc.) to your PowerShell modules directory:

   ```
   C:\Users\<YourUsername>\Documents\WindowsPowerShell\Modules\
   ```

   The final structure should look like this:

   ```
   C:\Users\<YourUsername>\Documents\WindowsPowerShell\Modules\
   └── Clear-Temporary\
       ├── Clear-Temporary.psm1
       ├── Clear-Temporary.psd1
       ├── Install-Clear-Temporary.ps1
       └── README.md
   ```

3. **(Optional) Install via script**

   If you wish, run the installation script:

   ```powershell
   .\Install-Clear-Temporary.ps1
   ```

4. **Import the module**

   Open a new PowerShell session and run:

   ```powershell
   Import-Module Clear-Temporary
   ```

---

### 🚀 How to use

Run the main function Clear-Temporary, adding the desired parameters to customize the cleanup operation.

```powershell
Clear-Temporary -ClearDisk -Log -Quiet
```

**Parameters:**

- `-Quiet` (Alias: -Q): Suppresses status messages in the console, displaying only the final result.
- `-Log` (Alias: -L): Creates a detailed log file in the %TEMP% directory with the cleanup results.
- `-Restart` (Alias: -R): Automatically restarts the computer after cleanup completion. A 10-second countdown will occur.
- `-Shutdown` (Alias: -S): Automatically shuts down the computer after cleanup completion. A 10-second countdown will occur.
- `-ClearDisk` (Alias: -C): Runs the Windows Disk Cleanup tool (cleanmgr.exe) with a full set of options for deep cleaning.

---

### 🧑‍💻 Usage examples

#### Example 1

```powershell
Clear-Temporary
```

Cleans temporary directories (%TEMP% and C:\Windows\Temp) and displays the results in the console.

#### Example 2

```powershell
Clear-Temporary -ClearDisk -Log
```

Performs standard cleanup, runs Windows Disk Cleanup, and saves a report to a log file.

#### Example 3

```powershell
Clear-Temporary -Quiet -Restart
```

Cleans all temporary files without displaying messages in the console and restarts the computer at the end.

#### Example 4

```powershell
Clear-Temporary -ClearDisk -Log -Shutdown
```

Performs standard cleanup and Disk Cleanup, generates a log, and shuts down the computer. Ideal for running at the end of the day.

---

### 📄 License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) — feel free to use, modify, and distribute it.

---

### 👨‍💻 Author

**Emerson Brito**  
[LinkedIn](https://www.linkedin.com/in/emersonbrito)

# 🧹 Clear-Temporary

---

## Português - pt-BR

Ferramenta de linha de comando para PowerShell que automatiza a limpeza de arquivos temporários e executa tarefas de manutenção do sistema. Ideal para manter o sistema operacional otimizado e liberar espaço em disco de forma rápida e segura.

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

   Copie a pasta `Clear-Temporary` (contendo `Clear-Temporary.psm1`, `Clear-Temporary.psd1`, `README.md`, etc.) para o diretório de módulos do PowerShell:

   ```
   C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
   ```

   A estrutura final deve ficar assim:

   ```
   C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
   └── Clear-Temporary\
       ├── Clear-Temporary.psm1
       ├── Clear-Temporary.psd1
       ├── Install-Clear-Temporary.ps1
       └── README.md
   ```

3. **(Opcional) Instale via script**

   Se desejar, execute o script de instalação:

   ```powershell
   .\Install-Clear-Temporary.ps1
   ```

4. **Importe o módulo**

   Abra uma nova sessão do PowerShell e execute:

   ```powershell
   Import-Module Clear-Temporary
   ```

---

### 🚀 Como usar

Execute a função principal Clear-Temporary, adicionando os parâmetros desejados para customizar a operação de limpeza.

```powershell
Clear-Temporary -ClearDisk -Log -Quiet
```

**Parâmetros:**

- `-Quiet` (Alias: -Q): Suprime as mensagens de status no console, exibindo apenas o resultado final.
- `-Log` (Alias: -L): Cria um arquivo de log detalhado no diretório %TEMP% com os resultados da limpeza.
- `-Restart` (Alias: -R): Reinicia o computador automaticamente após a conclusão da limpeza. Haverá uma contagem regressiva de 10 segundos.
- `-Shutdown` (Alias: -S): Desliga o computador automaticamente após a conclusão da limpeza. Haverá uma contagem regressiva de 10 segundos.
- `-ClearDisk` (Alias: -C): Executa a ferramenta de Limpeza de Disco do Windows (cleanmgr.exe) com um conjunto completo de opções para uma limpeza profunda.

---

### 🧑‍💻 Exemplos de uso

#### Exemplo 1

```powershell
Clear-Temporary
```

Limpa os diretórios temporários (%TEMP% e C:\Windows\Temp) e exibe os resultados no console.

#### Exemplo 2

```powershell
Clear-Temporary -ClearDisk -Log
```

Executa a limpeza padrão, roda a Limpeza de Disco do Windows e salva um relatório em um arquivo de log.

#### Exemplo 3

```powershell
Clear-Temporary -Quiet -Restart
```

Limpa todos os arquivos temporários sem exibir mensagens no console e reinicia o computador ao final.

#### Exemplo 4

```powershell
Clear-Temporary -ClearDisk -Log -Shutdown
```

Executa a limpeza padrão e a Limpeza de Disco, gera um log e desliga o computador. Ideal para executar ao final do dia.

---

### 📄 Licença

Este projeto está licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT) — sinta-se à vontade para usar, modificar e distribuir.

---

### 👨‍💻 Autor

**Emerson Brito**  
[LinkedIn](https://www.linkedin.com/in/emersonbrito)
