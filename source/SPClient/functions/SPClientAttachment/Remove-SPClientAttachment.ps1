#Requires -Version 3.0

<#
  Remove-SPClientAttachment.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientAttachment {

<#
.SYNOPSIS
  Deletes the attachment.
.DESCRIPTION
  The Remove-SPClientAttachment function removes the attachment from the list item.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the attachment to delete.
.PARAMETER ParentObject
  Indicates the list item which the attachment is contained.
.PARAMETER FileName
  Indicates the attachment file name.
.EXAMPLE
  Remove-SPClientAttachment $attachment
.EXAMPLE
  Remove-SPClientAttachment $item -FileName "CustomAttachment.xlsx"
.INPUTS
  None or Microsoft.SharePoint.Client.Attachment or SPClient.SPClientAttachmentParentPipeBind
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientAttachment.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.Attachment]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'FileName')]
        [SPClient.SPClientAttachmentParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'FileName')]
        [string]
        $FileName
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('FileName')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'FileName'
            }
        } else {
            $ClientObjectCollection = $ParentObject.ClientObject.AttachmentFiles
            if ($PSCmdlet.ParameterSetName -eq 'FileName') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetByFileName', `
                    [object[]]$FileName)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Attachment($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'FileName'
                trap {
                    throw 'The specified attachment could not be found.'
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
