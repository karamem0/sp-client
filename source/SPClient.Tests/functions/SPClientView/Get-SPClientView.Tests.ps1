#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Get-SPClientView' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Gets all views' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $result = $list | Get-SPClientView
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ViewCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Gets a view by id' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Identity = $TestConfig.ViewId
        }
        $result = $list | Get-SPClientView @param 
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.View'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Gets a view by title' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Title = $TestConfig.ViewTitle
        }
        $result = $list | Get-SPClientView @param 
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.View'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Gets the default view' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Default = $true
        }
        $result = $list | Get-SPClientView @param 
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.View'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Throws an error when the view could not be found by id' {
        $throw = {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $param = @{
                Identity = [guid]::Empty
            }
            $result = $list | Get-SPClientView @param 
            $result | Should Not Be $null
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

    It 'Throws an error when the view could not be found by title' {
        $throw = {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $param = @{
                Title = 'Not Found'
            }
            $result = $list | Get-SPClientView @param 
            $result | Should Not Be $null
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

}
