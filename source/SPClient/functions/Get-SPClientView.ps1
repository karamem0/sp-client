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
  Gets SharePoint client view object.
.DESCRIPTION
  If not specified 'Identity', 'Title', and 'Default', returns all views.
 Otherwise, returns a view which matches the parameter.
.PARAMETER ClientContext
  Indicates the SharePoint client context.
  If not specified, uses the default context.
.PARAMETER List
  Indicates the SharePoint list object.
.PARAMETER Identity
  Indicates the SharePoint view GUID to get.
.PARAMETER Title
  Indicates the SharePoint view title to get.
.PARAMETER Default
  If specified, returns the default view.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Title')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'All')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Title')]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Default')]
        [Microsoft.SharePoint.Client.List]
        $List,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Title')]
        [String]
        $Title,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [Switch]
        $Default,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Title')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Default')]
        [String]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($List -eq $null) {
            throw "Cannot bind argument to parameter 'List' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $views = $List.Views
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $views `
                -Retrievals $Retrievals
            Write-Output @(,$views)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $view = $List.Views.GetById($Identity)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $view `
                -Retrievals $Retrievals
            Write-Output $view
        }
        if ($PSCmdlet.ParameterSetName -eq 'Title') {
            $view = $List.Views.GetByTitle($Title)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $view `
                -Retrievals $Retrievals
            Write-Output $view
        }
        if ($PSCmdlet.ParameterSetName -eq 'Default') {
            $view = $List.DefaultView
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $view `
                -Retrievals $Retrievals
            Write-Output $view
        }
    }

}
