#Requires -Version 3.0

<#
  Revoke-SPClientPermission.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Revoke-SPClientPermission {

<#
.SYNOPSIS
  Revokes one or more permissions.
.DESCRIPTION
  The Revoke-SPClientPermission function revokes role assignments to the specified object.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the site, list or item.
.PARAMETER Member
  Indicates the user or group to be revoked permission.
.PARAMETER Roles
  Indicates the roles to be removed.
.PARAMETER PassThru
  If specified, returns input object.
.EXAMPLE
  Revoke-SPClientPermission $item -Member $user -Roles "Full Control"
.INPUTS
  None or Microsoft.SharePoint.Client.SecurableObject
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Revoke-SPClientPermission.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Roles')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.SecurableObject]
        $ClientObject,
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.Principal]
        $Member,
        [Parameter(Mandatory = $true, ParameterSetName = 'All')]
        [switch]
        $All,
        [Parameter(Mandatory = $true, ParameterSetName = 'Roles')]
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
        $RoleAssignment = $ClientObject.RoleAssignments.GetByPrincipal($Member)
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $RoleAssignment.DeleteObject()
        }
        if ($PSCmdlet.ParameterSetName -eq 'Roles') {
            $RoleDefinitionBindings = $RoleAssignment.RoleDefinitionBindings
            $RoleDefinitionCollection = $ClientContext.Site.RootWeb.RoleDefinitions
            foreach ($Role in $Roles) {
                if ($Role -is 'Microsoft.SharePoint.Client.RoleType') {
                    $RoleDefinition = $RoleDefinitionCollection.GetByType($Role)
                    $RoleDefinitionBindings.Remove($RoleDefinition)
                } else {
                    $RoleDefinition = $RoleDefinitionCollection.GetByName($Role.ToString())
                    $RoleDefinitionBindings.Remove($RoleDefinition)
                }
            }
            $RoleAssignment.Update()
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
