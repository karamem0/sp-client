#Requires -Version 3.0

# Get-SPClientGroup.ps1
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

function Get-SPClientGroup {

<#
.SYNOPSIS
  Lists all site groups or retrieve the specified site group.
.DESCRIPTION
  If not specified 'Identitiy' and 'Name', returns site all groups. Otherwise,
  returns a group which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses the default context.
.PARAMETER ParentObject
  Indicates the web which the groups are contained.
.PARAMETER Identity
  Indicates the group id.
.PARAMETER Name
  Indicates the group name.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Name')]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.Web]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('Title')]
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
        $ClientObjectCollection = $ParentObject.SiteGroups
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrievals $Retrievals
            Write-Output @(, $ClientObjectCollection)
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $ClientObject = $ClientObjectCollection.GetById($Identity)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified group could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $ClientObject = $ClientObjectCollection.GetByName($Name)
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrievals $Retrievals
            Write-Output $ClientObject
            trap {
                throw 'The specified group could not be found.'
            }
        }
    }

}
