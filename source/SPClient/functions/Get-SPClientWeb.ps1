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
  Get SharePoint client web object.
.DESCRIPTION
  If not specified $Identity and $Url, returns the root web.
  Otherwise, returns a web which matches the parameter.
.PARAMETER ClientContext
  Indicates the SharePoint client context.
  If not specified, uses the default context.
.PARAMETER Identity
  Indicates the SharePoint web GUID to get.
.PARAMETER Url
  Indicates the SharePoint web relative url to get.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Position = 1, Mandatory = $false, ParameterSetName = "IdentitySet")]
        [Guid]
        $Identity,
        [Parameter(Position = 2, Mandatory = $true, ParameterSetName = "UrlSet")]
        [String]
        $Url,
        [Parameter(Position = 3, Mandatory = $false)]
        [String]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw '$ClientContext parameter is not specified.'
        }
        if ($PSCmdlet.ParameterSetName -eq 'IdentitySet') {
            if ($Identity -eq $null) {
                $web = $ClientContext.Site.RootWeb
            } else {
                $web = $ClientContext.Site.OpenWebById($Identity)
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'UrlSet') {
            $web = $ClientContext.Site.OpenWeb($Url)
        }
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $web `
            -Retrievals $Retrievals
        Write-Output $web
    }

}
