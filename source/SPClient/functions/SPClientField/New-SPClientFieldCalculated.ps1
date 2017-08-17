#Requires -Version 3.0

<#
  New-SPClientFieldCalculated.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientFieldCalculated {

<#
.SYNOPSIS
  Creates a new calclated column.
.DESCRIPTION
  The New-SPClientFieldCalculated function adds a new column to the site or list.
  The value of the column is calculated based on other columns.
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
.PARAMETER Fomula
  Indicates the formula.
.PARAMETER FieldRefs
  Indicates the collection of columns which used in formula.
.PARAMETER OutputType
  Indicates the data type of the return value.
    - Text
    - Number
    - Currency
    - DateTime
    - Boolean
.PARAMETER Decimals
  Indicates the number of decimals. This parameter is used when OutputType is
  'Number' or 'Currency'.
.PARAMETER Percentage
  Indicates a value whether the column shows as percentage. This parameter is
  used when OutputType is 'Number'.
.PARAMETER LocaleId 
  Indicates the language code identifier (LCID). This parameter is used when
  OutputType is 'Currency'.
.PARAMETER DateFormat
  Indicates the datetime display format. This parameter is used when OutputType
  is 'DateTime'.
.PARAMETER AddToDefaultView
  If true, the column is add to default view.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFieldCalculated $list -Name "CustomField" -Title "Custom Field" -Formula "=[Title]" -FieldRefs "Title" -OutputType "Text"
.INPUTS
  None or SPClient.SPClientFieldParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.FieldCalculated
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldCalculated.md
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
        [Parameter(Mandatory = $true)]
        [string]
        $Formula,
        [Parameter(Mandatory = $true)]
        [string[]]
        $FieldRefs,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Text', 'Number', 'Currency', 'DateTime', 'Boolean')]
        [string]
        $OutputType,
        [Parameter(Mandatory = $false)]
        [int]
        $Decimals,
        [Parameter(Mandatory = $false)]
        [bool]
        $Percentage,
        [Parameter(Mandatory = $false)]
        [int]
        $LocaleId,
        [Parameter(Mandatory = $false)]
        [ValidateSet('DateOnly', 'DateTime')]
        [string]
        $DateFormat,
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
        $FieldElement.SetAttribute('Type', 'Calculated')
        $FieldElement.SetAttribute('ReadOnly', 'TRUE')
        $FieldElement.SetAttribute('Name', $Name)
        $FieldElement.SetAttribute('DisplayName', $Title)
        if ($PSBoundParameters.ContainsKey('Identity')) {
            $FieldElement.SetAttribute('ID', $Identity)
        }
        if ($PSBoundParameters.ContainsKey('Description')) {
            $FieldElement.SetAttribute('Description', $Description)
        }
        if ($PSBoundParameters.ContainsKey('Formula')) {
            $FormulaElement = $FieldElement.AppendChild($XmlDocument.CreateElement('Formula'))
            $FormulaElement.InnerText = $Formula
        }
        if ($PSBoundParameters.ContainsKey('FieldRefs')) {
            $FieldRefsElement = $FieldElement.AppendChild($XmlDocument.CreateElement('FieldRefs'))
            foreach ($FieldRef in $FieldRefs) {
                $FieldRefElement = $FieldRefsElement.AppendChild($XmlDocument.CreateElement('FieldRef'))
                $FieldRefElement.SetAttribute('Name', $FieldRef)
            }
        }
        if ($PSBoundParameters.ContainsKey('OutputType')) {
            $FieldElement.SetAttribute('ResultType', $OutputType)
        }
        if ($PSBoundParameters.ContainsKey('Decimals')) {
            $FieldElement.SetAttribute('Decimals', $Decimals)
        }
        if ($PSBoundParameters.ContainsKey('Percentage')) {
            $FieldElement.SetAttribute('Percentage', $Percentage.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('LocaleId')) {
            $FieldElement.SetAttribute('LCID', $LocaleId)
        }
        if ($PSBoundParameters.ContainsKey('DateFormat')) {
            $FieldElement.SetAttribute('Format', $DateFormat)
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
