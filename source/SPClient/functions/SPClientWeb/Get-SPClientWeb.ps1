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
  Lists all webs or retrieve the specified web.
.DESCRIPTION
  If not specified filterable parameter, returns default web and its
  descendants. Otherwise, returns a web which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses default context.
.PARAMETER Identity
  Indicates the web GUID.
.PARAMETER Url
  Indicates the web relative url.
.PARAMETER Default
  If specified, returns default web of the client context.
.PARAMETER Root
  If specified, returns root web.
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
        [Alias('Id')]
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
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $ClientObject = $ClientContext.Web
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            $Stack = New-Object System.Collections.Stack
            do {
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject.Webs `
                    -Retrievals $Retrievals
                while ($ClientObject.Webs.Count -gt 0) {
                    $Item = @{
                        Collection = $ClientObject.Webs
                        Index = 0
                    }
                    $Stack.Push($Item)
                    $ClientObject = $Item.Collection[$Item.Index]
                    Write-Output $ClientObject
                    Invoke-SPClientLoadQuery `
                        -ClientContext $ClientContext `
                        -ClientObject $ClientObject.Webs `
                        -Retrievals $Retrievals
                }
                while ($Stack.Count -gt 0) {
                    $Item = $Stack.Pop()
                    $Item.Index += 1
                    if ($Item.Index -lt $Item.Collection.Count) {
                        $Stack.Push($Item)
                        $ClientObject = $Item.Collection[$Item.Index]
                        Write-Output $ClientObject
                        break
                    }
                }
            } while ($Stack.Count -gt 0)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientContext.Site.Path, `
                'OpenWebById', `
                [object[]]$Identity)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Web($ClientContext, $PathMethod)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified web could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientContext.Site.Path, `
                'OpenWeb', `
                [object[]]$Url)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Web($ClientContext, $PathMethod)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified web could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Default') {
            $ClientObject = $ClientContext.Web
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
        }
        if ($PSCmdlet.ParameterSetName -eq 'Root') {
            $ClientObject = $ClientContext.Site.RootWeb
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
        }
    }

}
