# 📦 Format-RssToAcd

Ferramenta PowerShell para realizar substituições em massa em arquivos XML usando expressões regulares pré-configuradas.  
Ideal para automatizar ajustes de versões, autores, datas e demais campos em arquivos de configuração RSS para sistemas ACD.

---

## 📋 Pré-requisitos

- **Windows PowerShell 5.1** ou superior
- Permissão para execução de scripts (`Set-ExecutionPolicy RemoteSigned` ou equivalente)

---

## 📦 Instalação

Clone este repositório ou baixe os arquivos diretamente.

Copie a pasta `Format-RssToAcd` contendo os seguintes arquivos para:

```
C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
```

**Conteúdo da pasta:**

```
Format-RssToAcd\
├── Format-RssToAcd.psm1
├── Format-RssToAcd.psd1
├── RegexMap.json
└── Install-Format-RssToAcd.ps1
```

Para instalar via script:

```powershell
.\Install-Format-RssToAcd.ps1
```

---

## 🚀 Como usar

Importe o módulo:

```powershell
Import-Module Format-RssToAcd
```

Execute a função passando o arquivo XML a ser processado:

```powershell
Format-RssToAcd -FilePath "C:\Caminho\Para\config.xml" -CreateBackup
```

**Parâmetros:**

- `-FilePath` (obrigatório) — caminho completo do arquivo XML
- `-CreateBackup` (opcional) — cria um arquivo `.bak` antes de sobrescrever

---

## 📑 Configurando RegexMap.json

Todas as expressões regulares e substituições são configuradas no arquivo `RegexMap.json`, no mesmo diretório do módulo.

**Exemplo:**

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

Você pode adicionar ou remover padrões conforme a necessidade.

---

## 📂 Estrutura de diretórios recomendada

```
C:\Users\<SeuUsuario>\Documents\WindowsPowerShell\Modules\
└── Format-RssToAcd\
    ├── Format-RssToAcd.psm1
    ├── Format-RssToAcd.psd1
    ├── RegexMap.json
    └── Install-Format-RssToAcd.ps1
```

---

## 📄 Licença

Este projeto está licenciado sob a [MIT License](https://opensource.org/licenses/MIT) — sinta-se livre para usar, modificar e distribuir.

---

## 👨‍💻 Autor

**Emerson Brito**  
[LinkedIn](https://www.linkedin.com/in/seuusuario)
