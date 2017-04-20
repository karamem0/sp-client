#Requires -Version 3.0

# New-SPClientList.ps1
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

function New-SPClientList {

<#
.SYNOPSIS
  Creates a new list.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses the default context.
.PARAMETER Web
  Indicates the web which a list to be created.
  If not specified, uses the default web.
.PARAMETER Title
  Indicates the title.
.PARAMETER Description
  Indicates the description.
.PARAMETER Url
  Indicates the url.
  If not specified, uses the title.
.PARAMETER Template
  Indicates the template ID.
  If not specified, uses 100 (Generic List).
.PARAMETER QuickLaunch
  If specified, the list is displayed on the quick launch.
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.Web]
        $Web = $SPClient.ClientContext.Web,
        [Parameter(Mandatory = $true)]
        [string]
        $Title,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [string]
        $Url,
        [Parameter(Mandatory = $false)]
        [int]
        $Template = 100,
        [Parameter(Mandatory = $false)]
        [switch]
        $QuickLaunch
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($Web -eq $null) {
            throw "Cannot bind argument to parameter 'Web' because it is null."
        }
        $creation = New-Object Microsoft.SharePoint.Client.ListCreationInformation
        $creation.Title = $Title
        $creation.Description = $Description
        $creation.TemplateType = $Template
        $object = $Web.Lists.Add($creation)
        $object.OnQuickLaunch = $QuickLaunch
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $object
        Write-Output $object
    }

}
