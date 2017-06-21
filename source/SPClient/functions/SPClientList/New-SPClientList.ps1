#Requires -Version 3.0

<#
  New-SPClientList.ps1

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

function New-SPClientList {

<#
.SYNOPSIS
  Creates a new list.
.DESCRIPTION
  The New-SPClientList function adds a new list to the web.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentWeb
  Indicates the web which a list to be created.
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
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientList -Name "CustomList" -Title "Custom List"
.INPUTS
  None or Microsoft.SharePoint.Client.Web
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
        [Microsoft.SharePoint.Client.Web]
        $ParentWeb,
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
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
        $Creation.Title = $Name
        $Creation.Description = $Description
        $Creation.TemplateType = $Template
        $ClientObject = $ParentWeb.Lists.Add($Creation)
        $ClientObject.Title = $Title
        $ClientObject.EnableAttachments = $EnableAttachments
        $ClientObject.EnableFolderCreation = $EnableFolderCreation
        $ClientObject.EnableVersioning = $EnableVersioning
        $ClientObject.NoCrawl = $NoCrawl
        $ClientObject.OnQuickLaunch = $OnQuickLaunch
        $ClientObject.Update()
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
