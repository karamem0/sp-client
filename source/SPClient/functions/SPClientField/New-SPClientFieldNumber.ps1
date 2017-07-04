#Requires -Version 3.0

<#
  New-SPClientFieldNumber.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientFieldNumber {

<#
.SYNOPSIS
  Creates a new number column.
.DESCRIPTION
  The New-SPClientFieldNumber function adds a new column to the site or list.
  The column allows the user to enter a floating point number.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
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
.PARAMETER MinimumValue
  Indicates the minimum value.
.PARAMETER MaximumValue
  Indicates the maximum value.
.PARAMETER Decimals
  Indicates the number of decimals.
.PARAMETER Percentage
  Indicates a value whether the column shows as percentage.
.PARAMETER DefaultValue
  Indicates the default value.
.PARAMETER AddToDefaultView
  If true, the column is add to default view.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFieldNumber $list -Name "CustomField" -Title "Custom Field"
.INPUTS
  None or SPClient.SPClientFieldParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.FieldNumber
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldNumber.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFieldParentParameter]
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
        [double]
        $MinimumValue,
        [Parameter(Mandatory = $false)]
        [double]
        $MaximumValue,
        [Parameter(Mandatory = $false)]
        [int]
        $Decimals,
        [Parameter(Mandatory = $false)]
        [bool]
        $Percentage,
        [Parameter(Mandatory = $false)]
        [double]
        $DefaultValue,
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
        $FieldElement.SetAttribute('Type', 'Number')
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
        if ($PSBoundParameters.ContainsKey('MinimumValue')) {
            $FieldElement.SetAttribute('Min', $MinimumValue)
        }
        if ($PSBoundParameters.ContainsKey('MaximumValue')) {
            $FieldElement.SetAttribute('Max', $MaximumValue)
        }
        if ($PSBoundParameters.ContainsKey('Decimals')) {
            $FieldElement.SetAttribute('Decimals', $Decimals)
        }
        if ($PSBoundParameters.ContainsKey('Percentage')) {
            $FieldElement.SetAttribute('Percentage', $Percentage.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('DefaultValue')) {
            $DefaultElement = $FieldElement.AppendChild($XmlDocument.CreateElement('Default'))
            $DefaultElement.InnerText = $DefaultValue
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
