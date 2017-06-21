#Requires -Version 3.0

<#
  Get-SPClientView.ps1

  Copyright (c) 2017 karamem0

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
#>

function Get-SPClientView {

<#
.SYNOPSIS
  Gets one or more views.
.DESCRIPTION
  The Get-SPClientView function lists all views or retrieves the specified view.
  If not specified filterable parameter, returns all views of the list.
  Otherwise, returns a view which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentList
  Indicates the list which the views are contained.
.PARAMETER Identity
  Indicates the view GUID.
.PARAMETER Url
  Indicates the view URL.
.PARAMETER Title
  Indicates the view title.
.PARAMETER Default
  If specified, returns the default view.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientView $list
.EXAMPLE
  Get-SPClientView $list -Identity "E9F79B5B-4A14-46A9-983C-78387C40255B"
.EXAMPLE
  Get-SPClientView $list -Url "/Lists/List1/CustomView.aspx"
.EXAMPLE
  Get-SPClientView $list -Title "Custom View"
.EXAMPLE
  Get-SPClientView $list -Default
.EXAMPLE
  Get-SPClientView $list -Retrievals "Title"
.INPUTS
  None or Microsoft.SharePoint.Client.List
.OUTPUTS
  Microsoft.SharePoint.Client.ViewCollection or Microsoft.SharePoint.Client.View
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientView.md
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
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.List]
        $ParentList,
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
        $ClientObjectCollection = $ParentList.Views
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
            $ClientObject = New-Object Microsoft.SharePoint.Client.View($ClientContext, $PathMethod)
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
            $ClientObject = New-Object Microsoft.SharePoint.Client.View($ClientContext, $PathMethod)
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
            $ClientObject = $ParentList.DefaultView
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
        }
    }

}
