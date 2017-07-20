#Requires -Version 3.0

<#
  New-SPClientWeb.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientWeb {

<#
.SYNOPSIS
  Creates a new subsite.
.DESCRIPTION
  The New-SPClientWeb function adds a new subsite to the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the site which a subsite to be created.
.PARAMETER Url
  Indicates the url.
.PARAMETER Title
  Indicates the title. If not specified, uses default title of the site template.
.PARAMETER Description
  Indicates the description.
.PARAMETER Locale
  Indicates the locale ID in which the language is used. If not specified, uses the parent site language.
.PARAMETER Template
  Indicates the template name.
.PARAMETER UniquePermissions
  If specified, the site uses unique permissions.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientWeb -Url "CustomWeb" -Title "Custom Web"
.INPUTS
  None or SPClient.SPClientWebParentPipeBind
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
        [SPClient.SPClientWebParentPipeBind]
        $ParentObject,
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
        [Alias('Language')]
        [string]
        $Locale,
        [Parameter(Mandatory = $false)]
        [SPClient.SPClientWebTemplateIdentityPipeBind]
        $Template,
        [Parameter(Mandatory = $false)]
        [switch]
        $UniquePermissions,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.WebCreationInformation
        $Creation.Url = $Url
        $Creation.Language = $Locale
        if ($PSBoundParameters.ContainsKey('Template')) {
            $Creation.WebTemplate = $Template.GetValue($ClientContext)
        }
        $Creation.Title = $Title
        $Creation.Description = $Description
        $Creation.UseSamePermissionsAsParentSite = -not $UniquePermissions
        $ClientObject = $ParentObject.ClientObject.Webs.Add($Creation)
        $ClientObject.Update()
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
