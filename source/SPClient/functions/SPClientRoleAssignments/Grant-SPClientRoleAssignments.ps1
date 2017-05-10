#Requires -Version 3.0

# Grant-SPClientRoleAssignments.ps1
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

function Grant-SPClientRoleAssignments {

<#
.SYNOPSIS
  Grants permission to the specified object.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses the default context.
.PARAMETER ClientObject
  Indicates the web, list or item.
.PARAMETER Member
  Indicates the user or group to be granted permission.
.PARAMETER Roles
  Indicates the roles to be added.
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.SecurableObject]
        $ClientObject,
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.Principal]
        $Member,
        [Parameter(Mandatory = $true)]
        [object[]]
        $Roles
    )

    process {
        $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($ClientContext)
        $Roles | ForEach-Object {
            if ($_ -is 'Microsoft.SharePoint.Client.RoleType') {
                $RoleDefinition = $ClientContext.Site.RootWeb.RoleDefinitions.GetByType($_)
                $RoleDefinitionBindings.Add($RoleDefinition)
            } else {
                $RoleDefinition = $ClientContext.Site.RootWeb.RoleDefinitions.GetByName($_.ToString())
                $RoleDefinitionBindings.Add($RoleDefinition)
            }
        }
        $ClientObject.RoleAssignments.Add($Member, $RoleDefinitionBindings) | Out-Null
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals 'RoleAssignments.Include(Member,RoleDefinitionBindings)'
        Write-Output $ClientObject
    }

}
