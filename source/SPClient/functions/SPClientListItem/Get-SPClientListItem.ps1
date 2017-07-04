#Requires -Version 3.0

<#
  Get-SPClientListItem.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientListItem {

<#
.SYNOPSIS
  Gets one or more list items.
.DESCRIPTION
  The Get-SPClientListItem function retrieves list items using CAML query.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
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
  Indicates the collection of view columns.
.PARAMETER Query
  Indicates the XML representation of query.
.PARAMETER RowLimit
  Indicates the number of items. This parameter is used for item pagination.
.PARAMETER Position
  Indicates the starting position. This parameter is used for item pagination.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the list item ID.
.PARAMETER IdentityGuid
  Indicates the list item GUID.
.PARAMETER Retrieval
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
  Get-SPClientListItem -Retrieval "Title"
.INPUTS
  None or SPClient.SPClientListItemParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.ListItemCollection or Microsoft.SharePoint.Client.ListItem
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientListItem.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientListItemParentParameter]
        $ParentObject,
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
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
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
        $Retrieval
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
            $ClientObjectCollection = $ParentObject.ClientObject.GetItems($Caml)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
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
                -Retrieval $Retrieval
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
            $ClientObjectCollection = $ParentObject.ClientObject.GetItems($Caml)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            if ($ClientObjectCollection.Count -eq 0) {
                throw 'The specified list item could not be found.'
            }
            Write-Output $ClientObjectCollection[0]
        }
    }

}
