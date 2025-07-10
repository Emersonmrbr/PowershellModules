# Clear-Temporary

## about_Clear-Temporary

# TOPIC

about_Clear-Temporary

# SHORT DESCRIPTION

Remove arquivos temporários de diretórios do sistema, executa opcionalmente a Limpeza de Disco e pode reiniciar ou desligar o computador.

# LONG DESCRIPTION

A função `Clear-Temporary` exclui arquivos temporários de diretórios padrão do Windows, executa opcionalmente o utilitário de Limpeza de Disco (`cleanmgr`) e pode reiniciar ou desligar o sistema após conclusão.

A exclusão de arquivos temporários é realizada com segurança com suporte a `ShouldProcess`. Você pode habilitar registro detalhado de contagens e tamanhos de arquivos por diretório e opcionalmente suprimir a saída para operação silenciosa.

## Optional Subtopics

# EXAMPLES

## Exemplo 1

```powershell
PS C:\> Clear-Temporary
```

Remove arquivos temporários das pastas temporárias do sistema e exibe mensagens padrão de sucesso.

## Exemplo 2

```powershell
PS C:\> Clear-Temporary -ClearDisk
```

Remove arquivos temporários e executa o utilitário de Limpeza de Disco do Windows.

## Exemplo 3

```powershell
PS C:\> Clear-Temporary -Restart
```

Remove arquivos temporários e reinicia o computador após um breve intervalo.

## Exemplo 4

```powershell
PS C:\> Clear-Temporary -Log
```

Remove arquivos temporários e registra detalhes para cada pasta em um arquivo no diretório TEMP do sistema.

## Exemplo 5

```powershell
PS C:\> Clear-Temporary -Quiet
```

Executa a operação suprimindo mensagens de saída padrão, exibindo apenas mensagens detalhadas.

# NOTE

- Requer privilégios administrativos para Limpeza de Disco, reinício e desligamento
- Utiliza `ShouldProcess` para confirmação antes de realizar operações destrutivas
- Arquivos de log são salvos no diretório TEMP do sistema como `Clear-Temporary.log`
- A pasta Prefetch não é mais processada para preservar a estabilidade do sistema
- O módulo suporta ajuda multilíngue (en-US e pt-BR)

# TROUBLESHOOTING NOTE

# SEE ALSO

[Remove-Item](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item)
[Get-ChildItem](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem)
[Measure-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object)
[Restart-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/restart-computer)
[Stop-Computer](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-computer)
[cleanmgr.exe](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cleanmgr)

# KEYWORDS
