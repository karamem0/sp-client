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
  If not specified filterable parameter, returns all site templates of the site collection or site.
  Otherwise, returns a site template which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the site collection or site to which the site templates are contained.
.PARAMETER Locale
  Indicates the locale ID in which the site templates is used. If not specified, uses the current thread locale.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Name
  Indicates the site template name.
.EXAMPLE
  Get-SPClientWebTemplate
.EXAMPLE
  Get-SPClientWebTemplate $web -Locale 1033
.EXAMPLE
  Get-SPClientWebTemplate -Name "STS#0"
.INPUTS
  None or SPClient.SPClientWebTemplateParentPipeBind
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
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientWebTemplateParentPipeBind]
        $ParentObject = $ClientContext.Site,
        [Parameter(Mandatory = $false)]
        [string]
        $Locale = [System.Threading.Thread]::CurrentThread.CurrentCulture.LCID,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $false, ParameterSetName = 'Name')]
        [string]
        $Name
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($ParentObject -eq $null) {
            throw "Cannot bind argument to parameter 'ParentObject' because it is null."
        }
        if ($ParentObject.ClientObject -is [Microsoft.SharePoint.Client.Site]) {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ParentObject.ClientObject.Path, `
                'GetWebTemplates', `
                [object[]]@($Locale, 0))
            $ClientObjectCollection = New-Object Microsoft.SharePoint.Client.WebTemplateCollection($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection
        } else {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ParentObject.ClientObject.Path, `
                'GetAvailableWebTemplates', `
                [object[]]@($Locale, $true))
            $ClientObjectCollection = New-Object Microsoft.SharePoint.Client.WebTemplateCollection($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $ClientObject = $ClientObjectCollection | Where-Object { $_.Name -eq $Name }
            if ($ClientObject -eq $null) {
                throw 'The specified site template could not be found.'
            }
            Write-output $ClientObject
        }
    }

}
