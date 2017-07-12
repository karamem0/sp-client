#Requires -Version 3.0

<#
  Get-SPClientAttachment.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientAttachment {

<#
.SYNOPSIS
  Gets one or more attachments.
.DESCRIPTION
  The Get-SPClientAttachment function lists all attachments or retrieves the specified attachment.
  If not specified filterable parameter, returns all attachments of the list item.
  Otherwise, returns a attachment which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the list item which the attachments are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER FileName
  Indicates the attachment file name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientAttachment $item
.EXAMPLE
  Get-SPClientAttachment $item -FileName "CustomAttachment.xlsx"
.EXAMPLE
  Get-SPClientAttachment $item -Retrieval "FileName"
.INPUTS
  None or SPClient.SPClientAttachmentParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.Attachment[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientAttachment.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientAttachmentParentParameter]
        $ParentObject,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
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
        $ClientObjectCollection = $ParentObject.ClientObject.AttachmentFiles
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByFileName', `
                [object[]]$Name)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Attachment($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified attachment could not be found.'
            }
        }
    }

}
