#Requires -Version 3.0

<#
  Invoke-ClientContextLoad.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Invoke-ClientContextLoad {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext,
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.ClientObject]
        $ClientObject,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        $ItemType = $ClientObject.GetType()
        $FuncType = [type]'System.Func`2' | &{ process { $_.MakeGenericType($ItemType, [object]) } }
        $ExprType = [type]'System.Linq.Expressions.Expression`1' | &{ process { $_.MakeGenericType($FuncType) } }
        $ListType = [type]'System.Collections.Generic.List`1' | &{ process { $_.MakeGenericType($ExprType) } }
        $LambdaExprs = New-Object $ListType
        if (-not [string]::IsNullOrEmpty($Retrieval)) {
            if (Test-GenericSubclassOf -InputType $ItemType -TestType 'Microsoft.SharePoint.Client.ClientObjectCollection`1') {
                if (-not ($Retrieval.StartsWith('Include(') -and $Retrieval.EndsWith(')'))) {
                    $Retrieval = 'Include(' + $Retrieval + ')'
                }
                $ParamExpr = [System.Linq.Expressions.Expression]::Parameter($ItemType, $ItemType.Name)
                $PropExpr = Convert-RetrievalIncludeExpression -InputString $Retrieval -Expression $ParamExpr
                $LambdaExpr = [System.Linq.Expressions.Expression]::Lambda($FuncType, $PropExpr, $ParamExpr)
                $LambdaExprs.Add($LambdaExpr)
            } else {
                if ($Retrieval.StartsWith('Include(') -and $Retrieval.EndsWith(')')) {
                    $Retrieval = $Retrieval.Substring(8, $Retrieval.Length - 9)
                }
                $ParamExpr = [System.Linq.Expressions.Expression]::Parameter($ItemType, $ItemType.Name)
                $Splits = Split-RetrievalExpressionString -InputString $Retrieval -Separator ','
                foreach ($Split in $Splits) {
                    $PropExpr = Convert-RetrievalMemberAccessExpression -InputString $Split -Expression $ParamExpr
                    $CastExpr = [System.Linq.Expressions.Expression]::Convert($PropExpr, [object])
                    $LambdaExpr = [System.Linq.Expressions.Expression]::Lambda($FuncType, $CastExpr, $ParamExpr)
                    $LambdaExprs.Add($LambdaExpr)
                }
            }
        }
        $LoadMethod = $ClientContext.GetType().GetMethod('Load').MakeGenericMethod($ItemType)
        $LoadMethod.Invoke($ClientContext, @($ClientObject, $LambdaExprs.ToArray())) | Out-Null
        $ClientContext.ExecuteQuery()
    }

}
