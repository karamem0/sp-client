#Requires -Version 3.0

<#
  Clear-SPClientPermission.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Clear-SPClientPermission {

<#
.SYNOPSIS
  Clears all permission.
.DESCRIPTION
  The Clear-SPClientPermission function clears all role assignments from the specified object.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the site, list or item.
.PARAMETER PassThru
  If specified, returns input object.
.EXAMPLE
  Clear-SPClientPermission $item
.INPUTS
  None or Microsoft.SharePoint.Client.SecurableObject
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Clear-SPClientPermission.md
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
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval 'RoleAssignments'
        while ($ClientObject.RoleAssignments.Count -gt 0) {
            $ClientObject.RoleAssignments[0].DeleteObject()
        }
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval 'RoleAssignments.Include(Member,RoleDefinitionBindings)'
        if ($PassThru) {
            Write-Output $ClientObject
        }
    }

}
