#Requires -Version 3.0

<#
  Remove-SPClientUser.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientUser {

<#
.SYNOPSIS
  Deletes the user.
.DESCRIPTION
  The Remove-SPClientUser function removes the user from the site.
  If the user could not be found, throws exception.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the user to delete.
.PARAMETER Identity
  Indicates the user ID.
.PARAMETER Name
  Indicates the user login name.
.PARAMETER Email
  Indicates the user E-mail.
.EXAMPLE
  Remove-SPClientUser $user
.EXAMPLE
  Remove-SPClientUser -Identity 7
.EXAMPLE
  Remove-SPClientUser -Name "i:0#.f|membership|admin@example.com"
.EXAMPLE
  Remove-SPClientUser -Email "admin@example.com"
.INPUTS
  None or Microsoft.SharePoint.Client.User
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientUser.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.User]
        $ClientObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [int]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [Alias('LoginName')]
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
                $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
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
                $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
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
                $ClientObject = New-Object Microsoft.SharePoint.Client.User($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
                trap {
                    throw 'The specified user could not be found.'
                }
            }
        }
        $ClientObjectCollection.Remove($ClientObject)
        $ClientContext.ExecuteQuery()
    }

}
