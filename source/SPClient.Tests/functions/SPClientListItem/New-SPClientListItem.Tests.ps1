#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'New-SPClientListItem' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Creates a new list item with mandatory parameters' {
        try {
            $web = Get-SPClientWeb -Default
            $list = $web | New-SPClientList -Title 'List1'
            $param = @{ }
            $result = $list | New-SPClientListItem @param
            $result | Should Not Be $null
            $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItem'
            $result.FieldValues.GetEnumerator() `
                | Sort-Object `
                | ForEach-Object { Write-Host "$(' ' * 3)$($_)" }
        } finally {
            $web = Get-SPClientWeb -Default
            $list = $web | Get-SPClientList -Title 'List1'
            $list | Remove-SPClientList
        }
    }

    It 'Creates a new list item with all parameters' {
        try {
            $web = Get-SPClientWeb -Default
            $list = $web | New-SPClientList -Title 'List1'
            $param = @{
                FieldValues = @{
                    Title = 'Title1'
                }
            }
            $result = $list | New-SPClientListItem @param
            $result | Should Not Be $null
            $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItem'
            $result['Title'] | Should Be 'Title1'
            $result.FieldValues.GetEnumerator() `
                | Sort-Object `
                | ForEach-Object { Write-Host "$(' ' * 3)$($_)" }
        } finally {
            $web = Get-SPClientWeb -Default
            $list = $web | Get-SPClientList -Title 'List1'
            $list | Remove-SPClientList
        }
    }

}
