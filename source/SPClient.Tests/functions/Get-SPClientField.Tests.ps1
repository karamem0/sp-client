#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Get-SPClientField' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Returns all fields' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $result = $list | Get-SPClientField
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.FieldCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Returns a field by id' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Identity = $TestConfig.FieldId
        }
        $result = $list | Get-SPClientField @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Field'
        $result.Id | Should Be $param.Identity
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Returns a field by title' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Title = $TestConfig.FieldTitle
        }
        $result = $list | Get-SPClientField @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Field'
        $result.Title | Should Be $param.Title
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Returns a field by internal name' {
        $list = Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Title = $TestConfig.FieldInternalName
        }
        $result = $list | Get-SPClientField @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Field'
        $result.InternalName | Should Be $param.Title
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Throws an error when the field could not be found by id' {
        $throw = {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $param = @{
                Identity = [guid]::Empty
            }
            $result = $list | Get-SPClientField @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

    It 'Throws an error when the field could not be found by title' {
        $throw = {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $param = @{
                Title = 'Not Found'
            }
            $result = $list | Get-SPClientField @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

}
