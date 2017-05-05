#Requires -Version 3.0

. "$($PSScriptRoot)\..\TestInitialize.ps1"

Describe 'Convert-SPClientIncludeExpression' {

    It 'Converts "Include(Id, Title)"' {
        $Type = [Microsoft.SharePoint.Client.ListCollection]
        $Params = @{
            InputString = 'Include(Id, Title)'
            Expression = [System.Linq.Expressions.Expression]::Parameter($Type, $Type.Name)
        }
        $Result = Convert-SPClientIncludeExpression @Params
        $Result | Should Not BeNullOrEmpty
    }

    It 'Converts "Include(RootFolder.Name)"' {
        $Type = [Microsoft.SharePoint.Client.ListCollection]
        $Params = @{
            InputString = 'Include(RootFolder.Name)'
            Expression = [System.Linq.Expressions.Expression]::Parameter($Type, $Type.Name)
        }
        $Result = Convert-SPClientIncludeExpression @Params
        $Result | Should Not BeNullOrEmpty
    }

    It 'Converts "Include(RootFolder.Files.Include(Id, Title))"' {
        $Type = [Microsoft.SharePoint.Client.ListCollection]
        $Params = @{
            InputString = 'Include(RootFolder.Files.Include(Name, Title))'
            Expression = [System.Linq.Expressions.Expression]::Parameter($Type, $Type.Name)
        } 
        $Result = Convert-SPClientIncludeExpression @Params
        $Result | Should Not BeNullOrEmpty
    }

}
