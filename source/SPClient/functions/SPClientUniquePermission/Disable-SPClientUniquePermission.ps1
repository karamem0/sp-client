#Requires -Version 3.0

<#
  Disable-SPClientUniquePermission.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Disable-SPClientUniquePermission {

<#
.SYNOPSIS
  Disables unique permissions.
.DESCRIPTION
  The Disable-SPClientUniquePermission function disables unique role assignments to the specified object.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the site, list or item.
.PARAMETER PassThru
  If specified, returns input object.
.EXAMPLE
  Disable-SPClientUniquePermission $item
.INPUTS
  None or Microsoft.SharePoint.Client.SecurableObject
.OUTPUTS
  None or Microsoft.SharePoint.Client.SecurableObject
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Disable-SPClientUniquePermission.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.SecurableObject]
        $ClientObject,
        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObject.ResetRoleInheritance()
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval 'HasUniqueRoleAssignments'
        if ($PassThru) {
            Write-Output $ClientObject
        }
    }

}
