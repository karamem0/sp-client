#Requires -Version 3.0

<#
  Get-SPClientUser.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientUser {

<#
.SYNOPSIS
  Gets one or more users.
.DESCRIPTION
  The Get-SPClientUser function lists all site users or retrieves the specified site user.
  If not specified filterable parameter, returns site all users.
  Otherwise, returns a user which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the user ID.
.PARAMETER Name
  Indicates the user login name.
.PARAMETER Email
  Indicates the user E-mail.
.PARAMETER Current
  If specified, returns current user.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientUser
.EXAMPLE
  Get-SPClientUser -Identity 7
.EXAMPLE
  Get-SPClientUser -Name "i:0#.f|membership|admin@example.com"
.EXAMPLE
  Get-SPClientUser -Email "admin@example.com"
.EXAMPLE
  Get-SPClientUser -Retrieval "Title"
.INPUTS
  None
.OUTPUTS
  Microsoft.SharePoint.Client.User[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientUser.md
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
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('LoginName')]
        [string]
        $Name,
        [Parameter(Mandatory = $true, ParameterSetName = 'Email')]
        [string]
        $Email,
        [Parameter(Mandatory = $true, ParameterSetName = 'Current')]
        [switch]
        $Current,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObjectCollection = $ClientContext.Site.RootWeb.SiteUsers
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
            $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified user could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByLoginName', `
                [object[]]$Name)
            $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified user could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Email') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByEmail', `
                [object[]]$Email)
            $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified user could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Current') {
            $ClientObject = $ClientContext.Site.RootWeb.CurrentUser
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified user could not be found.'
            }
        }
    }

}
