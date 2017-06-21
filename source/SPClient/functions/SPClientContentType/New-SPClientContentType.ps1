#Requires -Version 3.0

<#
  New-SPClientContentType.ps1

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

function New-SPClientContentType {

<#
.SYNOPSIS
  Creates a new content type.
.DESCRIPTION
  The New-SPClientContentType function adds a new content type to the web.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the web or list which a content type to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Description
  Indicates the description.
.PARAMETER Group
  Indicates the group name.
.PARAMETER ParentContentType
  Indicates the parent content type.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientContentType $web -Name "Custom Content Type"
.INPUTS
  None or SPClient.SPClientContentTypeParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.ContentType
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientContentType.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientContentTypeParentParameter]
        $ParentObject,
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [string]
        $Group,
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ContentType]
        $ParentContentType,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
        $Creation.Name = $Name
        if ($PSBoundParameters.ContainsKey('Group')) {
            $Creation.Group = $Group
        }
        if ($PSBoundParameters.ContainsKey('ParentContentType')) {
            if (-not $ParentContentType.IsPropertyAvailable('Id')) {
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ParentContentType `
                    -Retrievals 'Id'
            }
            $Creation.ParentContentType = $ParentContentType
        }
        $ClientObject = $ParentObject.ClientObject.ContentTypes.Add($Creation)
        $ClientObject.Description = $Description
        $ClientObject.Update($false)
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
