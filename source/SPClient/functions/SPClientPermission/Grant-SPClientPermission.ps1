#Requires -Version 3.0

<#
  Grant-SPClientPermission.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Grant-SPClientPermission {

<#
.SYNOPSIS
  Grants one or more permissions.
.DESCRIPTION
  The Grant-SPClientPermission function grants role assignments to the specified object.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the site, list or item.
.PARAMETER Member
  Indicates the user or group to be granted permission.
.PARAMETER Roles
  Indicates the roles to be added.
.PARAMETER PassThru
  If specified, returns input object.
.EXAMPLE
  Grant-SPClientPermission $item -Member $user -Roles "Full Control"
.INPUTS
  None or Microsoft.SharePoint.Client.SecurableObject
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Grant-SPClientPermission.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.SecurableObject]
        $ClientObject,
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.Principal]
        $Member,
        [Parameter(Mandatory = $true)]
        [object[]]
        $Roles,
        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($ClientContext)
        $RoleDefinitionCollection = $ClientContext.Site.RootWeb.RoleDefinitions
        foreach ($Role in $Roles) {
            if ($Role -is 'Microsoft.SharePoint.Client.RoleType') {
                $RoleDefinition = $RoleDefinitionCollection.GetByType($Role)
                $RoleDefinitionBindings.Add($RoleDefinition)
            } else {
                $RoleDefinition = $RoleDefinitionCollection.GetByName($Role.ToString())
                $RoleDefinitionBindings.Add($RoleDefinition)
            }
        }
        $ClientObject.RoleAssignments.Add($Member, $RoleDefinitionBindings) | Out-Null
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval 'RoleAssignments.Include(Member,RoleDefinitionBindings)'
        if ($PassThru) {
            Write-Output $ClientObject
        }
    }

}
