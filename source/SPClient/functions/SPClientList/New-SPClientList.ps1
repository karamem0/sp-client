#Requires -Version 3.0

<#
  New-SPClientList.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientList {

<#
.SYNOPSIS
  Creates a new list.
.DESCRIPTION
  The New-SPClientList function adds a new list to the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the site which a list to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title. If not specified, uses the internal name.
.PARAMETER Description
  Indicates the description.
.PARAMETER Template
  Indicates the template ID. If not specified, uses 100 (Generic List).
.PARAMETER EnableAttachments
  Indicates a value whether attachments are enabled.
.PARAMETER EnableFolderCreation
  Indicates a value whether new folders can be added.
.PARAMETER EnableVersioning
  Indicates a value whether historical versions can be created.
.PARAMETER NoCrawl
  Indicates a value whether crawler must not crawl.
.PARAMETER OnQuickLaunch
  Indicates a value whether the list is displayed on the quick launch.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientList -Name "CustomList" -Title "Custom List"
.INPUTS
  None or SPClient.SPClientListParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.List
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientList.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientListParentParameter]
        $ParentObject,
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Title = $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [int]
        $Template = 100,
        [Parameter(Mandatory = $false)]
        [bool]
        $EnableAttachments,
        [Parameter(Mandatory = $false)]
        [bool]
        $EnableFolderCreation,
        [Parameter(Mandatory = $false)]
        [bool]
        $EnableVersioning,
        [Parameter(Mandatory = $false)]
        [bool]
        $NoCrawl,
        [Parameter(Mandatory = $false)]
        [bool]
        $OnQuickLaunch,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
        $Creation.Title = $Name
        $Creation.Description = $Description
        $Creation.TemplateType = $Template
        $ClientObject = $ParentObject.CLientObject.Lists.Add($Creation)
        $ClientObject.Title = $Title
        $ClientObject.EnableAttachments = $EnableAttachments
        $ClientObject.EnableFolderCreation = $EnableFolderCreation
        $ClientObject.EnableVersioning = $EnableVersioning
        $ClientObject.NoCrawl = $NoCrawl
        $ClientObject.OnQuickLaunch = $OnQuickLaunch
        $ClientObject.Update()
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
