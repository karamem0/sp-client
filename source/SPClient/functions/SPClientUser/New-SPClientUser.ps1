
#Requires -Version 3.0

# New-SPClientUser.ps1
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

function New-SPClientUser {

<#
.SYNOPSIS
  Creates a new user.
.DESCRIPTION
  The New-SPClientUser function adds a new user to the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER Name
  Indicates the login name.
.PARAMETER Title
  Indicates the display name.
.PARAMETER Email
  Indicates the E-mail.
.PARAMETER IsSiteAdmin
  Indicates a value whether the user is a site collection administrator.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientUser -Name "i:0#.f|membership|john@example.com"
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true)]
        [Alias('LoginName')]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Title,
        [Parameter(Mandatory = $false)]
        [string]
        $Email,
        [Parameter(Mandatory = $false)]
        [bool]
        $IsSiteAdmin,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.UserCreationInformation
        $Creation.LoginName = $Name
        $Creation.Email = $Email
        $Creation.Title = $Title
        $ClientObject = $ClientContext.Site.RootWeb.SiteUsers.Add($Creation)
        if ($PSBoundParameters.ContainsKey('IsSiteAdmin')) {
            $ClientObject.IsSiteAdmin = $IsSiteAdmin
        }
        $ClientObject.Update()
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
