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
  Get SharePoint client list object.
.DESCRIPTION
  If not specified $Identity, $Url and $Title, returns all lists.
  Otherwise, returns a list which matches the parameter.
.PARAMETER ClientContext
  Indicates the SharePoint client context.
  If not specified, uses the default context.
.PARAMETER Web
  Indicates the SharePoint web object.
  If not specified, uses the root web of default context.
.PARAMETER Identity
  Indicates the SharePointlistweb GUID to get.
.PARAMETER Url
  Indicates the SharePoint list relative url to get.
.PARAMETER Title
  Indicates the SharePoint title to get.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Position = 1, Mandatory = $false)]
        [Microsoft.SharePoint.Client.Web]
        $Web = $SPClient.ClientContext.Web,
        [Parameter(Position = 2, Mandatory = $false, ParameterSetName = 'IdentitySet')]
        [Guid]
        $Identity,
        [Parameter(Position = 3, Mandatory = $true, ParameterSetName = 'UrlSet')]
        [String]
        $Url,
        [Parameter(Position = 4, Mandatory = $true, ParameterSetName = 'TitleSet')]
        [String]
        $Title,
        [Parameter(Position = 5, Mandatory = $false)]
        [String]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw '$ClientContext parameter is not specified.'
        }
        if ($Web -eq $null) {
            throw '$Web parameter is not specified.'
        }
        if ($PSCmdlet.ParameterSetName -eq 'IdentitySet') {
            if ($Identity -eq $null) {
                $lists = $Web.Lists
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $lists `
                    -Retrievals $Retrievals
                Write-Output $lists
            } else {
                $list = $Web.Lists.GetById($Identity)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $list `
                    -Retrievals $Retrievals
                Write-Output $list
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'UrlSet') {
            $list = $Web.GetList($Url)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $list `
                -Retrievals $Retrievals
            Write-Output $list
        }
        if ($PSCmdlet.ParameterSetName -eq 'TitleSet') {
            $list = $Web.Lists.GetByTitle($Title)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $list `
                -Retrievals $Retrievals
            Write-Output $list
        }
    }

}
