---
external help file: Format-RssToAcd-help-pt-BR.xml
Module Name: Format-RssToAcd
online version:
schema: 2.0.0
---

# Format-RssToAcd

## SYNOPSIS

Converte arquivos no formato RSS (Rockwell Software) para o formato ACD (Allen-Bradley ControlLogix project) usando mapeamentos de expressões regulares personalizáveis.

## SYNTAX

```
Format-RssToAcd [-Path] <String> [-Backup] [-Extension] <string> [-RegexMapPath <string>] [-Quiet] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

O módulo Format-RssToAcd fornece uma função para automatizar a conversão de arquivos do formato RSS para o formato ACD, comum em cenários de migração ou integração de CLPs. A função lê um conjunto de padrões e substituições de expressões regulares de um arquivo JSON (`RegexMap.json`) e os aplica aos arquivos de destino. A criação de backup é opcional antes das alterações. Esta ferramenta é útil para engenheiros e desenvolvedores que trabalham com automação industrial e precisam modernizar ou migrar programas de CLP legados.

> [!NOTE]
> O arquivo `RegexMap.json` deve estar no mesmo diretório do módulo, a menos que um caminho personalizado seja especificado com `-RegexMapPath`. Cada entrada no JSON deve conter as propriedades `Pattern` e `Replacement`.

## EXAMPLES

### Example 1

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles.xml"
```

Este exemplo formata o arquivo `PlcFiles.xml`, altera o formato da variável de .rss para .acd, usa o RegexMap.json com a configuração padrão e não cria backup. Esta função converte formatos como "{::[LinkName]B3:0/0}" para "{::[LinkName]B3[0].0}".

### Example 2

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles.xml" -Backup
```

Este exemplo formata o arquivo `PlcFiles.xml`, altera o formato da variável de .rss para .acd, usa o RegexMap.json com a configuração padrão e cria um backup. Esta função converte formatos como "{::[LinkName]B3:0/0}" para "{::[LinkName]B3[0].0}".

### Example 3

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```

Este exemplo processa todos os arquivos `.xml` no diretório `C:\Temp\PlcFiles`, aplica as substituições regex definidas no RegexMap.json e não cria backups. Útil para converter múltiplos arquivos com uma extensão específica diferente de `.xml`.

### Example 4

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```

Este exemplo processa todos os arquivos `.txt` no diretório `C:\Temp\PlcFiles`, aplica as substituições regex definidas no RegexMap.json e não cria backups. Útil para converter múltiplos arquivos com uma extensão específica diferente de `.xml`.

### Example 5

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```

Este exemplo processa todos os arquivos `.csv` no diretório `C:\Temp\PlcFiles`, cria um backup para cada arquivo e aplica as substituições regex definidas no RegexMap.json.

### Example 6

```powershell
PS C:\> Format-RssToAcd -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

Este exemplo processa todos os arquivos `.xml` no diretório `C:\Temp\PlcFiles` usando um arquivo de regex personalizado e suprime a saída no host, retornando apenas o objeto de resultado.

## PARAMETERS

### -Path

Caminho completo para o arquivo a ser modificado ou para o diretório contendo os arquivos a serem processados.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: Yes
Position: 0
Default value: None
Accept pipeline input: No
Accept wildcard characters: No
```

### -Extension

Filtro de extensão de arquivo ao buscar arquivos em um diretório. O padrão é `*.xml`. Ignorado se `-Path` for um arquivo.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: No
Position: Named
Default value: *.xml
Accept pipeline input: No
Accept wildcard characters: No
```

### -Backup

Cria um backup do arquivo original com a extensão .bak antes de fazer alterações.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: No
Position: Named
Default value: None
Accept pipeline input: No
Accept wildcard characters: No
```

### -RegexMapPath

(Opcional) Caminho completo para um arquivo RegexMap.json personalizado. Se não especificado, usa o padrão do diretório do módulo.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: No
Position: Named
Default value: None
Accept pipeline input: No
Accept wildcard characters: No
```

### -Quiet

Suprime a saída no host. Retorna apenas o objeto de resultado.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: No
Position: Named
Default value: None
Accept pipeline input: No
Accept wildcard characters: No
```

### -ProgressAction

Determina como o PowerShell responde a atualizações de progresso geradas por scripts, cmdlets ou provedores, como as barras de progresso geradas pelo Write-Progress. O parâmetro ProgressAction foi adicionado no PowerShell 7.4.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: No
Position: Named
Default value: None
Accept pipeline input: No
Accept wildcard characters: No
```

### CommonParameters

Este cmdlet suporta os parâmetros comuns: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction e -WarningVariable. Para mais informações, veja [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Object[]

Retorna um array de objetos com detalhes sobre cada arquivo processado, incluindo caminho do arquivo, se foi alterado, quais padrões regex foram aplicados e qualquer mensagem de erro caso o processamento falhe.

## NOTES


## RELATED LINKS