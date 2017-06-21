#Requires -Version 3.0

<#
  Get-SPClientFile.ps1

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

<#
.SYNOPSIS
  Gets one or more files.
.DESCRIPTION
  The Get-SPClientFile function lists all files or retrieve the specified file.
  If not specified filterable parameter, returns all files in the folder.
  Otherwise, returns a file which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentFolder
  Indicates the folder which the files are contained.
.PARAMETER ParentWeb
  Indicates the web which the files are contained.
.PARAMETER Name
  Indicates the file name including the extension.
.PARAMETER Identity
  Indicates the file GUID.
.PARAMETER Url
  Indicates the file URL.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientFile $folder
.EXAMPLE
  Get-SPClientFile $folder -Name "CustomFile.xlsx"
.EXAMPLE
  Get-SPClientFile $web -Identity "185C6C6E-7E79-4C80-88D8-7392B4CA47CB"
.EXAMPLE
  Get-SPClientFile $web -Url "http://example.com/DocLib1/CustomFile.xlsx"
.EXAMPLE
  Get-SPClientFile $folder -Retrievals "ServerRelativeUrl"
.INPUTS
  None or Microsoft.SharePoint.Client.Folder or Microsoft.SharePoint.Client.Web
.OUTPUTS
  Microsoft.SharePoint.Client.FileCollection or Microsoft.SharePoint.Client.File
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFile.md
#>

function Get-SPClientFile {

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'All')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [Microsoft.SharePoint.Client.Folder]
        $ParentFolder,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Url')]
        [Microsoft.SharePoint.Client.Web]
        $ParentWeb,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]
        $Name,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $ClientObjectCollection = $ParentFolder.Files
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrievals $Retrievals
            Write-Output @(, $ClientObjectCollection)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ParentWeb.Path, `
                'GetFileById', `
                [object[]]$Identity)
            $ClientObject = New-Object Microsoft.SharePoint.Client.File($ClientContext, $PathMethod)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified file could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $ClientObjectCollection = $ParentFolder.Files
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByUrl', `
                [object[]]$Name)
            $ClientObject = New-Object Microsoft.SharePoint.Client.File($ClientContext, $PathMethod)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified file could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ParentWeb.Path, `
                'GetFileByServerRelativeUrl', `
                [object[]]$Url)
            $ClientObject = New-Object Microsoft.SharePoint.Client.File($ClientContext, $PathMethod)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified file could not be found.'
            }
        }
    }

}
