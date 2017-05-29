#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientList' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.GetList("$($TestConfig.WebUrl)/Lists/TestList0")
                $List.DeleteObject()
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new list with mandatory parameters' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Params = @{
                ParentWeb = $Web
                Name = 'TestList0'
            }
            $Result = New-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.Title | Should Be 'TestList0'
            $Result.Description | Should BeNullOrEmpty
            $Result.BaseTemplate | Should Be 100
            $Result.EnableAttachments | Should Be $false
            $Result.EnableFolderCreation | Should Be $false
            $Result.EnableVersioning | Should Be $false
            $Result.NoCrawl | Should Be $false
            $Result.OnQuickLaunch | Should Be $false
        }

        It 'Creates a new list with all parameters' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Params = @{ 
                ParentWeb = $Web
                Name = 'TestList0'
                Title = 'Test List 0'
                Description = 'Test List 0'
                Template = 107
                EnableAttachments = $true
                EnableFolderCreation = $true
                EnableVersioning = $true
                NoCrawl = $true
                OnQuickLaunch = $true
            }
            $Result = New-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.Title | Should Be 'Test List 0'
            $Result.Description | Should Be 'Test List 0'
            $Result.BaseTemplate | Should Be 107
            $Result.EnableAttachments | Should Be $true
            $Result.EnableFolderCreation | Should Be $true
            $Result.EnableVersioning | Should Be $true
            $Result.NoCrawl | Should Be $true
            $Result.OnQuickLaunch | Should Be $true
        }

    }

}
