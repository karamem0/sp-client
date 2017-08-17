#Requires -Version 3.0

<#
  Get-SPClientField.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientField {

<#
.SYNOPSIS
  Gets one or more columns.
.DESCRIPTION
  The Get-SPClientField function lists all columns or retrieves the specified column.
  If not specified filterable parameter, returns all columns of the site, content type or list.
  Otherwise, returns a column which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the site, content type or list which the columns are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the column GUID.
.PARAMETER Name
  Indicates the column title or internal name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientField $list
.EXAMPLE
  Get-SPClientField $list -Identity "39ED73EB-FDD8-4870-91A5-EEE0ACB966B2"
.EXAMPLE
  Get-SPClientField $list -Name "Custom Field"
.EXAMPLE
  Get-SPClientField $list -Retrieval "Title"
.INPUTS
  None or SPClient.SPClientFieldParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.Field[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientField.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFieldParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
        $Identity,
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
        $ClientObjectCollection = $ParentObject.ClientObject.Fields
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
            $ClientObject = New-Object Microsoft.SharePoint.Client.Field($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified column could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetByInternalNameOrTitle', `
                [object[]]$Name)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Field($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified column could not be found.'
            }
        }
    }

}
