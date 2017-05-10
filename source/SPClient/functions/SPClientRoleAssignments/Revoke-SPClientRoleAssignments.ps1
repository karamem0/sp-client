#Requires -Version 3.0

# Revoke-SPClientRoleAssignments.ps1
#
# Copyright (c) 2017 karamem0
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function Revoke-SPClientRoleAssignments {

<#
.SYNOPSIS
  Revokes permission from the specified object.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses the default context.
.PARAMETER ClientObject
  Indicates the web, list or item.
.PARAMETER Member
  Indicates the user or group to be revoked permission.
.PARAMETER Roles
  Indicates the roles to be removed.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Roles')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
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
        $Roles
    )

    process {
        $RoleAssignment = $ClientObject.RoleAssignments.GetByPrincipal($Member)
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $RoleAssignment.DeleteObject()
        }
        if ($PSCmdlet.ParameterSetName -eq 'Roles') {
            $RoleDefinitionBindings = $RoleAssignment.RoleDefinitionBindings
            $Roles | ForEach-Object {
                if ($_ -is 'Microsoft.SharePoint.Client.RoleType') {
                    $RoleDefinition = $ClientContext.Site.RootWeb.RoleDefinitions.GetByType($_)
                    $RoleDefinitionBindings.Remove($RoleDefinition)
                } else {
                    $RoleDefinition = $ClientContext.Site.RootWeb.RoleDefinitions.GetByName($_.ToString())
                    $RoleDefinitionBindings.Remove($RoleDefinition)
                }
            }
            $RoleAssignment.Update()
        }
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals 'RoleAssignments.Include(Member,RoleDefinitionBindings)'
        Write-Output $ClientObject
    }

}
