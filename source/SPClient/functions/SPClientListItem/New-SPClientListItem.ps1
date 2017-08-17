#Requires -Version 3.0

<#
  New-SPClientListItem.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientListItem {

<#
.SYNOPSIS
  Creates a new list item.
.DESCRIPTION
  The New-SPClientListItem function adds a new list item to the list.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the list which a list item to be created.
.PARAMETER FieldValues
  Indicates the column key/value collection.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientListItem $list -FieldValues @{ Title = "Custom List Item" }
.INPUTS
  None or SPClient.SPClientListItemParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.ListItem
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientListItem.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientListItemParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $false)]
        [hashtable]
        $FieldValues,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
        $ClientObject = $ParentObject.ClientObject.AddItem($Creation)
        if ($PSBoundParameters.ContainsKey('FieldValues')) {
            foreach ($FieldValue in $FieldValues.GetEnumerator()) {
                $ClientObject[$FieldValue.Name] = $FieldValue.Value
            }
        }
        $ClientObject.Update()
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
