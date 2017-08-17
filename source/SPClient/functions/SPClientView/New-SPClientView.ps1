#Requires -Version 3.0

<#
  New-SPClientView.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientView {

<#
.SYNOPSIS
  Creates a new view.
.DESCRIPTION
  The New-SPClientView function adds a new view to the list.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the list which a view to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title. If not specified, uses the internal name.
.PARAMETER ViewFields
  Indicates the collection of view columns.
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
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientView -Name "CustomView" -Title "Custom View" -ViewFields "ID", "Title"
.INPUTS
  None or SPClient.SPClientViewParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.View
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientView.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientViewParentPipeBind]
        $ParentObject,
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
        $Retrieval
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
        $ClientObject = $ParentObject.ClientObject.Views.Add($Creation)
        $ClientObject.Title = $Title
        $ClientObject.Update()
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
