#Requires -Version 3.0

# New-SPClientFile.ps1
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

function New-SPClientFile {

<#
.SYNOPSIS
  Creates a new file.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses default context.
.PARAMETER ParentFolder
  Indicates the folder which a file to be created.
.PARAMETER ContentPath
  Indicates the content file path.
.PARAMETER ContentStream
  Indicates the content stream.
.PARAMETER Name
  Indicates the file name.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'ContentStream')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.Folder]
        $ParentFolder,
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
            if ($MyInvocation.BoundParameters.ContainsKey('Name')) {
                $Creation.Url = $Name
            } else {
                $Creation.Url = [System.IO.Path]::GetFileName($ContentPath)
            }
        }
        $ClientObject = $ParentFolder.Files.Add($Creation)
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}
