
#Requires -Version 3.0

<#
  New-SPClientUser.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientUser {

<#
.SYNOPSIS
  Creates a new user.
.DESCRIPTION
  The New-SPClientUser function adds a new user to the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER Name
  Indicates the login name.
.PARAMETER Title
  Indicates the display name.
.PARAMETER Email
  Indicates the E-mail.
.PARAMETER IsSiteAdmin
  Indicates a value whether the user is a site collection administrator.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientUser -Name "i:0#.f|membership|admin@example.com"
.INPUTS
  None
.OUTPUTS
  Microsoft.SharePoint.Client.User
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientUser.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true)]
        [Alias('LoginName')]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Title,
        [Parameter(Mandatory = $false)]
        [string]
        $Email,
        [Parameter(Mandatory = $false)]
        [bool]
        $IsSiteAdmin,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.UserCreationInformation
        $Creation.LoginName = $Name
        $Creation.Email = $Email
        $Creation.Title = $Title
        $ClientObject = $ClientContext.Site.RootWeb.SiteUsers.Add($Creation)
        if ($PSBoundParameters.ContainsKey('IsSiteAdmin')) {
            $ClientObject.IsSiteAdmin = $IsSiteAdmin
        }
        $ClientObject.Update()
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
