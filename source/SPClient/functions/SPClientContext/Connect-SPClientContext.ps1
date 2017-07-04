#Requires -Version 3.0

<#
  Connect-SPClientContext.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Connect-SPClientContext {

<#
.SYNOPSIS
  Connects to SharePoint site.
.DESCRIPTION
  The Connect-SPClientContext function creates a new client context and sets to current.
.PARAMETER Network
  If specified, connects to SharePoint Server (On-premise).
.PARAMETER Online
  If specified, connects to SharePoint Online.
.PARAMETER Url
  Indicates the site url.
.PARAMETER UserName
  Indicates the user name.
.PARAMETER Password
  Indicates the password.
.PARAMETER Domain
  Indicates the domain.
.PARAMETER Credential
  Indicates the credential.
.PARAMETER PassThru
  If specified, returns a client context.
.EXAMPLE
  Connect-SPClientContext -Network -Url "https://example.com" -UserName "admin" -Password (ConvertTo-SecureString -String "p@ssword" -AsPlainText -Force) -Domain "example.com"
.EXAMPLE
  Connect-SPClientContext -Online -Url "https://example.sharepoint.com" -Credential $credential
.INPUTS
  None or System.Management.Automation.PSCredential
.OUTPUTS
  None or Microsoft.SharePoint.Client.ClientContext
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Connect-SPClientContext.md
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
        [Parameter(Mandatory = $true)]
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
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'NetworkCredential')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'OnlineCredential')]
        [PSCredential]
        $Credential,
        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru
    )

    process {
        $ClientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Url)
        if ($PSCmdlet.ParameterSetName -eq 'NetworkPassword') {
            $ClientContext.Credentials = New-Object System.Net.NetworkCredential($UserName, $Password, $Domain)
        }
        if ($PSCmdlet.ParameterSetName -eq 'NetworkCredential') {
            $ClientContext.Credentials = $Credential.GetNetworkCredential()
        }
        if ($PSCmdlet.ParameterSetName -eq 'OnlinePassword') {
            $ClientContext.Credentials =
                New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
        }
        if ($PSCmdlet.ParameterSetName -eq 'OnlineCredential') {
            $UserName = $Credential.UserName
            $Password = $Credential.Password
            $ClientContext.Credentials =
                New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
        }
        $SPClient.ClientContext = $ClientContext
        if ($PassThru) {
            Write-Output $ClientContext
        }
    }

}
