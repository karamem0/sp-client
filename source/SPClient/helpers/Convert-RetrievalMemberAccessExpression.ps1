#Requires -Version 3.0

<#
  Convert-RetrievalMemberAccessExpression.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Convert-RetrievalMemberAccessExpression {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $InputString,
        [Parameter(Mandatory = $true)]
        [System.Linq.Expressions.Expression]
        $Expression
    )

    process {
        $Expr = $Expression
        $Type = $Expression.Type
        if ($InputString -ne '*') {
            $Splits = Split-RetrievalExpressionString -InputString $InputString -Separator '.'
            foreach ($Split in $Splits) {
                if (Test-GenericSubclassOf -InputType $Type -TestType 'Microsoft.SharePoint.Client.ClientObjectCollection`1') {
                    $Expr = Convert-RetrievalIncludeExpression -InputString $Split -Expression $Expr
                } else {
                    $Prop = $Type.GetProperty($Split)
                    if ($Prop -eq $null) {
                        throw "Cannot convert expression because '$($Type)' has no member named '$($Split)'."
                    }
                    $Expr = [System.Linq.Expressions.Expression]::Property($Expr, $Prop)
                    $Type = $Prop.PropertyType
                }
            }
        }
        Write-Output $Expr
    }

}
