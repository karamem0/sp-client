#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Convert-SPClientMemberAccessExpression' {

    BeforeEach {
        Add-SPClientType
    }

    It 'Converts "Title"' {
        $type = [Microsoft.SharePoint.Client.List]
        $param = @{
            InputString = 'Title'
            Expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        }
        $result = Convert-SPClientMemberAccessExpression @param
        $result | Should Not Be $null
        $result | Write-Host
    }

    It 'Converts "RootFolder.Name"' {
        $type = [Microsoft.SharePoint.Client.List]
        $param = @{
            InputString = 'RootFolder.Name'
            Expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        }
        $result = Convert-SPClientMemberAccessExpression @param
        $result | Should Not Be $null
        $result | Write-Host
    }

    It 'Converts "Fields.Include(Title)"' {
        $type = [Microsoft.SharePoint.Client.List]
        $param = @{
            InputString = 'Fields.Include(Title)'
            Expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        }
        $result = Convert-SPClientMemberAccessExpression @param
        $result | Should Not Be $null
        $result | Write-Host
    }

}
