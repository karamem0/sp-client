#Requires -Version 3.0

<#
  Get-SPClientGroup.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientGroup {

<#
.SYNOPSIS
  Gets one or more groups.
.DESCRIPTION
  The Get-SPClientGroup function lists all site groups or retrieves the specified site group.
  If not specified filterable parameter, returns site all groups.
  Otherwise, returns a group which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the group ID.
.PARAMETER Name
  Indicates the group name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientGroup
.EXAMPLE
  Get-SPClientGroup -Identity 7
.EXAMPLE
  Get-SPClientGroup -Name "Custom Group"
.EXAMPLE
  Get-SPClientGroup -Retrieval "Title"
.INPUTS
  None
.OUTPUTS
  Microsoft.SharePoint.Client.GroupCollection Microsoft.SharePoint.Client.Group
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientGroup.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('Title')]
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
        $ClientObjectCollection = $ClientContext.Site.RootWeb.SiteGroups
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetById', `
                [object[]]$Identity)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Group($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified group could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByName', `
                [object[]]$Name)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Group($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified group could not be found.'
            }
        }
    }

}
