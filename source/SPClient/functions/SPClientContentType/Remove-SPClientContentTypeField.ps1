#Requires -Version 3.0

<#
  Remove-SPClientContentTypeField.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientContentTypeField {


<#
.SYNOPSIS
  Removes a column from the content type.
.DESCRIPTION
  The Remove-SPClientContentTypeField function removes a column to the specified content type.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ContentType
  Indicates the content type.
.PARAMETER Field
  Indicates the column to remove.
.PARAMETER UpdateChildren
  If specified, updates all content types that inherit from the content type.
.PARAMETER PassThru
  If specified, returns the content type.
.EXAMPLE
  Remove-SPClientContentTypeField $contentType -Field $field -UpdateChildren
.INPUTS
  None or Microsoft.SharePoint.Client.ContentType
.OUTPUTS
  None or Microsoft.SharePoint.Client.ContentType
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientContentTypeField.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.ContentType]
        $ContentType,
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.Field]
        $Field,
        [Parameter(Mandatory = $false)]
        [switch]
        $UpdateChildren,
        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if (-not $ContentType.IsPropertyAvailable('Id')) {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ContentType `
                -Retrieval 'Id'
        }
        if (-not $Field.IsPropertyAvailable('Id')) {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $Field `
                -Retrieval 'Id'
        }
        $FieldLinkCollection = $ContentType.FieldLinks
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $FieldLinkCollection `
            -Retrieval 'Id'
        $FieldLink = $FieldLinkCollection | Where-Object { $_.Id -eq $Field.Id }
        if ($FieldLink -eq $null) {
            throw 'The specified field could not be found.'
        }
        $FieldLink.DeleteObject()
        $ContentType.Update($UpdateChildren)
        $ClientContext.ExecuteQuery()
        if ($PassThru) {
            Write-Output $ContentType
        }
    }

}
