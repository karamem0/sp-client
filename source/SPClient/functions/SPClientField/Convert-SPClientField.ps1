#Requires -Version 3.0

# Convert-SPClientField.ps1
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

function Convert-SPClientField {

<#
.SYNOPSIS
  Converts the field to its derived type.
.DESCRIPTION
  The Convert-SPClientField function converts the field to its derived type.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER Field
  Indicates the field.
.EXAMPLE
  Convert-SPClientField $field
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.Field]
        $Field
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Table = @{
            Text = 'Microsoft.SharePoint.Client.FieldText'
            Note = 'Microsoft.SharePoint.Client.FieldMultilineText'
            Choice = 'Microsoft.SharePoint.Client.FieldChoice'
            MultiChoice = 'Microsoft.SharePoint.Client.FieldMultiChoice'
            Number = 'Microsoft.SharePoint.Client.FieldNumber'
            Currency = 'Microsoft.SharePoint.Client.FieldCurrency'
            DateTime = 'Microsoft.SharePoint.Client.FieldDateTime'
            Lookup = 'Microsoft.SharePoint.Client.FieldLookup'
            LookupMulti = 'Microsoft.SharePoint.Client.FieldLookup'
            Boolean = 'Microsoft.SharePoint.Client.FieldNumber'
            User = 'Microsoft.SharePoint.Client.FieldUser'
            UserMulti = 'Microsoft.SharePoint.Client.FieldUser'
            Url = 'Microsoft.SharePoint.Client.FieldUrl'
            Calculated = 'Microsoft.SharePoint.Client.FieldCalculated'
        }
        if (-not $Field.IsPropertyAvailable('TypeAsString')) {
            Invoke-SPClientLoadQuery `
                -ClientContext $ClientContext `
                -ClientObject $Field `
                -Retrievals 'TypeAsString'
        }
        $Method = $ClientContext.GetType().GetMethod('CastTo')
        $Method = $Method.MakeGenericMethod([type[]]$Table[$Field.TypeAsString])
        Write-Output $Method.Invoke($ClientContext, @($Field))
    }

}
