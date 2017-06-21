#Requires -Version 3.0

<#
  Remove-SPClientFolder.ps1

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

function Remove-SPClientFolder {

<#
.SYNOPSIS
  Deletes the folder.
.DESCRIPTION
  The Remove-SPClientFolder function deletes the folder from the folder.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the folder to delete.
.PARAMETER ParentFolder
  Indicates the folder which the folders are contained.
.PARAMETER ParentWeb
  Indicates the web which the folders are contained.
.PARAMETER Name
  Indicates the folder name.
.PARAMETER Identity
  Indicates the folder GUID.
.PARAMETER Url
  Indicates the folder URL.
.EXAMPLE
  Remove-SPClientFolder $folder
.EXAMPLE
  Remove-SPClientFolder $folder -Name "Folder"
.EXAMPLE
  Remove-SPClientFolder $web -Url "http://example.com/DocLib1/Folder"
.INPUTS
  None or Microsoft.SharePoint.Client.Folder or Microsoft.SharePoint.Client.Web
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
        [Microsoft.SharePoint.Client.Folder]
        $ParentFolder,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Url')]
        [Microsoft.SharePoint.Client.Web]
        $ParentWeb,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('Title')]
        [string]
        $Name,
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
                Write-Host $ClientObject.ServerRelativeUrl
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'UniqueId,ServerRelativeUrl'
            }
        } else {
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ParentWeb.Path, `
                    'GetFolderById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Folder($ClientContext, $PathMethod)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified folder could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Name') {
                $ClientObjectCollection = $ParentFolder.Folders
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetByUrl', `
                    [object[]]$Name)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Folder($ClientContext, $PathMethod)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified folder could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Url') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ParentWeb.Path, `
                    'GetFolderByServerRelativeUrl', `
                    [object[]]$Url)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Folder($ClientContext, $PathMethod)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'UniqueId,ServerRelativeUrl'
                trap {
                    throw 'The specified folder could not be found.'
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
