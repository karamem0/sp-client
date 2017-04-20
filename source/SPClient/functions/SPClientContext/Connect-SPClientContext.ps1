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
  Connects to SharePoint site.
.PARAMETER Url
  Indicates the site url to connect.
.PARAMETER Network
  If specified, connects to SharePoint Server (On-premise).
.PARAMETER Online
  If specified, connects to SharePoint Online.
.PARAMETER UserName
  Indicates the user name to login.
.PARAMETER Password
  Indicates the password to login.
.PARAMETER Domain
  Indicates the domain to login.
.PARAMETER Credential
  Indicates the credential to login.
.PARAMETER PassThru
  If specified, returns a client context.
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'NetworkPassword')]
        [Parameter(Mandatory = $true, ParameterSetName = 'NetworkCredential')]
        [switch]
        $Network,
        [Parameter(Mandatory = $true, ParameterSetName = 'OnlinePassword')]
        [Parameter(Mandatory = $true, ParameterSetName = 'OnlineCredential')]
        [switch]
        $Online,
        [Parameter(Mandatory = $true, ParameterSetName = 'NetworkPassword')]
        [Parameter(Mandatory = $true, ParameterSetName = 'NetworkCredential')]
        [Parameter(Mandatory = $true, ParameterSetName = 'OnlinePassword')]
        [Parameter(Mandatory = $true, ParameterSetName = 'OnlineCredential')]
        [string]
        $Url,
        [Parameter(Mandatory = $true, ParameterSetName = 'NetworkPassword')]
        [Parameter(Mandatory = $true, ParameterSetName = 'OnlinePassword')]
        [string]
        $UserName,
        [Parameter(Mandatory = $true, ParameterSetName = 'NetworkPassword')]
        [Parameter(Mandatory = $true, ParameterSetName = 'OnlinePassword')]
        [securestring]
        $Password,
        [Parameter(Mandatory = $true, ParameterSetName = 'NetworkPassword')]
        [string]
        $Domain,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'NetworkCredential')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'OnlineCredential')]
        [PSCredential]
        $Credential,
        [Parameter(Mandatory = $false, ParameterSetName = 'NetworkPassword')]
        [Parameter(Mandatory = $false, ParameterSetName = 'NetworkCredential')]
        [Parameter(Mandatory = $false, ParameterSetName = 'OnlinePassword')]
        [Parameter(Mandatory = $false, ParameterSetName = 'OnlineCredential')]
        [switch]
        $PassThru
    )

    process {
        $clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Url)
        if ($PSCmdlet.ParameterSetName -eq 'NetworkPassword') {
            $cred = New-Object System.Net.NetworkCredential($UserName, $Password, $Domain)
            $clientContext.Credentials = $cred
        }
        if ($PSCmdlet.ParameterSetName -eq 'NetworkCredential') {
            $cred = $Credential.GetNetworkCredential()
            $clientContext.Credentials = $cred
        }
        if ($PSCmdlet.ParameterSetName -eq 'OnlinePassword') {
            $cred = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
            $clientContext.Credentials = $cred
        }
        if ($PSCmdlet.ParameterSetName -eq 'OnlineCredential') {
            $name = $Credential.UserName
            $pass = $Credential.Password
            $cred = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($name, $pass)
            $clientContext.Credentials = $cred
        }
        $SPClient.ClientContext = $clientContext
        if ($PassThru -eq $true) {
            Write-Output $clientContext
        }
    }

}
