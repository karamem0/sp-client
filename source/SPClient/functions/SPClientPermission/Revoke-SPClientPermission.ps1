﻿#Requires -Version 3.0

# Revoke-SPClientPermission.ps1
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

function Revoke-SPClientPermission {

<#
.SYNOPSIS
  Revokes one or more permissions.
.DESCRIPTION
  The Revoke-SPClientPermission function revokes role assignments to the
  specified object.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the web, list or item.
.PARAMETER Member
  Indicates the user or group to be revoked permission.
.PARAMETER Roles
  Indicates the roles to be removed.
.EXAMPLE
  Revoke-SPClientPermission $item -Member $user -Roles "Full Control"
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
        $Roles
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
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals 'RoleAssignments.Include(Member,RoleDefinitionBindings)'
        Write-Output $ClientObject
    }

}
