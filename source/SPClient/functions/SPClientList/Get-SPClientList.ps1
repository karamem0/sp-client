#Requires -Version 3.0

<#
  Get-SPClientList.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientList {

<#
.SYNOPSIS
  Gets one or more lists.
.DESCRIPTION
  The Get-SPClientList function lists all lists or retrieve the specified list.
  If not specified filterable parameter, returns all lists of the site.
  Otherwise, returns a list which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the site which the lists are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the list GUID.
.PARAMETER Url
  Indicates the list URL.
.PARAMETER Name
  Indicates the list title or internal name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientList $web
.EXAMPLE
  Get-SPClientList $web -Identity "CE5D9232-37A1-41D0-BCDB-B8C59958B831"
.EXAMPLE
  Get-SPClientList $web -Url "/Lists/CustomList"
.EXAMPLE
  Get-SPClientList $web -Name "Custom List"
.EXAMPLE
  Get-SPClientList $web -Retrieval "Title"
.INPUTS
  None or SPClient.SPClientListParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.List[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientList.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientListParentParameter]
        $ParentObject,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
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
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObjectCollection = $ParentObject.ClientObject.Lists
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
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
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified list could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ParentObject.ClientObject.Path, `
                'GetList', `
                [object[]]$Url)
            $ClientObject = New-Object Microsoft.SharePoint.Client.List($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
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
                    -Retrieval $Retrieval
            } catch {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObjectCollection `
                    -Retrieval 'Include(RootFolder.Name)'
                $ClientObject = $ClientObjectCollection | Where-Object { $_.RootFolder.Name -eq $Name }
                if ($ClientObject -eq $null) {
                    throw 'The specified list could not be found.'
                }
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval $Retrieval
            }
            Write-Output $ClientObject
        }
    }

}
