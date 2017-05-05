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
.PARAMETER ParentObject
  Indicates the list which the list items are contained.
.PARAMETER FolderUrl
  Indicates the folder relative url.
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
  Indicates the number of items.
  This parameter is used for item pagination.
.PARAMETER Position
  Indicates the starting position.
  This parameter is used for item pagination.
.PARAMETER Identity
  Indicates the list item ID.
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
        $ParentObject,
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
        [Alias('Id')]
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
            $Caml = New-object Microsoft.SharePoint.Client.CamlQuery
            if ($MyInvocation.BoundParameters.ContainsKey('FolderUrl')) {
                $Caml.FolderServerRelativeUrl = $FolderUrl
            }
            $XmlDocument = New-Object System.Xml.XmlDocument
            $ViewElement = $XmlDocument.AppendChild($XmlDocument.CreateElement('View'))
            if ($MyInvocation.BoundParameters.ContainsKey('Scope')) {
                $ViewElement.SetAttribute('Scope', $Scope)
            }
            if ($MyInvocation.BoundParameters.ContainsKey('ViewFields')) {
                $Fragment = $XmlDocument.CreateDocumentFragment()
                $Fragment.InnerXml = $ViewFields
                $ViewElement.AppendChild($Fragment) | Out-Null
            }
            if ($MyInvocation.BoundParameters.ContainsKey('Query')) {
                $Fragment = $XmlDocument.CreateDocumentFragment()
                $Fragment.InnerXml = $Query
                $ViewElement.AppendChild($Fragment) | Out-Null
            }
            if ($MyInvocation.BoundParameters.ContainsKey('RowLimit')) {
                $Fragment = $XmlDocument.CreateElement('RowLimit')
                $Fragment.InnerText = $RowLimit
                $ViewElement.AppendChild($Fragment) | Out-Null
            }
            if ($MyInvocation.BoundParameters.ContainsKey('Position')) {
                $Caml.ListItemCollectionPosition = $Position
            }
            $Caml.ViewXml = $XmlDocument.InnerXml
            $ClientObjectCollection = $ParentObject.GetItems($Caml)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrievals $Retrievals
            Write-Output @(, $ClientObjectCollection)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $ClientObject = $ParentObject.GetItemById($Identity)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
        }
    }

}
