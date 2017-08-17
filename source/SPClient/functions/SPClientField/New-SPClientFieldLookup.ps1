#Requires -Version 3.0

<#
  New-SPClientFieldLookup.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientFieldLookup {

<#
.SYNOPSIS
  Creates a new column lookup column.
.DESCRIPTION
  The New-SPClientFieldLookup function adds a new column to the site or list.
  The column allows the user to enter one or more column lookup values.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the site or list which a column to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title.
.PARAMETER Identity
  Indicates the column GUID.
.PARAMETER Description
  Indicates the description.
.PARAMETER Required
  Indicates a value whether the column is required.
.PARAMETER EnforceUniqueValues
  Indicates a value whether the column must to have unique value.
.PARAMETER AllowMultipleValues
  Indicates a value whether the column allows multiple values.
.PARAMETER LookupField
  Indicates the internal column name of the user lookup value.
.PARAMETER AddToDefaultView
  If true, the column is add to default view.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFieldLookup $list -Name "CustomField" -Title "Custom Field" -LookupList "CE5D9232-37A1-41D0-BCDB-B8C59958B831" -LookupField "Title"
.INPUTS
  None or SPClient.SPClientFieldParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.FieldLookup
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldLookup.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFieldParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Title = $Name,
        [Parameter(Mandatory = $false)]
        [guid]
        $Identity,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [bool]
        $Required,
        [Parameter(Mandatory = $false)]
        [bool]
        $EnforceUniqueValues,
        [Parameter(Mandatory = $false)]
        [bool]
        $AllowMultipleValues,
        [Parameter(Mandatory = $true)]
        [guid]
        $LookupList,
        [Parameter(Mandatory = $true)]
        [string]
        $LookupField,
        [Parameter(Mandatory = $false)]
        [ValidateSet('None', 'Cascade', 'Restrict')]
        [string]
        $RelationshipDeleteBehavior,
        [Parameter(Mandatory = $false)]
        [bool]
        $AddToDefaultView,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $XmlDocument = New-Object System.Xml.XmlDocument
        $FieldElement = $XmlDocument.AppendChild($XmlDocument.CreateElement('Field'))
        $FieldElement.SetAttribute('Type', 'Lookup')
        $FieldElement.SetAttribute('Name', $Name)
        $FieldElement.SetAttribute('DisplayName', $Title)
        if ($PSBoundParameters.ContainsKey('Identity')) {
            $FieldElement.SetAttribute('ID', $Identity)
        }
        if ($PSBoundParameters.ContainsKey('Description')) {
            $FieldElement.SetAttribute('Description', $Description)
        }
        if ($PSBoundParameters.ContainsKey('Required')) {
            $FieldElement.SetAttribute('Required', $Required.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('EnforceUniqueValues')) {
            $FieldElement.SetAttribute('EnforceUniqueValues', $EnforceUniqueValues.ToString().ToUpper())
            $FieldElement.SetAttribute('Indexed', $EnforceUniqueValues.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('AllowMultipleValues')) {
            if ($AllowMultipleValues -eq $true) {
                if ($EnforceUniqueValues -eq $true) {
                    throw "Cannot be EnforceUniqueValues to true when AllowMultipleValues is true."
                }
                $FieldElement.SetAttribute('Type', 'LookupMulti')
                $FieldElement.SetAttribute('Mult', $AllowMultipleValues.ToString().ToUpper())
            }
        }
        if ($PSBoundParameters.ContainsKey('LookupList')) {
            $FieldElement.SetAttribute('List', $LookupList.ToString('B'))
        }
        if ($PSBoundParameters.ContainsKey('LookupField')) {
            $FieldElement.SetAttribute('ShowField', $LookupField)
        }
        if ($PSBoundParameters.ContainsKey('RelationshipDeleteBehavior')) {
            $FieldElement.SetAttribute('RelationshipDeleteBehavior', $RelationshipDeleteBehavior)
        }
        $AddFieldOptions = [Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldInternalNameHint
        $ClientObject = $ParentObject.ClientObject.Fields.AddFieldAsXml($XmlDocument.InnerXml, $AddToDefaultView, $AddFieldOptions)
        $ClientObject = Convert-SPClientField `
            -ClientContext $ClientContext `
            -Field $ClientObject
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}
