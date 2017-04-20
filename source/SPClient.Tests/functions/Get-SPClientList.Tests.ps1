#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Get-SPClientList' {
    
    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Returns all lists' {
        $web = Get-SPClientWeb -Default
        $result = $web | Get-SPClientList
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Returns a list by id' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Identity = $TestConfig.ListId
        }
        $result = $web | Get-SPClientList @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.List'
        $result.Id | Should Be $param.Identity
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Returns a list by url' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Url = $web.ServerRelativeUrl.TrimEnd('/') + '/' + $TestConfig.ListInternalName
            Retrievals = 'Title,RootFolder.ServerRelativeUrl'
        }
        $result = $web | Get-SPClientList @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.List'
        $result.RootFolder.ServerRelativeUrl | Should Be $param.Url   
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Returns a list by title' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Title = $TestConfig.ListTitle
        }
        $result = $web | Get-SPClientList @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.List'
        $result.Title | Should Be $param.Title
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Returns a list by internal name' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Title = $TestConfig.ListInternalName
            Retrievals = 'Title,RootFolder.ServerRelativeUrl'
        }
        $result = $web | Get-SPClientList @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.List'
        $result.RootFolder.ServerRelativeUrl | Should Match "$($param.Title)$"   
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Throws an error when the list could not be found by id' {
        $throw = {
            $web = Get-SPClientWeb -Default
            $param = @{
                Identity = [guid]::Empty
            }
            $result = $web | Get-SPClientList @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

    It 'Throws an error when the list could not be found by url' {
        $throw = {
            $web = Get-SPClientWeb -Default
            $param = @{
                Url = $web.ServerRelativeUrl.TrimEnd('/') + '/NotFound'
            }
            $result = $web | Get-SPClientList @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

    It 'Throws an error when the list could not be found by title' {
        $throw = {
            $web = Get-SPClientWeb -Default
            $param = @{
                Title = 'Not Found'
            }
            $result = $web | Get-SPClientList @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

}
