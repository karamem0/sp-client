#Requires -Version 3.0

<#
  Remove-SPClientFile.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientFile {

<#
.SYNOPSIS
  Deletes the file.
.DESCRIPTION
  The Remove-SPClientFile function removes the file from the folder.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the file to delete.
.PARAMETER ParentObject
  Indicates the folder which the files are contained.
.PARAMETER Name
  Indicates the file name including the extension.
.PARAMETER Web
  Indicates the site which the files are contained.
.PARAMETER Identity
  Indicates the file GUID.
.PARAMETER Url
  Indicates the file URL.
.EXAMPLE
  Remove-SPClientFile $file
.EXAMPLE
  Remove-SPClientFile $folder -Name "CustomFile.xlsx"
.EXAMPLE
  Remove-SPClientFile -Web $web -Identity "185C6C6E-7E79-4C80-88D8-7392B4CA47CB"
.EXAMPLE
  Remove-SPClientFile -Web $web -Url "http://example.com/DocLib1/CustomFile.xlsx"
.INPUTS
  None or SPClient.SPClientFileParentPipeBind
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientFile.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.File]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [SPClient.SPClientFileParentPipeBind]
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
                $ClientObjectCollection = $ParentObject.ClientObject.Files
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetByUrl', `
                    [object[]]$Name)
                $ClientObject = New-Object Microsoft.SharePoint.Client.File($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified file could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $Web.Path, `
                    'GetFileById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.File($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified file could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Url') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $Web.Path, `
                    'GetFileByServerRelativeUrl', `
                    [object[]]$Url)
                $ClientObject = New-Object Microsoft.SharePoint.Client.File($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified file could not be found.'
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
