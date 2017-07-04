#Requires -Version 3.0

<#
  Convert-RetrievalIncludeExpression.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Convert-RetrievalIncludeExpression {

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
        if (-not $InputString.StartsWith('Include(')) {
            throw "Cannot convert expression because 'InputString' parameter does not start with 'Include('."
        }
        if (-not $InputString.EndsWith(')')) {
            throw "Cannot convert expression because 'InputString' parameter does not end with ')'."
        }
        $InputString = $InputString.Substring(8, $InputString.Length - 9)
        $ItemType = $Expression.Type.BaseType.GenericTypeArguments[0]
        $FuncType = [type]'System.Func`2' | &{ process { $_.MakeGenericType($ItemType, [object]) } }
        $ExprType = [type]'System.Linq.Expressions.Expression`1' | &{ process { $_.MakeGenericType($FuncType) } }
        $ListType = [type]'System.Collections.Generic.List`1' | &{ process { $_.MakeGenericType($ExprType) } }
        $ParamExpr = [System.Linq.Expressions.Expression]::Parameter($ItemType, $ItemType.Name)
        $LambdaExprs = New-Object $ListType
        $Splits = Split-RetrievalExpressionString -InputString $InputString -Separator ','
        if ($Splits -ne '*') {
            foreach ($Split in $Splits) {
                $PropExpr = Convert-RetrievalMemberAccessExpression -InputString $Split -Expression $ParamExpr
                $CastExpr = [System.Linq.Expressions.Expression]::Convert($PropExpr, [object])
                $LambdaExpr = [System.Linq.Expressions.Expression]::Lambda($FuncType, $CastExpr, $ParamExpr)
                $LambdaExprs.Add($LambdaExpr)
            }
        }
        $ExtType = [Microsoft.SharePoint.Client.ClientObjectQueryableExtension]
        $ArrayExpr = [System.Linq.Expressions.Expression]::NewArrayInit($ExprType, $LambdaExprs.ToArray())
        if ($Splits -contains '*') {
            $IncludeExpr = [System.Linq.Expressions.Expression]::Call( `
                $ExtType.GetMethod('IncludeWithDefaultProperties').MakeGenericMethod($ItemType), `
                [System.Linq.Expressions.Expression[]]@($Expression, $ArrayExpr)
            )
            Write-Output $IncludeExpr
        } else {
            $IncludeExpr = [System.Linq.Expressions.Expression]::Call( `
                $ExtType.GetMethod('Include').MakeGenericMethod($ItemType), `
                [System.Linq.Expressions.Expression[]]@($Expression, $ArrayExpr)
            )
            Write-Output $IncludeExpr
        }
    }

}
