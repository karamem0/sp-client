#Requires -Version 3.0

# New-SPClientContentType.ps1
#
# Copyright (c) 2017 karamem0
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function New-SPClientContentType {

<#
.SYNOPSIS
  Creates a new content type.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses the default context.
.PARAMETER ParentObject
  Indicates the web which a content type to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Description
  Indicates the description.
.PARAMETER Group
  Indicates the group name.
.PARAMETER ParentContentType
  Indicates the ID or name of parent content type.
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.Web]
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
        [string]
        $ParentContentType
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
        $Creation.Name = $Name
        if ($MyInvocation.BoundParameters.ContainsKey('Group')) {
            $Creation.Group = $Group
        }
        if ($MyInvocation.BoundParameters.ContainsKey('ParentContentType')) {
            $ContentTypeCollection = $ClientContext.Site.RootWeb.ContentTypes
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ContentTypeCollection `
                -Retrievals 'Include(StringId,Name)'
            $ContentType = $ContentTypeCollection | Where-Object {
                $_.StringId -eq $ParentContentType -or
                $_.Name -eq $ParentContentType
            }
            if ($ContentType -eq $null) {
                throw 'The specified content type could not be found.'
            }
            $Creation.ParentContentType = $ContentType
        }
        $ClientObject = $ParentObject.ContentTypes.Add($Creation)
        $ClientObject.Description = $Description
        $ClientObject.Update($true)
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject
        Write-Output $ClientObject
    }

}
