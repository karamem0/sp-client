#Requires -Version 3.0

<#
  Remove-SPClientListItem.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientListItem {

<#
.SYNOPSIS
  Deletes the list item.
.DESCRIPTION
  The Remove-SPClientListItem function removes the list item from the list.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the list item to delete.
.PARAMETER ParentObject
  Indicates the list which the list item is contained.
.PARAMETER Identity
  Indicates the list item ID.
.EXAMPLE
  Remove-SPClientListItem $item
.EXAMPLE
  Remove-SPClientListItem $list -Identity 7
.EXAMPLE
  Remove-SPClientListItem $list -IdentityGuid "77DF0F67-9B13-4499-AC14-25EB18E1D3DA"
.INPUTS
  None or Microsoft.SharePoint.Client.ListItem or SPClient.SPClientListItemParentParameter
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientListItem.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.ListItem]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [SPClient.SPClientListItemParentParameter]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [int]
        $Identity
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('Id')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
            }
        } else {
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ParentObject.ClientObject.Path, `
                    'GetItemById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.ListItem($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
                trap {
                    throw 'The specified list item could not be found.'
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
