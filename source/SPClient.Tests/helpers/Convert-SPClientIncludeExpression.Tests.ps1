#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Convert-SPClientIncludeExpression' {

    BeforeEach {
        Add-SPClientType
    }

    It 'Converts "Include(Id, Title)"' {
        $type = [Microsoft.SharePoint.Client.ListCollection]
        $param = @{
            InputString = 'Include(Id, Title)'
            Expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        }
        $result = Convert-SPClientIncludeExpression @param
        $result | Should Not Be $null
        $result | Write-Host
    }

    It 'Converts "Include(RootFolder.Name)"' {
        $type = [Microsoft.SharePoint.Client.ListCollection]
        $param = @{
            InputString = 'Include(RootFolder.Name)'
            Expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        }
        $result = Convert-SPClientIncludeExpression @param
        $result | Should Not Be $null
        $result | Write-Host
    }

    It 'Converts "Include(RootFolder.Files.Include(Id, Title))"' {
        $type = [Microsoft.SharePoint.Client.ListCollection]
        $param = @{
            InputString = 'Include(RootFolder.Files.Include(Name, Title))'
            Expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        } 
        $result = Convert-SPClientIncludeExpression @param
        $result | Should Not Be $null
        $result | Write-Host
    }

}
