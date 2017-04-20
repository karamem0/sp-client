#Requires -Version 3.0

# Connect-SPClientContext.ps1
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

function Connect-SPClientContext {

<#
.SYNOPSIS
  Creates SharePoint client context.
.PARAMETER Url
  Indicates the SharePoint site url to connect.
.PARAMETER Network
  If specified, connects to SharePoint Server (On-premise).
.PARAMETER Online
  If specified, connects to SharePoint Online.
.PARAMETER UserName
  Indicates the user name to log-in.
.PARAMETER Password
  Indicates the password to log-in.
.PARAMETER Domain
  Indicates the domain to log-in.
#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [String]
        $Url,
        [Parameter(Position = 1, Mandatory = $true, ParameterSetName = "NetworkSet")]
        [Switch]
        $Network,
        [Parameter(Position = 2, Mandatory = $true, ParameterSetName = "OnlineSet")]
        [Switch]
        $Online,
        [Parameter(Position = 3, Mandatory = $true)]
        [String]
        $UserName,
        [Parameter(Position = 4, Mandatory = $true)]
        [SecureString]
        $Password,
        [Parameter(Position = 5, Mandatory = $true, ParameterSetName = "NetworkSet")]
        [String]
        $Domain
    )

    process {
        $clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Url)
        if ($Network -eq $true) {
            $credentials = New-Object System.Net.NetworkCredential($UserName, $Password, $Domain)
            $clientContext.Credentials = $credentials
        }
        if ($Online -eq $true) {
            $credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
            $clientContext.Credentials = $credentials
        }
        $SPClient.ClientContext = $clientContext
        Write-Output $clientContext
    }

}
