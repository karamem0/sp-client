#Requires -Version 3.0

# New-SPClientFieldNumber.ps1
#
# Copyright (c) 2017 karamem0
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function New-SPClientFieldNumber {

<#
.SYNOPSIS
  Creates a new field which user can enter a floating point number.
.PARAMETER ClientContext
  Indicates the client context.
  If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the list which a field to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title.
.PARAMETER Identity
  Indicates the field GUID.
.PARAMETER Description
  Indicates the description.
.PARAMETER Required
  Indicates a value whether the field is required.
.PARAMETER EnforceUniqueValues
  Indicates a value whether the field must to have unique value.
.PARAMETER MinimumValue
  Indicates the minimum value.
.PARAMETER MaximumValue
  Indicates the maximum value.
.PARAMETER Decimals
  Indicates the number of decimals.
.PARAMETER Percentage
  Indicates a value whether the field shows as percentage.
.PARAMETER DefaultValue
  Indicates the default value.
.PARAMETER AddToDefaultView
  If true, the field is add to default view.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.List]
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
        $Retrievals
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
        if ($MyInvocation.BoundParameters.ContainsKey('Identity')) {
            $FieldElement.SetAttribute('ID', $Identity)
        }
        if ($MyInvocation.BoundParameters.ContainsKey('Description')) {
            $FieldElement.SetAttribute('Description', $Description)
        }
        if ($MyInvocation.BoundParameters.ContainsKey('Required')) {
            $FieldElement.SetAttribute('Required', $Required.ToString().ToUpper())
        }
        if ($MyInvocation.BoundParameters.ContainsKey('EnforceUniqueValues')) {
            $FieldElement.SetAttribute('EnforceUniqueValues', $EnforceUniqueValues.ToString().ToUpper())
            $FieldElement.SetAttribute('Indexed', $EnforceUniqueValues.ToString().ToUpper())
        }
        if ($MyInvocation.BoundParameters.ContainsKey('MinimumValue')) {
            $FieldElement.SetAttribute('Min', $MinimumValue)
        }
        if ($MyInvocation.BoundParameters.ContainsKey('MaximumValue')) {
            $FieldElement.SetAttribute('Max', $MaximumValue)
        }
        if ($MyInvocation.BoundParameters.ContainsKey('Decimals')) {
            $FieldElement.SetAttribute('Decimals', $Decimals)
        }
        if ($MyInvocation.BoundParameters.ContainsKey('Percentage')) {
            $FieldElement.SetAttribute('Percentage', $Percentage.ToString().ToUpper())
        }
        if ($MyInvocation.BoundParameters.ContainsKey('DefaultValue')) {
            $DefaultElement = $XmlDocument.CreateElement('Default')
            $DefaultElement.InnerText = $DefaultValue
            $FieldElement.AppendChild($DefaultElement) | Out-Null
        }
        $AddFieldOptions = [Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldInternalNameHint
        $ClientObject = $ParentObject.Fields.AddFieldAsXml($XmlDocument.InnerXml, $AddToDefaultView, $AddFieldOptions)
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        $ClientObject = Convert-SPClientField `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject
        Write-Output $ClientObject
    }

}
