#Requires -Version 3.0

# Remove-SPClientUser.ps1
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

function Remove-SPClientUser {

<#
.SYNOPSIS
  Deletes a user.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the user to delete.
.PARAMETER Identity
  Indicates the user id.
.PARAMETER Name
  Indicates the user login name.
.PARAMETER Email
  Indicates the user email.
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.User]
        $ClientObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('Title')]
        [string]
        $Name,
        [Parameter(Mandatory = $true, ParameterSetName = 'Email')]
        [string]
        $Email
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObjectCollection = $ClientContext.Site.RootWeb.SiteUsers
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('Id')) {
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'Id'
            }
        } else {
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod);
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'Id'
                trap {
                    throw 'The specified user could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Name') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetByLoginName', `
                    [object[]]$Name)
                $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod);
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'Id'
                trap {
                    throw 'The specified user could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Email') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetByEmail', `
                    [object[]]$Email)
                $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod);
                Invoke-SPClientLoadQuery `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrievals 'Id'
                trap {
                    throw 'The specified user could not be found.'
                }
            }
        }
        $ClientObjectCollection.Remove($ClientObject)
        $ClientContext.ExecuteQuery()
    }

}
