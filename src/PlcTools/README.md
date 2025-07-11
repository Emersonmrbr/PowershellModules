# PlcTools

---

## English (en-US)

This section of the repository is dedicated to the development of PowerShell tools and modules focused on PLC (Programmable Logic Controller) programming and automation tasks.

### Overview

**PlcTools** aims to provide a modular and extensible set of utilities to assist engineers and developers working with industrial automation systems. The tools in this section are designed to simplify common tasks such as data conversion, integration, and manipulation related to PLC programming environments.

### Structure

Each tool or module is organized in its own subfolder within `PlcTools`. For example:

- [`Format-TextByRegex`](Format-TextByRegex/): A module for converting RSS files to ACD format using configurable regular expressions.

> **Note:**  
> Inside each module directory, you will find a dedicated `README.md` file that explains how to install the module and provides detailed usage instructions and examples.

### Getting Started

1. Browse the available modules in this directory.
2. Refer to each module's README for specific usage instructions and requirements.
3. Modules can be imported and used individually as needed.

### Example Usage

```powershell
Import-Module .\Format-TextByRegex\Format-TextByRegex.psm1

# Process a single file and create a backup
Format-TextByRegex -Path "C:\Temp\PlcFiles.xml" -Backup

# Process all .csv files in a directory, using a custom regex map, and suppress output
Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.csv" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

### Contributing

Contributions are welcome! If you have ideas for new tools, improvements, or bug fixes, please open an issue or submit a pull request.

### License

This project is licensed under the MIT License. See the [LICENSE](../../LICENSE) file for details.

---

## Português (pt-BR)

Esta seção do repositório é dedicada ao desenvolvimento de ferramentas e módulos PowerShell focados em programação e automação de CLPs (Controladores Lógicos Programáveis).

### Visão Geral

O **PlcTools** tem como objetivo fornecer um conjunto modular e extensível de utilitários para auxiliar engenheiros e desenvolvedores que atuam com sistemas de automação industrial. As ferramentas desta seção foram criadas para simplificar tarefas comuns como conversão de dados, integração e manipulação relacionadas ao ambiente de programação de CLPs.

### Estrutura

Cada ferramenta ou módulo está organizada em sua própria subpasta dentro de `PlcTools`. Por exemplo:

- [`Format-TextByRegex`](Format-TextByRegex/): Um módulo para converter arquivos RSS para o formato ACD usando expressões regulares configuráveis.

> **Nota:**  
> Dentro de cada diretório de módulo, você encontrará um arquivo `README.md` dedicado que explica como instalar o módulo e fornece instruções detalhadas de uso e exemplos.

### Como começar

1. Navegue pelos módulos disponíveis neste diretório.
2. Consulte o README de cada módulo para instruções específicas de uso e requisitos.
3. Os módulos podem ser importados e utilizados individualmente conforme a necessidade.

### Exemplo de uso

```powershell
Import-Module .\Format-TextByRegex\Format-TextByRegex.psm1

# Processar um único arquivo e criar um backup
Format-TextByRegex -Path "C:\Temp\PlcFiles.xml" -Backup

# Processar todos os arquivos .csv em um diretório, usando um regex map personalizado e suprimindo a saída
Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.csv" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

### Contribuição

Contribuições são bem-vindas! Se você tem ideias para novas ferramentas, melhorias ou correções de bugs, por favor abra uma issue ou envie um pull request.

### Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](../../LICENSE) para mais detalhes.
