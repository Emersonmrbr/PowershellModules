# Format-TextByRegex

## about_Format-TextByRegex

# TOPIC

about_Format-TextByRegex

# SHORT DESCRIPTION

Converte arquivos no formato RSS (Rockwell Software) para o formato ACD (Allen-Bradley ControlLogix project) usando mapeamentos de expressões regulares personalizáveis.

# LONG DESCRIPTION

O módulo Format-TextByRegex fornece uma função para automatizar a conversão de arquivos do formato RSS para o formato ACD, comum em cenários de migração ou integração de CLPs. A função lê um conjunto de padrões e substituições de expressões regulares de um arquivo JSON (`RegexMap.json`) e os aplica aos arquivos de destino. A criação de backup é opcional antes das alterações. O módulo agora fornece saída detalhada, incluindo o total de substituições regex por arquivo e um resumo geral ao final da execução. Parâmetros adicionais como `-RegexMapPath`, `-Quiet`, `-Log` e `-ProgressAction` são suportados para maior flexibilidade e controle. Esta ferramenta é útil para engenheiros e desenvolvedores que trabalham com automação industrial e precisam modernizar ou migrar programas de CLP legados.

> [!NOTE]
> O arquivo `RegexMap.json` deve estar no mesmo diretório do módulo, a menos que um caminho personalizado seja especificado com `-RegexMapPath`. Cada entrada no JSON deve conter as propriedades `Pattern` e `Replacement`.

## Optional Subtopics

{{ Optional Subtopic Placeholder }}

# EXAMPLES

## Example 1

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml"
```

Formata o arquivo `PlcFiles.xml`, aplica as substituições regex usando o RegexMap.json padrão e não cria backup. A função converte formatos como "{::[LinkName]B3:0/0}" para "{::[LinkName]B3[0].0}". Ao final, exibe o número de substituições realizadas.

## Example 2

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles.xml" -Backup
```

Formata o arquivo `PlcFiles.xml`, aplica as substituições regex e cria um backup antes de realizar alterações.

## Example 3

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```

Processa todos os arquivos `.xml` no diretório `C:\Temp\PlcFiles`, aplica as substituições regex definidas no RegexMap.json e não cria backups. Útil para converter múltiplos arquivos de uma vez.

## Example 4

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```

Processa todos os arquivos `.txt` no diretório, aplicando as substituições regex.

## Example 5

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```

Processa todos os arquivos `.csv` no diretório, cria um backup para cada arquivo e aplica as substituições regex.

## Example 6

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

Processa todos os arquivos `.xml` no diretório usando um arquivo de regex personalizado e suprime a saída no host, retornando apenas o objeto de resultado.

## Example 7

```powershell
PS C:\> Format-TextByRegex -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet -Log
```

Processa todos os arquivos `.xml` no diretório usando um arquivo de regex personalizado, suprime a saída no host, retorna apenas o objeto de resultado e cria um arquivo de log salvo no mesmo diretório.

# NOTE

- O arquivo de log é salvo no mesmo diretório informado em `-Path`.
- O resumo final é exibido por padrão, exceto se `-Quiet` for usado.
- O módulo suporta help em múltiplos idiomas (en-US e pt-BR).
- Para uso avançado, consulte o README do módulo.

# TROUBLESHOOTING NOTE

# SEE ALSO

# KEYWORDS
