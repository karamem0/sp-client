﻿#
# Module manifest for module 'SPClient'
#
# Generated by: karamem0
#
# Generated on: 
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = 'Module.psd1'

# Version number of this module.
ModuleVersion = '0.14'

# ID used to uniquely identify this module
GUID = '70F6C652-6C79-4B8B-B4A9-79635EA6AE9C'

# Author of this module
Author = 'karamem0'

# Company or vendor of this module
CompanyName = 'karamem0'

# Copyright statement for this module
Copyright = 'Copyright (c) 2017 karamem0'

# Description of the functionality provided by this module
Description = 'PowerShell module for SharePoint client-side object model'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
DotNetFrameworkVersion = '4.0'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '4.0.0.0'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('SPClient.psm1')

# Functions to export from this module
FunctionsToExport = @(
    'Get-SPClientAttachment'
    'New-SPClientAttachment'
    'Remove-SPClientAttachment'
    'Add-SPClientContentTypeField'
    'Get-SPClientContentType'
    'New-SPClientContentType'
    'Remove-SPClientContentType'
    'Remove-SPClientContentTypeField'
    'Connect-SPClientContext'
    'Disconnect-SPClientContext'
    'Convert-SPClientField'
    'Get-SPClientFeature'
    'Get-SPClientField'
    'New-SPClientFieldBoolean'
    'New-SPClientFieldCalculated'
    'New-SPClientFieldChoice'
    'New-SPClientFieldCurrency'
    'New-SPClientFieldDateTime'
    'New-SPClientFieldLookup'
    'New-SPClientFieldMultilineText'
    'New-SPClientFieldNumber'
    'New-SPClientFieldText'
    'New-SPClientFieldUrl'
    'Remove-SPClientField'
    'ConvertTo-SPClientFile'
    'Get-SPClientFile'
    'New-SPClientFile'
    'Remove-SPClientFile'
    'ConvertTo-SPClientFolder'
    'Get-SPClientFolder'
    'New-SPClientFolder'
    'Remove-SPClientFolder'
    'Get-SPClientGroup'
    'New-SPClientGroup'
    'Remove-SPClientGroup'
    'Get-SPClientList'
    'New-SPClientList'
    'Remove-SPClientList'
    'ConvertTo-SPClientListItem'
    'Get-SPClientListItem'
    'New-SPClientListItem'
    'Remove-SPClientListItem'
    'Debug-SPClientObject'
    'Clear-SPClientPermission'
    'Grant-SPClientPermission'
    'Revoke-SPClientPermission'
    'Use-SPClientType'
    'Disable-SPClientUniquePermission'
    'Enable-SPClientUniquePermission'
    'ConvertTo-SPClientAbsoluteUrl'
    'ConvertTo-SPClientRelativeUrl'
    'Get-SPClientUser'
    'New-SPClientUser'
    'Remove-SPClientUser'
    'Resolve-SPClientUser'
    'Get-SPClientView'
    'New-SPClientView'
    'Remove-SPClientView'
    'Get-SPClientWeb'
    'New-SPClientWeb'
    'Remove-SPClientWeb'
    'Get-SPClientWebTemplate'
)

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess
PrivateData = @{
    PSData = @{
        ProjectUri = 'https://github.com/karamem0/spclient'
        LicenseUri = 'https://github.com/karamem0/spclient/blob/master/LICENSE'
        Tags = @('SharePoint', 'CSOM')
    }
}

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
