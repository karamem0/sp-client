#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Disconnect-SPClientContext' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Disconnects the context' {
        try {
            $result = Disconnect-SPClientContext
            $result | Should Be $null
        } finally { }
    }

    It 'Throws an error when context is null' {
        try {
            $SPClient.ClientContext = $null
            $throw = { Disconnect-SPClientContext }
            $throw | Should Throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        } finally { }
    }

}
