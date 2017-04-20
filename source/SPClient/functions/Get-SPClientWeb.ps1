#Requires -Version 3.0

# Get-SPClientWeb.ps1
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

function Get-SPClientWeb {

<#
.SYNOPSIS
  Gets SharePoint client web object.
.DESCRIPTION
  If not specified 'Identity', 'Url', 'Default', and 'Root', returns the default
  web and its descendants. Otherwise, returns a web which matches the parameter.
.PARAMETER ClientContext
  Indicates the SharePoint client context.
  If not specified, uses the default context.
.PARAMETER Identity
  Indicates the SharePoint web GUID to get.
.PARAMETER Url
  Indicates the SharePoint web relative url to get.
.PARAMETER Default
  If specified, returns the default web of the client context.
.PARAMETER Root
  If specified, returns the root web.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Root')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [switch]
        $Default,
        [Parameter(Mandatory = $true, ParameterSetName = 'Root')]
        [switch]
        $Root,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Root')]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $web = $ClientContext.Web
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $web `
                -Retrievals $Retrievals
            Write-Output $web
            $stack = New-Object System.Collections.Stack
            do {
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $web.Webs `
                    -Retrievals $Retrievals
                while ($web.Webs.Count -gt 0) {
                    $item = @{
                        Webs = $web.Webs
                        Index = 0
                    }
                    $stack.Push($item)
                    $web = $web.Webs[$item.Index]
                    Write-Output $web
                    Invoke-SPClientLoadQuery `
                        -ClientContext $ClientContext `
                        -ClientObject $web.Webs `
                        -Retrievals $Retrievals
                }
                while ($stack.Count -gt 0) {
                    $item = $stack.Pop()
                    $item.Index += 1
                    if ($item.Index -lt $item.Webs.Count) {
                        $stack.Push($item)
                        $web = $item.Webs[$item.Index]
                        Write-Output $web
                        break
                    }
                }
            } while ($stack.Count -gt 0)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $web = $ClientContext.Site.OpenWebById($Identity)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $web `
                -Retrievals $Retrievals
            Write-Output $web
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $web = $ClientContext.Site.OpenWeb($Url)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $web `
                -Retrievals $Retrievals
            Write-Output $web
        }
        if ($PSCmdlet.ParameterSetName -eq 'Default') {
            $web = $ClientContext.Web
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $web `
                -Retrievals $Retrievals
            Write-Output $web
        }
        if ($PSCmdlet.ParameterSetName -eq 'Root') {
            $web = $ClientContext.Site.RootWeb
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $web `
                -Retrievals $Retrievals
            Write-Output $web
        }
    }

}
