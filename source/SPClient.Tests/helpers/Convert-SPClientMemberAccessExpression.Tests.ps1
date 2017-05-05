#Requires -Version 3.0

. "$($PSScriptRoot)\..\TestInitialize.ps1"

Describe 'Convert-SPClientMemberAccessExpression' {

    It 'Converts "Title"' {
        $Type = [Microsoft.SharePoint.Client.List]
        $Params = @{
            InputString = 'Title'
            Expression = [System.Linq.Expressions.Expression]::Parameter($Type, $Type.Name)
        }
        $Result = Convert-SPClientMemberAccessExpression @Params
        $Result | Should Not BeNullOrEmpty
    }

    It 'Converts "RootFolder.Name"' {
        $Type = [Microsoft.SharePoint.Client.List]
        $Params = @{
            InputString = 'RootFolder.Name'
            Expression = [System.Linq.Expressions.Expression]::Parameter($Type, $Type.Name)
        }
        $Result = Convert-SPClientMemberAccessExpression @Params
        $Result | Should Not BeNullOrEmpty
    }

    It 'Converts "Fields.Include(Title)"' {
        $Type = [Microsoft.SharePoint.Client.List]
        $Params = @{
            InputString = 'Fields.Include(Title)'
            Expression = [System.Linq.Expressions.Expression]::Parameter($Type, $Type.Name)
        }
        $Result = Convert-SPClientMemberAccessExpression @Params
        $Result | Should Not BeNullOrEmpty
    }

}
