#Requires -Version 3.0

. "$($PSScriptRoot)\..\TestInitialize.ps1"

Describe 'Split-SPClientExpressionString' {

    It 'Splits "RootFolder.Name"' {
        $Params = @{
            InputString = 'RootFolder.Name'
            Separator = '.'
        }
        $Result = Split-SPClientExpressionString @Params
        $Result | Should Not BeNullOrEmpty
        $Result[0] | Should Be 'RootFolder'
        $Result[1] | Should Be 'Name'
    }

    It 'Splits "Web.Lists.Include(RootFolder.Name)"' {
        $Params = @{
            InputString = 'Web.Lists.Include(RootFolder.Name)'
            Separator = '.'
        }
        $Result = Split-SPClientExpressionString @Params
        $Result | Should Not BeNullOrEmpty
        $Result[0] | Should Be 'Web'
        $Result[1] | Should Be 'Lists'
        $Result[2] | Should Be 'Include(RootFolder.Name)'
    }

    It 'Splits "Id,Title"' {
        $Params = @{
            InputString = 'Id,Title'
            Separator = ','
        }
        $Result = Split-SPClientExpressionString @Params
        $Result | Should Not BeNullOrEmpty
        $Result[0] | Should Be 'Id'
        $Result[1] | Should Be 'Title'
    }

    It 'Splits "Id,Lists.Include(Id,Title),ServerRelativeUrl"' {
        $Params = @{
            InputString = 'Id,Lists.Include(Id,Title),ServerRelativeUrl'
            Separator = ','
        }
        $Result = Split-SPClientExpressionString @Params
        $Result | Should Not BeNullOrEmpty
        $Result[0] | Should Be 'Id'
        $Result[1] | Should Be 'Lists.Include(Id,Title)'
        $Result[2] | Should Be 'ServerRelativeUrl'
    }
    
}
