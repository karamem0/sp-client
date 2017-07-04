#Requires -Version 3.0

<#
  New-SPClientFieldText.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientFieldText {

<#
.SYNOPSIS
  Creates a new column which user can enter a single line of text.
.DESCRIPTION
  The New-SPClientFieldText function adds a new column to the site or list.
  The column allows the user to enter multiple lines of text.
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
.PARAMETER MaxLength
  Indicates the maximum number of characters.
.PARAMETER DefaultValue
  Indicates the default value.
.PARAMETER AddToDefaultView
  If true, the column is add to default view.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFieldText $list -Name "CustomField" -Title "Custom Field"
.INPUTS
  None or SPClient.SPClientFieldParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.FieldText
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldText.md
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
        [int]
        $MaxLength,
        [Parameter(Mandatory = $false)]
        [string]
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
        $FieldElement.SetAttribute('Type', 'Text')
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
        if ($PSBoundParameters.ContainsKey('MaxLength')) {
            $FieldElement.SetAttribute('MaxLength', $MaxLength)
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
