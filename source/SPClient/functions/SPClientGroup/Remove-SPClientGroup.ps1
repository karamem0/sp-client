#Requires -Version 3.0

<#
  Remove-SPClientGroup.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientGroup {

<#
.SYNOPSIS
  Deletes the group.
.DESCRIPTION
  The Remove-SPClientGroup function removes the group from the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the group to delete.
.PARAMETER Identity
  Indicates the group ID.
.PARAMETER Name
  Indicates the group name.
.EXAMPLE
  Remove-SPClientGroup $group
.EXAMPLE
  Remove-SPClientGroup -Identity 7
.EXAMPLE
  Remove-SPClientGroup -Name "Custom Group"
.INPUTS
  None or Microsoft.SharePoint.Client.Group
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientGroup.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.Group]
        $ClientObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('Title')]
        [string]
        $Name
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObjectCollection = $ClientContext.Site.RootWeb.SiteGroups
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('Id')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
            }
        } else {
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Group($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
                trap {
                    throw 'The specified group could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Name') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetByName', `
                    [object[]]$Name)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Group($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
                trap {
                    throw 'The specified group could not be found.'
                }
            }
        }
        $ClientObjectCollection.Remove($ClientObject)
        $ClientContext.ExecuteQuery()
    }

}
