#Requires -Version 3.0

$PSScriptRoot.Replace('.Tests', '') `
    | Get-ChildItem -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$Script:SPClient = @{}
$Script:TestConfig = [Xml](Get-Content "${PSScriptRoot}\TestConfiguration.xml") | ForEach-Object { $_.TestConfiguration }
