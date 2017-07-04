#Requires -Version 3.0

<#
  Remove-SPClientView.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientView {

<#
.SYNOPSIS
  Deletes the view.
.DESCRIPTION
  The Remove-SPClientView function removes the view from the list.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the view to delete.
.PARAMETER ParentObject
  Indicates the list which the view is contained.
.PARAMETER Identity
  Indicates the view GUID.
.PARAMETER Url
  Indicates the view URL.
.PARAMETER Title
  Indicates the view title.
.EXAMPLE
  Remove-SPClientView $view
.EXAMPLE
  Remove-SPClientView $list -Identity "E9F79B5B-4A14-46A9-983C-78387C40255B"
.EXAMPLE
  Remove-SPClientView $list -Url "/Lists/List1/CustomView.aspx"
.EXAMPLE
  Remove-SPClientView $list -Title "Custom View"
.INPUTS
  None or Microsoft.SharePoint.Client.View or SPClient.SPClientViewParentParameter
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientView.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.View]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Title')]
        [SPClient.SPClientViewParentParameter]
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
        $Title
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('Id')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
            }
        } else {
            $ClientObjectCollection = $ParentObject.ClientObject.Views
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
                    -Retrieval 'Id'
                trap {
                    throw 'The specified view could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Url') {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObjectCollection `
                    -Retrieval 'Include(Id,ServerRelativeUrl)'
                $ClientObject = $ClientObjectCollection | Where-Object { $_.ServerRelativeUrl -eq $Url }
                if ($ClientObject -eq $null) {
                    throw 'The specified view could not be found.'
                }
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
                    -Retrieval 'Id'
                trap {
                    throw 'The specified view could not be found.'
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
