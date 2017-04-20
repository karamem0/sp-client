#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Convert-SPClientMemberAccessExpression' {
	Context 'Converts "Title"' {
        Add-SPClientType
        $type = [Microsoft.SharePoint.Client.List]
        $expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        $result = Convert-SPClientMemberAccessExpression -InputString 'Title' -Expression $expression
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Return value is valid' {
            $result.ToString() | Should Be 'List.Title'
        }
    }
	Context 'Converts "RootFolder.Name"' {
        Add-SPClientType
        $type = [Microsoft.SharePoint.Client.List]
        $expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        $result = Convert-SPClientMemberAccessExpression -InputString 'RootFolder.Name' -Expression $expression
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Return value is valid' {
            $result.ToString() | Should Be 'List.RootFolder.Name'
        }
    }
	Context 'Converts "Folder.Include(Title)"' {
        Add-SPClientType
        $type = [Microsoft.SharePoint.Client.List]
        $expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        $result = Convert-SPClientMemberAccessExpression -InputString 'Fields.Include(Title)' -Expression $expression
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Return value is valid' {
            $result.ToString() | Should Be 'List.Fields.Include(new [] {Field => Convert(Field.Title)})'
        }
    }
}
