#Requires -Version 3.0

<#
  New-SPClientListItemAttachment.ps1

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

function New-SPClientListItemAttachment {

<#
.SYNOPSIS
  Creates a new attachment.
.DESCRIPTION
  The New-SPClientListItemAttachment function adds a new attachment to the list
  item.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentListItem
  Indicates the list item which a attachment to be created.
.PARAMETER ContentPath
  Indicates the content file path.
.PARAMETER ContentStream
  Indicates the content stream.
.PARAMETER FileName
  Indicates the file name.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientListItemAttachment $item -Name "CustomAttachment.xlsx" -ContentStream $stream
.EXAMPLE
  New-SPClientListItemAttachment $item -ContentPath "C:\Users\admin\Documents\CustomAttachment.xlsx"
.INPUTS
  None or Microsoft.SharePoint.Client.ListItem
.OUTPUTS
  Microsoft.SharePoint.Client.Attachment
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientListItemAttachment.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ContentStream')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.ListItem]
        $ParentListItem,
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
        $Retrievals
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
        $ClientObject = $ParentListItem.AttachmentFiles.Add($Creation)
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
