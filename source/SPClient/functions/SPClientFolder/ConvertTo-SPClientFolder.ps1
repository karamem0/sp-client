#Requires -Version 3.0

<#
  ConvertTo-SPClientFolder.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function ConvertTo-SPClientFolder {

<#
.SYNOPSIS
  Converts list item to folder.
.DESCRIPTION
  The ConvertTo-SPClientFolder function converts the list item to folder.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER InputObject
  Indicates the list item.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  ConvertTo-SPClientFolder $item
.INPUTS
  None or SPClient.SPClientFolderConvertParameter
.OUTPUTS
  Microsoft.SharePoint.Client.Folder
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientFolder.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFolderConvertParameter]
        $InputObject,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObject = $InputObject.ClientObject.Folder
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        if ($ClientObject.ServerObjectIsNull) {
            throw 'Cannot convert list item to folder because it is not a folder.'
        }
        Write-Output $ClientObject
    }

}
