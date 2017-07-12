#Requires -Version 3.0

<#
  Get-SPClientWebTemplate.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientWebTemplate {

<#
.SYNOPSIS
  Gets one or more site templates.
.DESCRIPTION
  The Get-SPClientWebTemplate function lists all site templates or retrieves the specified site template.
  If not specified filterable parameter, returns all site templates of the site collection.
  Otherwise, returns a site template which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER Locale
  Indicates the locale ID in which the site templates is used. If not specified, uses the current thread locale.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Web
  Indicates the site to which the site templates are available.
.PARAMETER IncludeCrossLanguage
  If specified, includes language-neutral site templates.
.PARAMETER Name
  Indicates the site template name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientWebTemplate
.EXAMPLE
  Get-SPClientWebTemplate -Locale 1033 -Web $Web -IncludeCrossLanguage
.EXAMPLE
  Get-SPClientWebTemplate -Name "STS#0"
.INPUTS
  None
.OUTPUTS
  Microsoft.SharePoint.Client.WebTemplate[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWebTemplate.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false)]
        [string]
        $Locale = [System.Threading.Thread]::CurrentThread.CurrentCulture.LCID,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Available')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $false, ParameterSetName = 'Available')]
        [Microsoft.SharePoint.Client.Web]
        $Web,
        [Parameter(Mandatory = $false, ParameterSetName = 'Available')]
        [switch]
        $IncludeCrossLanguage,
        [Parameter(Mandatory = $false)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $ClientObjectCollection = $ClientContext.Site.GetWebTemplates($Locale, 0)
        } else {
            $ClientObjectCollection = $Web.GetAvailableWebTemplates($Locale, $IncludeCrossLanguage)
        }
        if ($PSBoundParameters.ContainsKey('Name')) {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            $ClientObject = $ClientObjectCollection | Where-Object { $_.Name -eq $Name }
            if ($ClientObject -eq $null) {
                throw 'The specified site template could not be found.'
            }
            Write-output $ClientObject
        } else {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
    }

}
