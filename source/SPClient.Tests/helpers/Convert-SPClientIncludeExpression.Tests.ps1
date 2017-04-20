#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Convert-SPClientIncludeExpression' {
    Context 'Converts "Include(Id, Title)"' {
        Add-SPClientType
        $type = [Microsoft.SharePoint.Client.ListCollection]
        $expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        $result = Convert-SPClientIncludeExpression -InputString 'Include(Id, Title)' -Expression $expression
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Return value is valid' {
            $result.ToString() | Should Be 'ListCollection.Include(new [] {List => Convert(List.Id), List => Convert(List.Title)})'
        }
    }
	Context 'Converts "Include(RootFolder.Name)"' {
        Add-SPClientType
        $type = [Microsoft.SharePoint.Client.ListCollection]
        $expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        $result = Convert-SPClientIncludeExpression -InputString 'Include(RootFolder.Name)' -Expression $expression
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Return value is valid' {
            $result.ToString() | Should Be 'ListCollection.Include(new [] {List => Convert(List.RootFolder.Name)})'
        }
    }
    Context 'Converts "Include(RootFolder.Files.Include(Id, Title))"' {
        Add-SPClientType
        $type = [Microsoft.SharePoint.Client.ListCollection]
        $expression = [System.Linq.Expressions.Expression]::Parameter($type, $type.Name)
        $result = Convert-SPClientIncludeExpression -InputString 'Include(RootFolder.Files.Include(Name, Title))' -Expression $expression
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Return value is valid' {
            $result.ToString() | Should Be `
                'ListCollection.Include(new [] {List => Convert(List.RootFolder.Files.Include(new [] {File => Convert(File.Name), File => Convert(File.Title)}))})'
        }
    }
}
