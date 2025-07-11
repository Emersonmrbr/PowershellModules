# PowershellModules

---

## English (en-US)

**PowershellModules** is an open and modular project aimed at bringing together various PowerShell modules focused on automation, integration, and data manipulation in industrial environments, especially related to PLCs (Programmable Logic Controllers).

### Overview

This repository serves as a central point for the development and distribution of PowerShell modules that facilitate common tasks in the context of industrial automation. The idea is to continuously expand the project by adding new modules as needs and community suggestions arise.

### Project Structure

The repository is organized into subfolders, each representing a specific PowerShell module or tool. For example:

- [`PlcTools`](src/PlcTools): A collection of PowerShell tools and modules focused on PLC programming and automation tasks.
  - [`Format-TextByRegex`](src/PlcTools/Format-TextByRegex): A module for converting RSS files to ACD format using configurable regular expressions.
- [ÙtilityTools`](src/UtilityTools): A collection of PowerShell tools and modules focused on automation tasks.
  - [`Clean-Temporary`](src/UtilityTools/Clear-Temporary): A module for clean the temporary files from system.

Each module contains its own scripts, manifests, documentation, and configuration files.

> **Note:**  
> Inside each module's folder, you will find a dedicated documentation file (usually `README.md`) that explains how to install the module and provides detailed usage instructions and examples.

### How to contribute

Feel free to suggest new modules, report issues, or submit pull requests. The goal is to create a robust and useful collection of PowerShell tools for industrial automation.

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## Português (pt-BR)

**PowershellModules** é um projeto aberto e modular que reúne diversos módulos PowerShell voltados para automação, integração e manipulação de dados em ambientes industriais, especialmente relacionados a CLPs (Controladores Lógicos Programáveis).

### Visão Geral

Este repositório serve como ponto central para o desenvolvimento e distribuição de módulos PowerShell que facilitam tarefas comuns no contexto da automação industrial. A ideia é expandir continuamente o projeto, adicionando novos módulos conforme necessidades e sugestões da comunidade.

### Estrutura do Projeto

O repositório é organizado em subpastas, cada uma representando um módulo ou ferramenta PowerShell específica. Por exemplo:

- [`PlcTools`](src/PlcTools): Uma coleção de ferramentas e módulos PowerShell focados em programação de CLPs e tarefas de automação.
  - [`Format-TextByRegex`](src/PlcTools/Format-TextByRegex): Um módulo para converter arquivos RSS para o formato ACD usando expressões regulares configuráveis.
- [ÙtilityTools`](src/UtilityTools): Uma coleção de ferraments e módulos PowerShell focados em tarefas de automação.
  - [`Clean-Temporary`](src/UtilityTools/Clear-Temporary): Um módulo para limpar os arquivos temprarios do sistema.

Cada módulo contém seus próprios scripts, manifestos, documentação e arquivos de configuração.

> **Nota:**  
> Dentro da pasta de cada módulo, você encontrará um arquivo de documentação dedicado (geralmente `README.md`) que explica como instalar o módulo e fornece instruções detalhadas de uso e exemplos.

### Como contribuir

Sinta-se à vontade para sugerir novos módulos, relatar problemas ou enviar pull requests. O objetivo é criar uma coleção robusta e útil de ferramentas PowerShell para automação industrial.

### Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
