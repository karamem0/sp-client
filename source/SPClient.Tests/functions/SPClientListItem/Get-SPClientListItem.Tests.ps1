#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Get-SPClientListItem' {
    
    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Returns all list items' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $result = $list | Get-SPClientListItem
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItemCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
        $result.ListItemCollectionPosition | ForEach-Object { Write-Host "$(' ' * 3)$($_)" }
    }

    It 'Returns list items with folder url' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            FolderUrl = $web.ServerRelativeUrl.TrimEnd('/') + '/' + $TestConfig.ListInternalName
        }
        $result = $list | Get-SPClientListItem @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItemCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
    }

    It 'Returns list items with scope' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Scope = 'Recursive'
        }
        $result = $list | Get-SPClientListItem @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItemCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
    }

    It 'Returns list items with view fields' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            ViewFields = `
                '<ViewFields>' + `
                '<FieldRef Name="ID"/>' + `
                '<FieldRef Name="FileRef"/>' + `
                '</ViewFields>'
        }
        $result = $list | Get-SPClientListItem @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItemCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
    }

    It 'Returns list items with row limit' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            RowLimit = 2
        }
        $result = $list | Get-SPClientListItem @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItemCollection'
        $result.Count | Should Be 2
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
    }

    It 'Returns list items with position' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            RowLimit = 2
        }
        $result = $list | Get-SPClientListItem @param
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
        $position = $result.ListItemCollectionPosition
        while ($position -ne $null) {
            $position | ForEach-Object { Write-Host "$(' ' * 3)$($_)" }
            $param = @{
                RowLimit = 2
                Position = $position
            }
            $result = $list | Get-SPClientListItem @param
            $result | Should Not Be $null
            $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItemCollection'
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
            $position = $result.ListItemCollectionPosition
        }
    }

    It 'Returns list items with query' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Query = `
                '<Query>' + `
                '<Where>' + `
                '<Eq><FieldRef Name="ID"/><Value Type="Integer">1</Value></Eq>' + `
                '</Where>' + `
                '</Query>'
        }
        $result = $list | Get-SPClientListItem @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItemCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
    }

    It 'Returns a list item by id' {
        $web = Get-SPClientWeb -Default
        $list = $web | Get-SPClientList -Title $TestConfig.ListTitle
        $param = @{
            Identity = ($list | Get-SPClientListItem -RowLimit 1)[0].Id
        }
        $result = $list | Get-SPClientListItem @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.ListItem'
        $result.Id | Should Be $param.Identity
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_['FileRef'])" }
    }

}
