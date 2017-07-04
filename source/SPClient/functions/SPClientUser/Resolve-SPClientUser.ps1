#Requires -Version 3.0

<#
  Resolve-SPClientUser.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Resolve-SPClientUser {

<#
.SYNOPSIS
 Resolves login name to user.
.DESCRIPTION
  The Resolve-SPClientUser function checks whether the specified login name belongs to a valid user.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER Name
  Indicates login name or E-mail address.
.EXAMPLE
  Resolve-SPClientUser "i:0#.f|membership|admin@example.com"
.INPUTS
  None
.OUTPUTS
  Microsoft.SharePoint.Client.User
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Resolve-SPClientUser.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true)]
        [string]
        $Name
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObject = $ClientContext.Site.RootWeb.EnsureUser($Name)
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
