#Requires -Version 3.0

# Add-SPClientType.ps1
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

function Add-SPClientType {

<#
.SYNOPSIS
  Loads SharePoint Client Components assemblies.
.DESCRIPTION
  Usually this cmdlet loads assemblies below.
    - %COMMONPROGRAMFILES%\Microsoft Shared\Web Server Extensions\<VERSION>\ISAPI
      - Microsoft.SharePoint.Client.dll
      - Microsoft.SharePoint.Client.Runtime.dll
.PARAMETER Version
  Indicates the version of SharePoint Client Components.
  The version must be "15" (SharePoint 2013), or "16" (SharePoint 2016).
  If not specified, uses the latest version.
#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [ValidateSet("15", "16")]
        [String]
        $Version
    )

    process {
        $path = Join-Path $Env:CommonProgramFiles 'Microsoft Shared\Web Server Extensions'
        if (-not (Test-Path $path)) {
            throw 'SharePoint Client Component is not installed.'
        }
        if (-not (Get-ChildItem $path)) {
            throw 'SharePoint Client Component is not installed.'
        }
        if ([String]::IsNullOrEmpty($Version)) {
            $Version = [String](Get-ChildItem $path | Sort-Object -Descending)[0]
        }
        $path = Join-Path $path $Version
        $path = Join-Path $path 'ISAPI'
        Add-Type -Path (Join-Path $path 'Microsoft.SharePoint.Client.dll')
        Add-Type -Path (Join-Path $path 'Microsoft.SharePoint.Client.Runtime.dll')
    }

}
