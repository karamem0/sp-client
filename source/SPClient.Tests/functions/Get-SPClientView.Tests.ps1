#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Get-SPClientView' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.SharePointOnlineUrl `
            -Online `
            -UserName $TestConfig.SharePointOnlineUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.SharePointOnlinePassword -AsPlainText -Force)
    }

    It 'Gets all views' {
        $list = Get-SPClientList -Title $TestConfig.SharePointListTitle
        $result = $list | Get-SPClientView
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ViewCollection'
        $result | ForEach-Object { Write-Host $_.Title }
    }

    It 'Gets a view by id' {
        $list = Get-SPClientList -Title $TestConfig.SharePointListTitle
        $param = @{
            Identity = $TestConfig.SharePointViewId
        }
        $result = $list | Get-SPClientView @param 
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.View'
        $result | ForEach-Object { Write-Host $_.Title }
    }

    It 'Gets a view by title' {
        $list = Get-SPClientList -Title $TestConfig.SharePointListTitle
        $param = @{
            Title = $TestConfig.SharePointViewTitle
        }
        $result = $list | Get-SPClientView @param 
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.View'
        $result | ForEach-Object { Write-Host $_.Title }
    }

    It 'Gets the default view' {
        $list = Get-SPClientList -Title $TestConfig.SharePointListTitle
        $param = @{
            Default = $true
        }
        $result = $list | Get-SPClientView @param 
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.View'
        $result | ForEach-Object { Write-Host $_.Title }
    }

    It 'Throws an error when the view could not be found by id' {
        $throw = {
            $list = Get-SPClientList -Title $TestConfig.SharePointListTitle
            $param = @{
                Identity = [Guid]::Empty
            }
            $result = $list | Get-SPClientView @param 
            $result | Should Not Be $null
            $result | ForEach-Object { Write-Host $_.Title }
        }
        $throw | Should Throw
    }

    It 'Throws an error when the view could not be found by title' {
        $throw = {
            $list = Get-SPClientList -Title $TestConfig.SharePointListTitle
            $param = @{
                Title = 'Not Found'
            }
            $result = $list | Get-SPClientView @param 
            $result | Should Not Be $null
            $result | ForEach-Object { Write-Host $_.Title }
        }
        $throw | Should Throw
    }

}
