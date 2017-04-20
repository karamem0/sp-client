#Requires -Version 3.0

# Get-SPClientLisItem.ps1
#
# Copyright (c) 2017 karamem0
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function Get-SPClientListItem {

<#
.SYNOPSIS
  Retrieve list items using CAML query.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses the default context.
.PARAMETER List
  Indicates the list which the list items are contained.
.PARAMETER FolderUrl
  Indicates the folder relative url to get.
.PARAMETER Scope
  Indicates the scope of retrievals.
    - FilesOnly: Only the files of a specific folder. 
    - Recursive: All files of all folders. 
    - RecursiveAll: All files and all subfolders of all folders.
  If not specified, only the files and subfolders of a specific folder.
.PARAMETER ViewFields
  Indicates the XML representation of view fields.
.PARAMETER Query
  Indicates the XML representation of query.
.PARAMETER RowLimit
  Indicates the number of items to get.
  This parameter is used for item pagination.
.PARAMETER Position
  Indicates the starting position to get.
  This parameter is used for item pagination.
.PARAMETER Identity
  Indicates the list item ID to get.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'All')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Microsoft.SharePoint.Client.List]
        $List,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [string]
        $FolderUrl,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [ValidateSet('FilesOnly', 'Recursive', 'RecursiveAll')]
        [string]
        $Scope,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [string]
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
        [int]
        $Identity,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $caml = New-object Microsoft.SharePoint.Client.CamlQuery
            if (-not [string]::IsNullOrEmpty($FolderUrl)) {
                $caml.FolderServerRelativeUrl = $FolderUrl
            }
            $xml = New-Object System.Xml.XmlDocument
            $xml.AppendChild($xml.CreateElement('View')) | Out-Null
            if (-not [string]::IsNullOrEmpty($Scope)) {
                $xml.DocumentElement.SetAttribute('Scope', $Scope)
            }
            if (-not [string]::IsNullOrEmpty($ViewFields)) {
                $fragment = $xml.CreateDocumentFragment()
                $fragment.InnerXml = $ViewFields
                $xml.DocumentElement.AppendChild($fragment) | Out-Null
            }
            if (-not [string]::IsNullOrEmpty($Query)) {
                $fragment = $xml.CreateDocumentFragment()
                $fragment.InnerXml = $Query
                $xml.DocumentElement.AppendChild($fragment) | Out-Null
            }
            if (-not ($RowLimit -eq $null)) {
                $fragment = $xml.CreateDocumentFragment()
                $fragment.InnerXml = "<RowLimit>${RowLimit}</RowLimit>"
                $xml.DocumentElement.AppendChild($fragment) | Out-Null
            }
            if (-not ($Position -eq $null)) {
                $caml.ListItemCollectionPosition = $Position
            }
            $caml.ViewXml = $xml.InnerXml
            $items = $List.GetItems($caml)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $items `
                -Retrievals $Retrievals
            Write-Output @(,$items)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $item = $List.GetItemById($Identity)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $item `
                -Retrievals $Retrievals
            Write-Output $item
        }
    }

}
