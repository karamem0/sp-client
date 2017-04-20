#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Disconnect-SPClientContext' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.SharePointOnlineUrl `
            -Online `
            -UserName $TestConfig.SharePointOnlineUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.SharePointOnlinePassword -AsPlainText -Force)
    }

    It 'Disconnects the context' {
        $result = Disconnect-SPClientContext
        $result | Should Be $null
    }

    It 'Throws an error when context is null' {
        $SPClient.ClientContext = $null
        $throw = { Disconnect-SPClientContext }
        $throw | Should Throw "Cannot bind argument to parameter 'ClientContext' because it is null."
    }

}
