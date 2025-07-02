@{
    ModuleVersion     = '1.0.0'
    GUID              = 'f31f1e96-8f41-4379-930e-f1fae30e1b19'
    Author            = 'Emerson Brito'
    CompanyName       = 'Núcleo MAP'
    Copyright         = '(c) 2025 Emerson Brito. All rights reserved.'
    Description       = 'Tools for manipulating XML files using regex in PowerShell.'
    RootModule        = 'Format-RssToAcd.psm1'
    FunctionsToExport = @('Format-RssToAcd')
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PowerShellVersion = '7.5.2'
    PrivateData       = @{
        PSData = @{
            Tags       = @('XML', 'Regex', 'TextReplace', 'Automation')
            LicenseUri = 'https://opensource.org/licenses/MIT'
            ProjectUri = 'https://github.com/emersonmrbr/PlcTools'
        }
    }
}