#Requires -Version 3.0

. "$($PSScriptRoot)\..\TestInitialize.ps1"

Describe 'Invoke-SPClientLoadQuery' {

    Context 'Success' {

        It 'Loads ClientObject without retrievals' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web
            }
            $Result = Invoke-SPClientLoadQuery @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObject with retrievals' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web
                Retrievals = 'Id, RootFolder.ServerRelativeUrl'
            }
            $Result = Invoke-SPClientLoadQuery @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObjectCollection without retrievals' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web.Lists
            }
            $Result = Invoke-SPClientLoadQuery @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObjectCollection with retrievals' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web.Lists
                Retrievals = 'Include(RootFolder.ServerRelativeUrl)'
            }
            $Result = Invoke-SPClientLoadQuery @Params
            $Result | Should BeNullOrEmpty
        }

    }

}
