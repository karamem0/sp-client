#Requires -Version 3.0

<#
  Get-SPClientView.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
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
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the list which the views are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the view GUID.
.PARAMETER Url
  Indicates the view URL.
.PARAMETER Title
  Indicates the view title.
.PARAMETER Default
  If specified, returns the default view.
.PARAMETER Retrieval
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
  Get-SPClientView $list -Retrieval "Title"
.INPUTS
  None or SPClient.SPClientViewParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.View[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientView.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientViewParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
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
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObjectCollection = $ParentObject.ClientObject.Views
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetById', `
                [object[]]$Identity)
            $ClientObject = New-Object Microsoft.SharePoint.Client.View($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified view could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $Url = ConvertTo-SPClientRelativeUrl -ClientContext $ClientContext -Url $Url
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval 'ServerRelativeUrl'
            $ClientObject = $ClientObjectCollection | Where-Object { $_.ServerRelativeUrl -eq $Url }
            if ($ClientObject -eq $null) {
                throw 'The specified view could not be found.'
            }
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
        }
        if ($PSCmdlet.ParameterSetName -eq 'Title') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByTitle', `
                [object[]]$Title)
            $ClientObject = New-Object Microsoft.SharePoint.Client.View($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified view could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Default') {
            $ClientObject = $ParentObject.ClientObject.DefaultView
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
        }
    }

}
