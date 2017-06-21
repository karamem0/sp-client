#Requires -Version 3.0

<#
  New-SPClientListItem.ps1

  Copyright (c) 2017 karamem0

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
#>

function New-SPClientListItem {

<#
.SYNOPSIS
  Creates a new list item.
.DESCRIPTION
  The New-SPClientListItem function adds a new list item to the list.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentList
  Indicates the list which a list item to be created.
.PARAMETER FieldValues
  Indicates the field key/value collection.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientListItem $list -FieldValues @{ Title = "Custom List Item" }
.INPUTS
  None or Microsoft.SharePoint.Client.List
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
        [Microsoft.SharePoint.Client.List]
        $ParentList,
        [Parameter(Mandatory = $false)]
        [hashtable]
        $FieldValues,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
        $ClientObject = $ParentList.AddItem($Creation)
        if ($PSBoundParameters.ContainsKey('FieldValues')) {
            foreach ($FieldValue in $FieldValues.GetEnumerator()) {
                $ClientObject[$FieldValue.Name] = $FieldValue.Value
            }
        }
        $ClientObject.Update()
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
