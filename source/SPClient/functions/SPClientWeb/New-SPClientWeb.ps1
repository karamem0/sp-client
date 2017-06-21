#Requires -Version 3.0

<#
  New-SPClientWeb.ps1

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

function New-SPClientWeb {

<#
.SYNOPSIS
  Creates a new web.
.DESCRIPTION
  The New-SPClientWeb function adds a new web to the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentWeb
  Indicates the web which a web to be created.
.PARAMETER Url
  Indicates the url.
.PARAMETER Title
  Indicates the title. If not specified, uses default title of the web template.
.PARAMETER Description
  Indicates the description.
.PARAMETER Language
  Indicates the locale ID in which the language is used. If not specified, uses
  the parent web language.
.PARAMETER Template
  Indicates the template name.
.PARAMETER UniquePermissions
  If specified, the web uses unique permissions.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientWeb -Url "CustomWeb" -Title "Custom Web"
.INPUTS
  None or Microsoft.SharePoint.Client.Web
.OUTPUTS
  Microsoft.SharePoint.Client.Web
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientWeb.md
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
        $Url,
        [Parameter(Mandatory = $false)]
        [string]
        $Title,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [string]
        $Language,
        [Parameter(Mandatory = $false)]
        [string]
        $Template,
        [Parameter(Mandatory = $false)]
        [switch]
        $UniquePermissions,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.WebCreationInformation
        $Creation.Url = $Url
        $Creation.Language = $Language
        $Creation.WebTemplate = $Template
        $Creation.Title = $Title
        $Creation.Description = $Description
        $Creation.UseSamePermissionsAsParentSite = -not $UniquePermissions
        $ClientObject = $ParentWeb.Webs.Add($Creation)
        $ClientObject.Update()
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
