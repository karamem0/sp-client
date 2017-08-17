#Requires -Version 3.0

<#
  Remove-SPClientField.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientField {

<#
.SYNOPSIS
  Deletes the column.
.DESCRIPTION
  The Remove-SPClientField function removes the column from the site or list. 
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the column to delete.
.PARAMETER ParentObject
  Indicates the site or list which the column is contained.
.PARAMETER Identity
  Indicates the column GUID.
.PARAMETER Name
  Indicates the column title or internal name.
.EXAMPLE
  Remove-SPClientField $field
.EXAMPLE
  Remove-SPClientField $list -Identity "39ED73EB-FDD8-4870-91A5-EEE0ACB966B2"
.EXAMPLE
  Remove-SPClientField $list -Name "Custom Field"
.INPUTS
  None or Microsoft.SharePoint.Client.Field or SPClient.SPClientFieldParentPipeBind
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientField.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.Field]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [SPClient.SPClientFieldParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
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
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('Id')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id,SchemaXml'
            }
        } else {
            $ClientObjectCollection = $ParentObject.ClientObject.Fields
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
                    -Retrieval 'Id,SchemaXml'
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
                    -Retrieval 'Id,SchemaXml'
                trap {
                    throw 'The specified column could not be found.'
                }
            }
        }
        $Xml = [xml]$ClientObject.SchemaXml
        $Xml.DocumentElement.SetAttribute('Hidden', 'FALSE')
        $Xml.DocumentElement.SetAttribute('ReadOnly', 'FALSE')
        $ClientObject.SchemaXml = $Xml.InnerXml
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}
