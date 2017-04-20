#Requires -Version 3.0

# Get-SPClientList.ps1
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

function Get-SPClientList {

<#
.SYNOPSIS
  Gets SharePoint client list object.
.DESCRIPTION
  If not specified 'Identity', 'Url' and 'Title', returns all lists. Otherwise,
  returns a list which matches the parameter.
.PARAMETER ClientContext
  Indicates the SharePoint client context.
  If not specified, uses the default context.
.PARAMETER Web
  Indicates the SharePoint web object.
  If not specified, uses the default web.
.PARAMETER Identity
  Indicates the SharePoint list GUID to get.
.PARAMETER Url
  Indicates the SharePoint list relative url to get.
.PARAMETER Title
  Indicates the SharePoint list title or internal name to get.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Title')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'Title')]
        [Microsoft.SharePoint.Client.Web]
        $Web = $SPClient.ClientContext.Web,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url,
        [Parameter(Mandatory = $true, ParameterSetName = 'Title')]
        [string]
        $Title,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Title')]
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
            $lists = $Web.Lists
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $lists `
                -Retrievals $Retrievals
            Write-Output @(,$lists)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $list = $Web.Lists.GetById($Identity)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $list `
                -Retrievals $Retrievals
            Write-Output $list
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $list = $Web.GetList($Url)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $list `
                -Retrievals $Retrievals
            Write-Output $list
        }
        if ($PSCmdlet.ParameterSetName -eq 'Title') {
            try {
                $list = $Web.Lists.GetByTitle($Title)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $list `
                    -Retrievals $Retrievals
            } catch {
                $lists = $Web.Lists
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $lists `
                    -Retrievals 'Include(RootFolder.Name)'
                $list = $lists | Where-Object { $_.RootFolder.Name -eq $Title }
                if ($list -eq $null) {
                    throw $_
                }
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $list `
                    -Retrievals $Retrievals
            }
            Write-Output $list
        }
    }

}
