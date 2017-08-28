#Requires -Version 3.0

<#
  Add-SPClientContentTypeField.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Add-SPClientContentTypeField {


<#
.SYNOPSIS
  Adds a column to the content type.
.DESCRIPTION
  The Add-SPClientContentTypeField function adds a exsiting site column to the specified content type.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ContentType
  Indicates the content type.
.PARAMETER Field
  Indicates the column to add.
.PARAMETER UpdateChildren
  If specified, updates all content types that inherit from the content type.
.PARAMETER PassThru
  If specified, returns the content type.
.EXAMPLE
  Add-SPClientContentTypeField $contentType -Field $field -UpdateChildren
.INPUTS
  None or Microsoft.SharePoint.Client.ContentType
.OUTPUTS
  None or Microsoft.SharePoint.Client.ContentType
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Add-SPClientContentTypeField.md
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
        $FieldLink = New-Object Microsoft.SharePoint.Client.FieldLinkCreationInformation
        $FieldLink.Field = $Field
        $FieldLink = $ContentType.FieldLinks.Add($FieldLink)
        $ContentType.Update($UpdateChildren)
        $ClientContext.ExecuteQuery()
        if ($PassThru) {
            Write-Output $ContentType
        }
    }

}
