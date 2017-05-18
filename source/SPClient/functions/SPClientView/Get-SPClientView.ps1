#Requires -Version 3.0

# Get-SPClientView.ps1
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

function Get-SPClientView {

<#
.SYNOPSIS
  Lists all views or retrieve the specified view.
.DESCRIPTION
  If not specified 'Identity', 'Name', and 'Default', returns all views.
  Otherwise, returns a view which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the list which the views are contained.
.PARAMETER Identity
  Indicates the view GUID.
.PARAMETER Url
  Indicates the view url.
.PARAMETER Title
  Indicates the view title.
.PARAMETER Default
  If specified, returns the default view.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Title')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.List]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url,
        [Parameter(Mandatory = $true, ParameterSetName = 'Title')]
        [string]
        $Title,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [switch]
        $Default,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObjectCollection = $ParentObject.Views
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrievals $Retrievals
            Write-Output @(, $ClientObjectCollection)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetById', `
                [object[]]$Identity)
            $ClientObject = New-Object Microsoft.SharePoint.Client.View($ClientContext, $PathMethod);
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified view could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrievals 'ServerRelativeUrl'
            $ClientObject = $ClientObjectCollection | Where-Object { $_.ServerRelativeUrl -eq $Url }
            if ($ClientObject -eq $null) {
                throw 'The specified view could not be found.'
            }
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
        }
        if ($PSCmdlet.ParameterSetName -eq 'Title') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByTitle', `
                [object[]]$Title)
            $ClientObject = New-Object Microsoft.SharePoint.Client.View($ClientContext, $PathMethod);
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified view could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Default') {
            $ClientObject = $ParentObject.DefaultView
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
        }
    }

}
