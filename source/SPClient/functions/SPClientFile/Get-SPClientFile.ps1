#Requires -Version 3.0

<#
  Get-SPClientFile.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
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
.PARAMETER ParentObject
  Indicates the folder which the files are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Name
  Indicates the file name including the extension.
.PARAMETER Web
  Indicates the site which the files are contained.
.PARAMETER Identity
  Indicates the file GUID.
.PARAMETER Url
  Indicates the file URL.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientFile $folder
.EXAMPLE
  Get-SPClientFile $folder -Name "CustomFile.xlsx"
.EXAMPLE
  Get-SPClientFile -Web $web -Identity "185C6C6E-7E79-4C80-88D8-7392B4CA47CB"
.EXAMPLE
  Get-SPClientFile -Web $web -Url "http://example.com/DocLib1/CustomFile.xlsx"
.EXAMPLE
  Get-SPClientFile $folder -Retrieval "ServerRelativeUrl"
.INPUTS
  None or SPClient.SPClientFileParentParameter
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
        [SPClient.SPClientFileParentParameter]
        $ParentObject,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
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
        $Url,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $ClientObjectCollection = $ParentObject.ClientObject.Files
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
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
                -Retrieval $Retrieval
            Write-Output $ClientObject
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
                -Retrieval $Retrieval
            Write-Output $ClientObject
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
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified file could not be found.'
            }
        }
    }

}
