---
external help file: Edit-PlcFile-help.xml
Module Name: Edit-PlcFile
online version:
schema: 2.0.0
---

# Edit-PlcFile

## SYNOPSIS

Converte arquivos no formato RSS (Rockwell Software) para o formato ACD (Allen-Bradley ControlLogix project) usando mapeamentos de expressões regulares personalizáveis.

## SYNTAX

```
Edit-PlcFile [-Path] <String> [-Backup] [-Extension] <string> [-RegexMapPath <string>] [-Quiet] [-Log] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

O módulo Edit-PlcFile fornece uma função para automatizar a conversão de arquivos do formato RSS para o formato ACD, comum em cenários de migração ou integração de CLPs. A função lê um conjunto de padrões e substituições de expressões regulares de um arquivo JSON (`RegexMap.json`) e os aplica aos arquivos de destino. A criação de backup é opcional antes das alterações. O módulo agora fornece saída detalhada, incluindo o total de substituições regex por arquivo e um resumo geral ao final da execução. Parâmetros adicionais como `-RegexMapPath`, `-Quiet`, `-Log` e `-ProgressAction` são suportados para maior flexibilidade e controle. Esta ferramenta é útil para engenheiros e desenvolvedores que trabalham com automação industrial e precisam modernizar ou migrar programas de CLP legados.

> [!NOTE]
> O arquivo `RegexMap.json` deve estar no mesmo diretório do módulo, a menos que um caminho personalizado seja especificado com `-RegexMapPath`. Cada entrada no JSON deve conter as propriedades `Pattern` e `Replacement`.

## EXAMPLES

### Example 1

```powershell
PS C:\> Edit-PlcFile -Path "C:\Temp\PlcFiles.xml"
```

Formata o arquivo `PlcFiles.xml`, aplica as substituições regex usando o RegexMap.json padrão e não cria backup. A função converte formatos como "{::[LinkName]B3:0/0}" para "{::[LinkName]B3[0].0}". Ao final, exibe o número de substituições realizadas.

### Example 2

```powershell
PS C:\> Edit-PlcFile -Path "C:\Temp\PlcFiles.xml" -Backup
```

Formata o arquivo `PlcFiles.xml`, aplica as substituições regex e cria um backup antes de realizar alterações.

### Example 3

```powershell
PS C:\> Edit-PlcFile -Path "C:\Temp\PlcFiles" -Extension "*.xml"
```

Processa todos os arquivos `.xml` no diretório `C:\Temp\PlcFiles`, aplica as substituições regex definidas no RegexMap.json e não cria backups. Útil para converter múltiplos arquivos de uma vez.

### Example 4

```powershell
PS C:\> Edit-PlcFile -Path "C:\Temp\PlcFiles" -Extension "*.txt"
```

Processa todos os arquivos `.txt` no diretório, aplicando as substituições regex.

### Example 5

```powershell
PS C:\> Edit-PlcFile -Path "C:\Temp\PlcFiles" -Extension "*.csv" -Backup
```

Processa todos os arquivos `.csv` no diretório, cria um backup para cada arquivo e aplica as substituições regex.

### Example 6

```powershell
PS C:\> Edit-PlcFile -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet
```

Processa todos os arquivos `.xml` no diretório usando um arquivo de regex personalizado e suprime a saída no host, retornando apenas o objeto de resultado.

### Example 7

```powershell
PS C:\> Edit-PlcFile -Path "C:\Temp\PlcFiles" -RegexMapPath "C:\Custom\RegexMap.json" -Quiet -Log
```

Processa todos os arquivos `.xml` no diretório usando um arquivo de regex personalizado, suprime a saída no host, retorna apenas o objeto de resultado e cria um arquivo de log salvo no mesmo diretório.

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
Aliases: Ex

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
Aliases: B

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
Aliases: R, RegexMap

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
Aliases: Q

Required: No
Position: Named
Default value: None
Accept pipeline input: No
Accept wildcard characters: No
```

### -Log

Cria um arquivo de log detalhado do processamento, salvo no mesmo diretório informado em `-Path` com o nome `Edit-PlcFile_<data>.log`.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: L

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

Retorna um array de objetos com detalhes sobre cada arquivo processado, incluindo caminho do arquivo, se foi alterado, o número de padrões regex aplicados (`RegexCount`), o total de substituições realizadas (`ReplacementCount`) e qualquer mensagem de erro caso o processamento falhe.

## NOTES

- O arquivo de log é salvo no mesmo diretório informado em `-Path`.
- O resumo final é exibido por padrão, exceto se `-Quiet` for usado.
- O módulo suporta help em múltiplos idiomas (en-US e pt-BR).
- Para uso avançado, consulte o README do módulo.

## RELATED LINKS
