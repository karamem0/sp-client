#Requires -Version 3.0

# New-SPClientView.ps1
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

function New-SPClientView {

<#
.SYNOPSIS
  Creates a new view.
.DESCRIPTION
  The New-SPClientView function adds a new view to the list.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentList
  Indicates the list which a view to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title. If not specified, uses the internal name.
.PARAMETER ViewFields
  Indicates the collection of view fields.
.PARAMETER Query
  Indicates the XML representation of the query.
.PARAMETER RowLimit
  Indicates the number of items.
.PARAMETER Paged
  Indicates a value whether the view is a paged view. 
.PARAMETER SetAsDefaultView
  Indicates a value whether the view is the default view. 
.PARAMETER ViewTypeKind
  Indicates the type of the view.
.PARAMETER PersonalView
  Indicates a value whether the view is a personal view. 
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientView -Name "CustomView" -Title "Custom View" -ViewFields "ID", "Title"
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.List]
        $ParentList,
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Title = $Name,
        [Parameter(Mandatory = $false)]
        [string[]]
        $ViewFields,
        [Parameter(Mandatory = $false)]
        [string]
        $Query,
        [Parameter(Mandatory = $false)]
        [int]
        $RowLimit,
        [Parameter(Mandatory = $false)]
        [bool]
        $Paged,
        [Parameter(Mandatory = $false)]
        [bool]
        $SetAsDefaultView,
        [Parameter(Mandatory = $false)]
        [ValidateSet('Html', 'Grid', 'Calendar', 'Recurrence', 'Chart', 'Gantt')]
        [string]
        $ViewType = 'Html',
        [Parameter(Mandatory = $false)]
        [bool]
        $PersonalView,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ViewCreationInformation
        $Creation.Title = $Name
        $Creation.ViewFields = $ViewFields
        if ($PSBoundParameters.ContainsKey('Query')) {
            $XmlDocument = New-Object System.Xml.XmlDocument
            $QueryElement = $XmlDocument.AppendChild($XmlDocument.CreateElement('Query'))
            $QueryElement.InnerXml = $Query
            if ($QueryElement.FirstChild.Name -eq 'Query') {
                $QueryElement = $QueryElement.FirstChild
            }
            $Query = $QueryElement.InnerXml
            $Creation.Query = $Query
        }
        $Creation.RowLimit = $RowLimit
        $Creation.Paged = $Paged
        $Creation.SetAsDefaultView = $SetAsDefaultView
        $Creation.ViewTypeKind = $ViewType
        $Creation.PersonalView = $PersonalView
        $ClientObject = $ParentList.Views.Add($Creation)
        $ClientObject.Title = $Title
        $ClientObject.Update()
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
