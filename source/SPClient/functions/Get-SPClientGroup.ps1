#Requires -Version 3.0

# Get-SPClientGroup.ps1
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

function Get-SPClientGroup {

<#
.SYNOPSIS
  Gets SharePoint client group object.
.DESCRIPTION
  If not specified 'Identitiy', returns site all groups. Otherwise, returns a web
  which matches the parameter.
.PARAMETER ClientContext
  Indicates the SharePoint client context.
  If not specified, uses the default context.
.PARAMETER Web
  Indicates the SharePoint web object.
  If not specified, uses the default web.
.PARAMETER Identity
  Indicates the SharePoint group id to get.
.PARAMETER Name
  Indicates the SharePoint group login name to get.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Name')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [Microsoft.SharePoint.Client.Web]
        $Web = $SPClient.ClientContext.Web,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]
        $Name,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'name')]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($Web -eq $null) {
            throw "Cannot bind argument to parameter 'Web' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $groups = $Web.SiteGroups
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $groups `
                -Retrievals $Retrievals
            Write-Output @(,$groups)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $group = $Web.SiteGroups.GetById($Identity)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $group `
                -Retrievals $Retrievals
            Write-Output $group
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $group = $Web.SiteGroups.GetByName($Name)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $group `
                -Retrievals $Retrievals
            Write-Output $group
        }
    }

}
