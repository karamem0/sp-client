#Requires -Version 3.0

<#
  Get-SPClientListItem.ps1

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

function Get-SPClientListItem {

<#
.SYNOPSIS
  Gets one or more list items.
.DESCRIPTION
  The Get-SPClientListItem function retrieves list items using CAML query.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentList
  Indicates the list which the list items are contained.
.PARAMETER FolderUrl
  Indicates the folder URL.
.PARAMETER Scope
  Indicates the scope of retrievals.
    - FilesOnly: Only the files of a specific folder. 
    - Recursive: All files of all folders. 
    - RecursiveAll: All files and all subfolders of all folders.
  If not specified, only the files and subfolders of a specific folder.
.PARAMETER ViewFields
  Indicates the collection of view fields.
.PARAMETER Query
  Indicates the XML representation of query.
.PARAMETER RowLimit
  Indicates the number of items. This parameter is used for item pagination.
.PARAMETER Position
  Indicates the starting position. This parameter is used for item pagination.
.PARAMETER Identity
  Indicates the list item ID.
.PARAMETER IdentityGuid
  Indicates the list item GUID.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientListItem
.EXAMPLE
  Get-SPClientListItem -Scope "Recursive" -ViewFields "ID", "Title" -Query "<OrderBy><FieldRef Name='Title'/></OrderBy>" -RowLimit 10
.EXAMPLE
  Get-SPClientListItem -Identity 7
.EXAMPLE
  Get-SPClientListItem -IdentityGuid "77DF0F67-9B13-4499-AC14-25EB18E1D3DA"
.EXAMPLE
  Get-SPClientListItem -Retrievals "Title"
.INPUTS
  None or Microsoft.SharePoint.Client.List
.OUTPUTS
  Microsoft.SharePoint.Client.ListItemCollection or Microsoft.SharePoint.Client.ListItem
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientListItem.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'IdentityGuid')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.List]
        $ParentList,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [string]
        $FolderUrl,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [ValidateSet('FilesOnly', 'Recursive', 'RecursiveAll')]
        [string]
        $Scope,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [string[]]
        $ViewFields,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [string]
        $Query,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [int]
        $RowLimit,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Microsoft.SharePoint.Client.ListItemCollectionPosition]
        $Position,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'IdentityGuid')]
        [Alias('UniqueId')]
        [guid]
        $IdentityGuid,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $Caml = New-object Microsoft.SharePoint.Client.CamlQuery
            if ($PSBoundParameters.ContainsKey('FolderUrl')) {
                $Caml.FolderServerRelativeUrl = $FolderUrl
            }
            $XmlDocument = New-Object System.Xml.XmlDocument
            $ViewElement = $XmlDocument.AppendChild($XmlDocument.CreateElement('View'))
            if ($PSBoundParameters.ContainsKey('Scope')) {
                $ViewElement.SetAttribute('Scope', $Scope)
            }
            if ($PSBoundParameters.ContainsKey('ViewFields')) {
                $ViewFieldsElement = $ViewElement.AppendChild($XmlDocument.CreateElement('ViewFields'))
                foreach ($ViewField in $ViewFields) {
                    $FieldRefElement = $ViewFieldsElement.AppendChild($XmlDocument.CreateElement('FieldRef'))
                    $FieldRefElement.SetAttribute('Name', $ViewField)
                }
            }
            if ($PSBoundParameters.ContainsKey('Query')) {
                $QueryElement = $ViewElement.AppendChild($XmlDocument.CreateElement('Query'))
                $QueryElement.InnerXml = $Query
                if ($QueryElement.FirstChild.Name -eq 'Query') {
                    $QueryElement = $QueryElement.FirstChild
                }
            }
            if ($PSBoundParameters.ContainsKey('RowLimit')) {
                $RowLimitElement = $ViewElement.AppendChild($XmlDocument.CreateElement('RowLimit'))
                $RowLimitElement.InnerText = $RowLimit
            }
            if ($PSBoundParameters.ContainsKey('Position')) {
                $Caml.ListItemCollectionPosition = $Position
            }
            $Caml.ViewXml = $XmlDocument.InnerXml
            $ClientObjectCollection = $ParentList.GetItems($Caml)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrievals $Retrievals
            Write-Output @(, $ClientObjectCollection)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ParentList.Path, `
                'GetItemById', `
                [object[]]$Identity)
            $ClientObject = New-Object Microsoft.SharePoint.Client.ListItem($ClientContext, $PathMethod)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified list item could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'IdentityGuid') {
            $Caml = New-object Microsoft.SharePoint.Client.CamlQuery
            $Caml.ViewXml =  `
                '<View Scope="RecursiveAll">' + `
                '<RowLimit>1</RowLimit>' + `
                '<Query>' + `
                '<Where>' + `
                '<Eq>' + `
                '<FieldRef Name="UniqueId"/>' + `
                '<Value Type="Guid">' + $IdentityGuid + '</Value>' + `
                '</Eq>' + `
                '</Where>' + `
                '</Query>' + `
                '</View>'
            $ClientObjectCollection = $ParentList.GetItems($Caml)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrievals $Retrievals
            if ($ClientObjectCollection.Count -eq 0) {
                throw 'The specified list item could not be found.'
            }
            Write-Output $ClientObjectCollection[0]
        }
    }

}
