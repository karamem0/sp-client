#Requires -Version 3.0

<#
  ConvertTo-SPClientFile.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function ConvertTo-SPClientFile {

<#
.SYNOPSIS
  Converts list item to file.
.DESCRIPTION
  The ConvertTo-SPClientFile function converts the list item to file.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER InputObject
  Indicates the list item.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  ConvertTo-SPClientFile $item
.INPUTS
  None or SPClient.SPClientFileConvertParameter
.OUTPUTS
  Microsoft.SharePoint.Client.File
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientFile.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFileConvertParameter]
        $InputObject,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObject = $InputObject.ClientObject.File
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        if ($ClientObject.ServerObjectIsNull) {
            throw 'Cannot convert list item to file because it is a folder or it is located in a document library.'
        }
        Write-Output $ClientObject
    }

}
