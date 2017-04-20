#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Invoke-SPClientLoadQuery' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -AsPlainText $TestConfig.LoginPassword -Force)
    }

    It 'Loads ClientObject without retrievals' {
        $param = @{
            ClientContext = $SPClient.ClientContext
            ClientObject = $SPClient.ClientContext.Web
        }
        $result = Invoke-SPClientLoadQuery @param
        $result | Should Be $null
    }

    It 'Loads ClientObject with retrievals' {
        $param = @{
            ClientContext = $SPClient.ClientContext
            ClientObject = $SPClient.ClientContext.Web
            Retrievals = 'Id, RootFolder.ServerRelativeUrl'
        }
        $result = Invoke-SPClientLoadQuery @param
        $result | Should Be $null
    }

    It 'Loads ClientObjectCollection without retrievals' {
        $param = @{
            ClientContext = $SPClient.ClientContext
            ClientObject = $SPClient.ClientContext.Web.Lists
        }
        $result = Invoke-SPClientLoadQuery @param
        $result | Should Be $null
    }

    It 'Loads ClientObjectCollection with retrievals' {
        $param = @{
            ClientContext = $SPClient.ClientContext
            ClientObject = $SPClient.ClientContext.Web.Lists
            Retrievals = 'Include(RootFolder.ServerRelativeUrl)'
        }
        $result = Invoke-SPClientLoadQuery @param
        $result | Should Be $null
    }

}
