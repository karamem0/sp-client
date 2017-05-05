#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientField' {

    BeforeEach {
        try {
            $Xml = '<Field Type="Text" ID="2F992681-3273-4C8C-BACD-8B7A9BBA0EE4" Name="TestField0" DisplayName="Test Field 0" />'
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.AddFieldAsXml($Xml, $True, 8)
            $SPClient.ClientContext.Load($Field)
            $SPClient.ClientContext.ExecuteQuery()
        } catch {
            Write-Host " [BeforeEach] $($_)" -ForegroundColor Yellow 
        }
    }

    It 'Removes a field by loaded client object' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Field = Get-SPClientField -ParentObject $List -Name 'TestField0'
        $Params = @{
            ClientObject = $Field
        }
        $Result = Remove-SPClientField @Params
        $Result | Should BeNullOrEmpty
    }

    It 'Removes a field by unloaded client object' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Field = $List.Fields.GetByInternalNameOrTitle('TestField0')
        $Params = @{
            ClientObject = $Field
        }
        $Result = Remove-SPClientField @Params
        $Result | Should BeNullOrEmpty
    }

    It 'Removes a field by id' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
        }
        $Result = Remove-SPClientField @Params
        $Result | Should BeNullOrEmpty
    }

    It 'Removes a field by title' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Name = 'Test Field 0'
        }
        $Result = Remove-SPClientField @Params
        $Result | Should BeNullOrEmpty
    }

    It 'Removes a field by internal name' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Name = 'TestField0'
        }
        $Result = Remove-SPClientField @Params
        $Result | Should BeNullOrEmpty
    }

}
