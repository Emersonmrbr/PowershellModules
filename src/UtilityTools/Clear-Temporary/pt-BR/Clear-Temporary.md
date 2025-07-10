---
external help file: Clear-Temporary-help.xml
Module Name: Clear-Temporary
online version:
schema: 2.0.0
---

# Clear-Temporary

## SYNOPSIS

Remove arquivos temporários de diretórios do sistema, opcionalmente executa a Limpeza de Disco e pode reiniciar ou desligar o computador.

## SYNTAX

```
Clear-Temporary [[-Quiet]] [[-Log]] [[-Restart]] [[-Shutdown]] [[-ClearDisk]] [<CommonParameters>]
```

## DESCRIPTION

A função `Clear-Temporary` exclui arquivos temporários dos diretórios padrão do Windows, opcionalmente executa o utilitário de Limpeza de Disco (`cleanmgr`) e pode reiniciar ou desligar o sistema após a conclusão.

## EXAMPLES

### Exemplo 1

```powershell
PS C:\> Clear-Temporary
```

Remove arquivos temporários das pastas temporárias do sistema e exibe mensagens padrão de sucesso.

### Exemplo 2

```powershell
PS C:\> Clear-Temporary -ClearDisk
```

Remove arquivos temporários e executa o utilitário de Limpeza de Disco do Windows.

### Exemplo 3

```powershell
PS C:\> Clear-Temporary -Restart
```

Remove arquivos temporários e reinicia o computador após um breve delay.

### Exemplo 4

```powershell
PS C:\> Clear-Temporary -Log
```

Remove arquivos temporários e registra detalhes para cada pasta em um arquivo no diretório TEMP do sistema.

### Exemplo 5

```powershell
PS C:\> Clear-Temporary -Quiet
```

Executa a operação suprimindo mensagens de saída padrão, exibindo apenas mensagens detalhadas.

## PARAMETERS

### -Quiet

Suprime as mensagens padrão exibidas pela função, mostrando apenas mensagens detalhadas.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Q
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Log

Gera um arquivo de log no diretório TEMP do sistema detalhando a quantidade e tamanho dos arquivos excluídos de cada diretório.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: L
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Restart

Reinicia o computador após limpar os arquivos temporários e (opcionalmente) executar a Limpeza de Disco.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: R
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Shutdown

Desliga o computador após limpar os arquivos temporários e (opcionalmente) executar a Limpeza de Disco.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: S
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClearDisk

Executa o utilitário de Limpeza de Disco do Windows (`cleanmgr.exe`) usando configurações predefinidas.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: C
Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

Este cmdlet suporta os parâmetros comuns: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction e -WarningVariable. Para mais informações, consulte [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

Este cmdlet não aceita entrada via pipeline.

## OUTPUTS

### Object[]

Retorna um array de objetos com detalhes sobre cada diretório processado, incluindo caminho, contagem de arquivos e tamanho total em megabytes.

## NOTES

- Requer privilégios administrativos para Limpeza de Disco, reinício e desligamento
- Utiliza `ShouldProcess` para confirmação antes de realizar operações destrutivas
- Arquivos de log são salvos no diretório TEMP do sistema como `Clear-Temporary.log`
- A pasta Prefetch não é mais processada para preservar a estabilidade do sistema
- O módulo suporta ajuda multilíngue (en-US e pt-BR)

## RELATED LINKS

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item)
[Get-ChildItem](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem)
[Measure-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object)
[Restart-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer)
[Stop-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-computer)
[cleanmgr.exe](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cleanmgr)
