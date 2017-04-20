#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Split-SPClientExpressionString' {

    It 'Splits "RootFolder.Name"' {
        $param = @{
            InputString = 'RootFolder.Name'
            Separator = '.'
        }
        $result = Split-SPClientExpressionString @param
        $result | Should Not Be $null
        $result[0] | Should Be 'RootFolder'
        $result[1] | Should Be 'Name'
    }

    It 'Splits "Web.Lists.Include(RootFolder.Name)"' {
        $param = @{
            InputString = 'Web.Lists.Include(RootFolder.Name)'
            Separator = '.'
        }
        $result = Split-SPClientExpressionString @param
        $result | Should Not Be $null
        $result[0] | Should Be 'Web'
        $result[1] | Should Be 'Lists'
        $result[2] | Should Be 'Include(RootFolder.Name)'
    }

    It 'Splits "Id,Title"' {
        $param = @{
            InputString = 'Id,Title'
            Separator = ','
        }
        $result = Split-SPClientExpressionString @param
        $result | Should Not Be $null
        $result[0] | Should Be 'Id'
        $result[1] | Should Be 'Title'
    }

    It 'Splits "Id,Lists.Include(Id,Title),ServerRelativeUrl"' {
        $param = @{
            InputString = 'Id,Lists.Include(Id,Title),ServerRelativeUrl'
            Separator = ','
        }
        $result = Split-SPClientExpressionString @param
        $result | Should Not Be $null
        $result[0] | Should Be 'Id'
        $result[1] | Should Be 'Lists.Include(Id,Title)'
        $result[2] | Should Be 'ServerRelativeUrl'
    }
    
}
