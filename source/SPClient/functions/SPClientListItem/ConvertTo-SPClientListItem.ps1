#Requires -Version 3.0

<#
  ConvertTo-SPClientListItem.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function ConvertTo-SPClientListItem {

<#
.SYNOPSIS
  Converts file or folder to list item.
.DESCRIPTION
  The ConvertTo-SPClientListItem function converts the file or folder to list item.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER InputObject
  Indicates the file or folder.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  ConvertTo-SPClientListItem $file
.EXAMPLE
  ConvertTo-SPClientListItem $folder
.INPUTS
  None or SPClient.SPClientListItemConvertParameter
.OUTPUTS
  Microsoft.SharePoint.Client.ListItem
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientListItem.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientListItemConvertParameter]
        $InputObject,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObject = $InputObject.ClientObject.ListItemAllFields
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
