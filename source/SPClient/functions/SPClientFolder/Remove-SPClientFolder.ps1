#Requires -Version 3.0

<#
  Remove-SPClientFolder.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientFolder {

<#
.SYNOPSIS
  Deletes the folder.
.DESCRIPTION
  The Remove-SPClientFolder function removes the subfolder from the folder.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the folder to delete.
.PARAMETER ParentObject
  Indicates the folder which the folders are contained.
.PARAMETER Name
  Indicates the folder name.
.PARAMETER Web
  Indicates the site which the folders are contained.
.PARAMETER Identity
  Indicates the folder GUID.
.PARAMETER Url
  Indicates the folder URL.
.EXAMPLE
  Remove-SPClientFolder $folder
.EXAMPLE
  Remove-SPClientFolder $folder -Name "Folder"
.EXAMPLE
  Remove-SPClientFolder -Web $web -Url "http://example.com/DocLib1/Folder"
.INPUTS
  None or SPClient.SPClientFolderParentPipeBind
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientFolder.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.Folder]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [SPClient.SPClientFolderParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('Title')]
        [string]
        $Name,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [Microsoft.SharePoint.Client.Web]
        $Web,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('ServerRelativeUrl')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'UniqueId,ServerRelativeUrl'
            }
        } else {
            if ($PSCmdlet.ParameterSetName -eq 'Name') {
                $ClientObjectCollection = $ParentObject.ClientObject.Folders
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetByUrl', `
                    [object[]]$Name)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Folder($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified folder could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $Web.Path, `
                    'GetFolderById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Folder($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified folder could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Url') {
                $Url = ConvertTo-SPClientRelativeUrl -ClientContext $ClientContext -Url $Url
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $Web.Path, `
                    'GetFolderByServerRelativeUrl', `
                    [object[]]$Url)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Folder($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified folder could not be found.'
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
