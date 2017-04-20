#Requires -Version 3.0

# Get-SPClientField.ps1
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

function Get-SPClientField {

<#
.SYNOPSIS
  Get SharePoint client field object.
.DESCRIPTION
  If not specified 'Identity' and 'Title', returns all fields.
  Otherwise, returns a field which matches the parameter.
.PARAMETER ClientContext
  Indicates the SharePoint client context.
  If not specified, uses the default context.
.PARAMETER List
  Indicates the SharePoint list object.
.PARAMETER Identity
  Indicates the SharePoint field GUID to get.
.PARAMETER Title
  Indicates the SharePoint field title or internal name to get.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.List]
        $List,
        [Parameter(Position = 2, Mandatory = $false, ParameterSetName = 'IdentitySet')]
        [Guid]
        $Identity,
        [Parameter(Position = 3, Mandatory = $true, ParameterSetName = 'TitleSet')]
        [String]
        $Title,
        [Parameter(Position = 4, Mandatory = $false)]
        [String]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($List -eq $null) {
            throw "Cannot bind argument to parameter 'List' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'IdentitySet') {
            if ($Identity -eq $null) {
                $fields = $List.Fields
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $fields `
                    -Retrievals $Retrievals
                Write-Output $fields
            } else {
                $field = $List.Fields.GetById($Identity)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $field `
                    -Retrievals $Retrievals
                Write-Output $field
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'TitleSet') {
            $field = $List.Fields.GetByInternalNameOrTitle($Title)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $field `
                -Retrievals $Retrievals
            Write-Output $field
        }
    }

}
