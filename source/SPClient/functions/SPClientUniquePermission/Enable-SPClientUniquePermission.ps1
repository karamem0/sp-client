#Requires -Version 3.0

<#
  Enable-SPClientUniquePermission.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Enable-SPClientUniquePermission {

<#
.SYNOPSIS
  Enables unique permissions.
.DESCRIPTION
  The Enable-SPClientUniquePermission function enables unique role assignments to the specified object.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the site, list or item.
.PARAMETER CopyRoleAssignments
  If specified, copies role assignments from the parent object.
.PARAMETER ClearSubscopes
  If specified, resets role assignments of child objects.
.PARAMETER PassThru
  If specified, returns input object.
.EXAMPLE
  Enable-SPClientUniquePermission $item
.INPUTS
  None or Microsoft.SharePoint.Client.SecurableObject
.OUTPUTS
  None or Microsoft.SharePoint.Client.SecurableObject
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Enable-SPClientUniquePermission.md
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
        $CopyRoleAssignments,
        [Parameter(Mandatory = $false)]
        [switch]
        $ClearSubscopes,
        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObject.BreakRoleInheritance($CopyRoleAssignments, $ClearSubscopes)
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval 'HasUniqueRoleAssignments'
        if ($PassThru) {
            Write-Output $ClientObject
        }
    }

}
