#Requires -Version 3.0

<#
  Get-SPClientFolder.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

<#
.SYNOPSIS
  Gets one or more folders.
.DESCRIPTION
  The Get-SPClientFolder function lists all folders or retrieves the specified folder.
  If not specified filterable parameter, returns all subfolders in the folder.
  Otherwise, returns a folder which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the folder which the subfolders are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Name
  Indicates the folder name.
.PARAMETER Web
  Indicates the site which the folders are contained.
.PARAMETER Identity
  Indicates the folder GUID.
.PARAMETER Url
  Indicates the folder URL.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientFolder $folder
.EXAMPLE
  Get-SPClientFolder $folder -Name "CustomFolder"
.EXAMPLE
  Get-SPClientFolder -Web $web -Identity "7F3120E3-0B31-46E9-9621-55ADAC4612E7"
.EXAMPLE
  Get-SPClientFolder -Web $web -Url "http://example.com/DocLib1/CustomFolder"
.EXAMPLE
  Get-SPClientFolder $folder -Retrieval "ServerRelativeUrl"
.INPUTS
  None or SPClient.SPClientFolderParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.Folder[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFolder.md
#>

function Get-SPClientFolder {

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'All')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [SPClient.SPClientFolderParentPipeBind]
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
            $ClientObjectCollection = $ParentObject.ClientObject.Folders
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
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
                -Retrieval $Retrieval
            Write-Output $ClientObject
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
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified folder could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $Web.Path, `
                'GetFolderByServerRelativeUrl', `
                [object[]]$Url)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Folder($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified folder could not be found.'
            }
        }
    }

}
