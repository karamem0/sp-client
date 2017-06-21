#Requires -Version 3.0

<#
  Clear-SPClientPermission.ps1

  Copyright (c) 2017 karamem0

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
#>

function Clear-SPClientPermission {

<#
.SYNOPSIS
  Clears all permission.
.DESCRIPTION
  The Clear-SPClientPermission function clears all role assignments from the
  specified object.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the web, list or item.
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
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals 'RoleAssignments'
        while ($ClientObject.RoleAssignments.Count -gt 0) {
            $ClientObject.RoleAssignments[0].DeleteObject()
        }
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals 'RoleAssignments.Include(Member,RoleDefinitionBindings)'
        if ($PassThru) {
            Write-Output $ClientObject
        }
    }

}
