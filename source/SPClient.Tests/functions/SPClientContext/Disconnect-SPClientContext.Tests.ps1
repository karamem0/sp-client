#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Disconnect-SPClientContext' {

    Context 'Success' {

        It 'Disconnects the context' {
            $Result = Disconnect-SPClientContext
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when context is null' {
            $SPClient.ClientContext = $null
            $Throw = {
                $Result = Disconnect-SPClientContext
                $Result | Should BeNullOrEmpty
            }
            $Throw | Should Throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }

    }

}
