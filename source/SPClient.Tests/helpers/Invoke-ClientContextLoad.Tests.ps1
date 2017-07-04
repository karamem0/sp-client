#Requires -Version 3.0

. "$($PSScriptRoot)\..\TestInitialize.ps1"

Describe 'Invoke-ClientContextLoad' {

    Context 'Success' {

        It 'Loads ClientObject without retrievals' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web
            }
            $Result = Invoke-ClientContextLoad @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObject with retrievals that contains specified properties' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web
                Retrieval = 'Id, RootFolder.ServerRelativeUrl'
            }
            $Result = Invoke-ClientContextLoad @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObject with retrievals that contains all properties' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web
                Retrieval = '*, RootFolder.ServerRelativeUrl'
            }
            $Result = Invoke-ClientContextLoad @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObjectCollection without retrievals' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web.Lists
            }
            $Result = Invoke-ClientContextLoad @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObjectCollection with retrievals that contains specified properties' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web.Lists
                Retrieval = 'Include(RootFolder.ServerRelativeUrl)'
            }
            $Result = Invoke-ClientContextLoad @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads ClientObjectCollection with retrievals that contains all properties' {
            $Params = @{
                ClientContext = $SPClient.ClientContext
                ClientObject = $SPClient.ClientContext.Web.Lists
                Retrieval = 'Include(*, RootFolder.ServerRelativeUrl)'
            }
            $Result = Invoke-ClientContextLoad @Params
            $Result | Should BeNullOrEmpty
        }

    }

}
