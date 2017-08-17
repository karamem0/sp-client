#Requires -Version 3.0

<#
  Disconnect-SPClientContext.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Disconnect-SPClientContext {

<#
.SYNOPSIS
  Disconnects from SharePoint site.
.DESCRIPTION
  The Disconnect-SPClientContext function disposes the current client context.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.EXAMPLE
  Disconnect-SPClientContext
.INPUTS
  None
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Disconnect-SPClientContext.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientContext.Dispose()
        $ClientContext = $null
    }

}
