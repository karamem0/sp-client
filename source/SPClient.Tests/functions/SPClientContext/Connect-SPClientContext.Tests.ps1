#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Connect-SPClientContext' {

    Context 'Success' {

        It 'Connects to the SharePoint Server using password' {
            $Params = @{
                Network = $true
                Url = 'https://example.sharepoint.com'
                UserName = 'administrator'
                Password = 'P@$$w0rd' | ConvertTo-SecureString -AsPlainText -Force
                Domain = 'example.com'
                PassThru = $true
            }
            $Result = Connect-SPClientContext @Params
            $Result | Should Not BeNullOrEmpty
            $Result.Credentials | Should BeOfType 'System.Net.NetworkCredential' 
            $Result.Credentials.UserName | Should Be 'administrator'
            $Result.Credentials.Domain | Should Be 'example.com'
        }

        It 'Connects to the SharePoint Server using credential' {
            $UserName = 'administrator@example.onmicrosoft.com'
            $Password = 'P@$$w0rd' | ConvertTo-SecureString -AsPlainText -Force
            $Params = @{
                Network = $true
                Url = 'https://example.sharepoint.com'
                Credential = New-Object System.Management.Automation.PSCredential($UserName, $Password)
                PassThru = $true
            }
            $Result = Connect-SPClientContext @Params
            $Result | Should Not BeNullOrEmpty
            $Result.Credentials | Should BeOfType 'System.Net.NetworkCredential' 
            $Result.Credentials.UserName | Should Be 'administrator@example.onmicrosoft.com'
        }

        It 'Connects to the SharePoint Online using password' {
            $Params = @{
                Online = $true
                Url = 'https://example.sharepoint.com'
                UserName = 'administrator@example.onmicrosoft.com'
                Password = 'P@$$w0rd' | ConvertTo-SecureString -AsPlainText -Force
                PassThru = $true
            }
            $Result = Connect-SPClientContext @Params
            $Result | Should Not BeNullOrEmpty
            $Result.Credentials | Should BeOfType 'Microsoft.SharePoint.Client.SharePointOnlineCredentials' 
            $Result.Credentials.UserName | Should Be 'administrator@example.onmicrosoft.com'
        }

        It 'Connects to the SharePoint Online using credential' {
            $UserName = 'administrator@example.onmicrosoft.com'
            $Password = 'P@$$w0rd' | ConvertTo-SecureString -AsPlainText -Force
            $Params = @{
                Online = $true
                Url = 'https://example.sharepoint.com'
                Credential = New-Object System.Management.Automation.PSCredential($UserName, $Password)
                PassThru = $true
            }
            $Result = Connect-SPClientContext @Params
            $Result | Should Not BeNullOrEmpty
            $Result.Credentials | Should BeOfType 'Microsoft.SharePoint.Client.SharePointOnlineCredentials' 
            $Result.Credentials.UserName | Should Be 'administrator@example.onmicrosoft.com'
        }

    }

}
