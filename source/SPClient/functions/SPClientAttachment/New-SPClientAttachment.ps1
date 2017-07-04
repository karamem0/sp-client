#Requires -Version 3.0

<#
  New-SPClientAttachment.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientAttachment {

<#
.SYNOPSIS
  Creates a new attachment.
.DESCRIPTION
  The New-SPClientAttachment function adds a new attachment to the list item.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the list item which a attachment to be created.
.PARAMETER ContentPath
  Indicates the content file path.
.PARAMETER ContentStream
  Indicates the content stream.
.PARAMETER FileName
  Indicates the file name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientAttachment $item -Name "CustomAttachment.xlsx" -ContentStream $stream
.EXAMPLE
  New-SPClientAttachment $item -ContentPath "C:\Users\admin\Documents\CustomAttachment.xlsx"
.INPUTS
  None or SPClient.SPClientAttachmentParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.Attachment
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientAttachment.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ContentStream')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientAttachmentParentParameter]
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
        $Creation = New-Object Microsoft.SharePoint.Client.AttachmentCreationInformation
        if ($PSCmdlet.ParameterSetName -eq 'ContentStream') {
            $Creation.ContentStream = $ContentStream
            $Creation.FileName = $Name
        }
        if ($PSCmdlet.ParameterSetName -eq 'ContentPath') {
            if (-not (Test-Path -Path $ContentPath)) {
                throw "Cannot find file '$($ContentPath)'."
            }
            $Creation.ContentStream = [System.IO.File]::OpenRead($ContentPath)
            if ($PSBoundParameters.ContainsKey('Name')) {
                $Creation.FileName = $Name
            } else {
                $Creation.FileName = [System.IO.Path]::GetFileName($ContentPath)
            }
        }
        $ClientObject = $ParentObject.ClientObject.AttachmentFiles.Add($Creation)
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
