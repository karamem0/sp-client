#Requires -Version 3.0

<#
  New-SPClientFolder.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientFolder {

<#
.SYNOPSIS
  Creates a new folder.
.DESCRIPTION
  The New-SPClientFolder function adds a new subfolder to the folder.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the folder which a subfolder to be created.
.PARAMETER Name
  Indicates the folder name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFolder $folder -Name "CustomFolder"
.INPUTS
  None or SPClient.SPClientFolderParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.Folder
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFolder.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFolderParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObject = $ParentObject.ClientObject.Folders.Add($Name)
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
