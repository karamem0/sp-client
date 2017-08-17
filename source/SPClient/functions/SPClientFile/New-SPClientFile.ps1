#Requires -Version 3.0

<#
  New-SPClientFile.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientFile {

<#
.SYNOPSIS
  Creates a new file.
.DESCRIPTION
  The New-SPClientFile function adds a new file to the folder.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the folder which a file to be created.
.PARAMETER ContentPath
  Indicates the content file path.
.PARAMETER ContentStream
  Indicates the content stream.
.PARAMETER Name
  Indicates the file name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFile $folder -Name "CustomFile.xlsx" -ContentStream $stream
.EXAMPLE
  New-SPClientFile $folder -ContentPath "C:\Users\admin\Documents\CustomFile.xlsx"
.INPUTS
  None or SPClient.SPClientFileParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.File
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFile.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ContentStream')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFileParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'ContentStream')]
        [System.IO.Stream]
        $ContentStream,
        [Parameter(Mandatory = $true, ParameterSetName = 'ContentPath')]
        [string]
        $ContentPath,
        [Parameter(Mandatory = $true, ParameterSetName = 'ContentStream')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ContentPath')]
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
        $Creation = New-Object Microsoft.SharePoint.Client.FileCreationInformation
        if ($PSCmdlet.ParameterSetName -eq 'ContentStream') {
            $Creation.ContentStream = $ContentStream
            $Creation.Url = $Name
        }
        if ($PSCmdlet.ParameterSetName -eq 'ContentPath') {
            if (-not (Test-Path -Path $ContentPath)) {
                throw "Cannot find file '$($ContentPath)'."
            }
            $Creation.ContentStream = [System.IO.File]::OpenRead($ContentPath)
            if ($PSBoundParameters.ContainsKey('Name')) {
                $Creation.Url = $Name
            } else {
                $Creation.Url = [System.IO.Path]::GetFileName($ContentPath)
            }
        }
        $ClientObject = $ParentObject.ClientObject.Files.Add($Creation)
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
