#Requires -Version 3.0

<#
  Remove-SPClientList.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientList {

<#
.SYNOPSIS
  Deletes the list.
.DESCRIPTION
  The Remove-SPClientList function removes the list from the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the list to delete.
.PARAMETER ParentObject
  Indicates the site which the list is contained.
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
  None or Microsoft.SharePoint.Client.List or SPClient.SPClientListParentPipeBind
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
        [SPClient.SPClientListParentPipeBind]
        $ParentObject,
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
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
            }
        } else {
            $ClientObjectCollection = $ParentObject.ClientObject.Lists
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientObjectCollection.Path, `
                    'GetById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.List($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
                trap {
                    throw 'The specified list could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Url') {
                $Url = ConvertTo-SPClientRelativeUrl -ClientContext $ClientContext -Url $Url
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ParentObject.ClientObject.Path, `
                    'GetList', `
                    [object[]]$Url)
                $ClientObject = New-Object Microsoft.SharePoint.Client.List($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
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
                    Invoke-ClientContextLoad `
                        -ClientContext $ClientContext `
                        -ClientObject $ClientObject `
                        -Retrieval 'Id'
                } catch {
                    Invoke-ClientContextLoad `
                        -ClientContext $ClientContext `
                        -ClientObject $ClientObjectCollection `
                        -Retrieval 'Include(RootFolder.Name)'
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
