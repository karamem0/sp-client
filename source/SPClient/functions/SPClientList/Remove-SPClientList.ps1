#Requires -Version 3.0

<#
  Remove-SPClientList.ps1

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

function Remove-SPClientList {

<#
.SYNOPSIS
  Deletes the list.
.DESCRIPTION
  The Remove-SPClientList function deletes the list from the web.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the list to delete.
.PARAMETER ParentWeb
  Indicates the web which the list is contained.
.PARAMETER Identity
  Indicates the list GUID.
.PARAMETER Url
  Indicates the list URL.
.PARAMETER Name
  Indicates the list title or internal name.
.EXAMPLE
  Remove-SPClientList $list
.EXAMPLE
  Remove-SPClientList $web -Identity "CE5D9232-37A1-41D0-BCDB-B8C59958B831"
.EXAMPLE
  Remove-SPClientList $web -Url "/Lists/CustomList"
.EXAMPLE
  Remove-SPClientList $web -Name "Custom List"
.INPUTS
  None or Microsoft.SharePoint.Client.List or Microsoft.SharePoint.Client.Web
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientList.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.List]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Url')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [Microsoft.SharePoint.Client.Web]
        $ParentWeb,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('Title')]
        [string]
        $Name
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('Id')) {
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'Id'
            }
        } else {
            $ClientObjectCollection = $ParentWeb.Lists
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.List($ClientContext, $PathMethod)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'Id'
                trap {
                    throw 'The specified list could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Url') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ParentWeb.Path, `
                    'GetList', `
                    [object[]]$Url)
                $ClientObject = New-Object Microsoft.SharePoint.Client.List($ClientContext, $PathMethod)
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'Id'
                trap {
                    throw 'The specified list could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Name') {
                try {
                    $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                        $ClientContext, `
                        $ClientObjectCollection.Path, `
                        'GetByTitle', `
                        [object[]]$Name)
                    $ClientObject = New-Object Microsoft.SharePoint.Client.List($ClientContext, $PathMethod)
                    Invoke-SPClientLoadQuery `
                        -ClientContext $ClientContext `
                        -ClientObject $ClientObject `
                        -Retrievals 'Id'
                } catch {
                    Invoke-SPClientLoadQuery `
                        -ClientContext $ClientContext `
                        -ClientObject $ClientObjectCollection `
                        -Retrievals 'Include(RootFolder.Name)'
                    $ClientObject = $ClientObjectCollection | Where-Object { $_.RootFolder.Name -eq $Name }
                    if ($ClientObject -eq $null) {
                        throw 'The specified list could not be found.'
                    }
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
