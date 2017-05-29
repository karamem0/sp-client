#Requires -Version 3.0

Add-Type -Path "$($PSScriptRoot)\..\..\lib\Microsoft.SharePoint.Client.dll"
Add-Type -Path "$($PSScriptRoot)\..\..\lib\Microsoft.SharePoint.Client.Runtime.dll"

$UserName = $Env:LoginUserName
$Password = ConvertTo-SecureString -String $Env:LoginPassword -AsPlainText -Force
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
$ClientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Env:LoginUrl)
$ClientContext.Credentials = $credentials

$ClientContext.Load($ClientContext.Site)

$ClientContext.ExecuteQuery()

$Web1 = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$Web1.Url = 'TestWeb1'
$Web1.Language = '1033'
$Web1.WebTemplate = 'STS#1'
$Web1.Title = 'Test Web 1'
$Web1.Description = ''
$Web1.UseSamePermissionsAsParentSite = $false
$Web1 = $ClientContext.Web.Webs.Add($Web1)
$Web1.Update()
$Web1.BreakRoleInheritance($false, $false)
$ClientContext.Load($Web1)

$Web2 = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$Web2.Url = 'TestWeb2'
$Web2.Language = '1033'
$Web2.WebTemplate = 'STS#1'
$Web2.Title = 'Test Web 2'
$Web2.Description = ''
$Web2.UseSamePermissionsAsParentSite = $false
$Web2 = $Web1.Webs.Add($Web2)
$Web2.Update()
$ClientContext.Load($Web2)

$Web3 = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$Web3.Url = 'TestWeb3'
$Web3.Language = '1033'
$Web3.WebTemplate = 'STS#1'
$Web3.Title = 'Test Web 3'
$Web3.Description = ''
$Web3.UseSamePermissionsAsParentSite = $false
$Web3 = $Web1.Webs.Add($Web3)
$Web3.Update()
$ClientContext.Load($Web3)

$Web4 = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$Web4.Url = 'TestWeb4'
$Web4.Language = '1033'
$Web4.WebTemplate = 'STS#1'
$Web4.Title = 'Test Web 4'
$Web4.Description = ''
$Web4.UseSamePermissionsAsParentSite = $false
$Web4 = $Web3.Webs.Add($Web4)
$Web4.Update()
$ClientContext.Load($Web4)

$ClientContext.ExecuteQuery()

$Group1 = New-Object Microsoft.SharePoint.Client.GroupCreationInformation
$Group1.Title = 'Test Group 1'
$Group1.Description = 'Test Group 1'
$Group1 = $Web1.SiteGroups.Add($Group1)
$Group1.Owner = $Group1
$Group1.Update()
$ClientContext.Load($Group1)

$Group2 = New-Object Microsoft.SharePoint.Client.GroupCreationInformation
$Group2.Title = 'Test Group 2'
$Group2.Description = 'Test Group 2'
$Group2 = $Web1.SiteGroups.Add($Group2)
$Group2.Owner = $Group2
$Group2.Update()
$ClientContext.Load($Group2)

$Group3 = New-Object Microsoft.SharePoint.Client.GroupCreationInformation
$Group3.Title = 'Test Group 3'
$Group3.Description = 'Test Group 3'
$Group3 = $Web1.SiteGroups.Add($Group3)
$Group3.Owner = $Group3
$Group3.Update()
$ClientContext.Load($Group3)

$ClientContext.ExecuteQuery()

$User1 = New-Object Microsoft.SharePoint.Client.UserCreationInformation
$User1.LoginName = "i:0#.f|membership|testuser1@$($Env:LoginDomain)"
$User1.Title = 'Test User 1'
$User1.Email = "testuser1@$($Env:LoginDomain)"
$User1 = $Group1.Users.Add($User1)
$User1.Update()
$ClientContext.Load($User1)

$User2 = New-Object Microsoft.SharePoint.Client.UserCreationInformation
$User2.LoginName = "i:0#.f|membership|testuser2@$($Env:LoginDomain)"
$User2.Title = 'Test User 2'
$User2.Email = "testuser1@$($Env:LoginDomain)"
$User2 = $Group2.Users.Add($User2)
$User2.Update()
$ClientContext.Load($User2)

$User3 = New-Object Microsoft.SharePoint.Client.UserCreationInformation
$User3.LoginName = "i:0#.f|membership|testuser3@$($Env:LoginDomain)"
$User3.Title = 'Test User 3'
$User3.Email = "testuser1@$($Env:LoginDomain)"
$User3 = $Group3.Users.Add($User3)
$User3.Update()
$ClientContext.Load($User3)

$ClientContext.ExecuteQuery()

$ContentType1 = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
$ContentType1.Name = 'Test Content Type 1'
$ContentType1 = $Web1.ContentTypes.Add($ContentType1)
$ContentType1.Update($true)
$ClientContext.Load($ContentType1)

$ContentType2 = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
$ContentType2.Name = 'Test Content Type 2'
$ContentType2 = $Web1.ContentTypes.Add($ContentType2)
$ContentType2.Update($true)
$ClientContext.Load($ContentType2)

$ContentType3 = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
$ContentType3.Name = 'Test Content Type 3'
$ContentType3 = $Web1.ContentTypes.Add($ContentType3)
$ContentType3.Update($true)
$ClientContext.Load($ContentType3)

$ClientContext.ExecuteQuery()

$List1 = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$List1.Title = 'TestList1'
$List1.Description = ''
$List1.TemplateType = 100
$List1 = $Web1.Lists.Add($List1)
$List1.Title = 'Test List 1'
$List1.Update()
$ClientContext.Load($List1)
$ClientContext.Load($List1.RootFolder)

$List2 = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$List2.Title = 'TestList2'
$List2.Description = ''
$List2.TemplateType = 100
$List2 = $Web1.Lists.Add($List2)
$List2.Title = 'Test List 2'
$List2.Update()
$ClientContext.Load($List2)
$ClientContext.Load($List2.RootFolder)

$List3 = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$List3.Title = 'TestList3'
$List3.Description = ''
$List3.TemplateType = 100
$List3 = $Web1.Lists.Add($List3)
$List3.Title = 'Test List 3'
$List3.Update()
$ClientContext.Load($List3)
$ClientContext.Load($List3.RootFolder)

$ClientContext.ExecuteQuery()

$Xml = '<Field Name="TestField1" DisplayName="Test Field 1" Type="Text" />'
$Field1 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field1.Update()
$ClientContext.Load($Field1)

$Xml = '<Field Name="TestField2" DisplayName="Test Field 2" Type="Note" />'
$Field2 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field2.Update()
$ClientContext.Load($Field2)

$Xml = '<Field Name="TestField3" DisplayName="Test Field 3" Type="Choice">' + `
    '<CHOICES>' + `
    '<CHOICE>Test Value 1</CHOICE>' + `
    '<CHOICE>Test Value 2</CHOICE>' + `
    '<CHOICE>Test Value 3</CHOICE>' + `
    '</CHOICES>' + `
    '</Field>'
$Field3 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field3.Update()
$ClientContext.Load($Field3)

$Xml = '<Field Name="TestField4" DisplayName="Test Field 4" Type="MultiChoice" Mult="TRUE">' + `
    '<CHOICES>' + `
    '<CHOICE>Test Value 1</CHOICE>' + `
    '<CHOICE>Test Value 2</CHOICE>' + `
    '<CHOICE>Test Value 3</CHOICE>' + `
    '</CHOICES>' + `
    '</Field>'
$Field4 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field4.Update()
$ClientContext.Load($Field4)

$Xml = '<Field Name="TestField5" DisplayName="Test Field 5" Type="Number" />'
$Field5 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field5.Update()
$ClientContext.Load($Field5)

$Xml = '<Field Name="TestField6" DisplayName="Test Field 6" Type="Currency" />'
$Field6 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field6.Update()
$ClientContext.Load($Field6)

$Xml = '<Field Name="TestField7" DisplayName="Test Field 7" Type="DateTime" />'
$Field7 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field7.Update()
$ClientContext.Load($Field7)

$Xml = '<Field Name="TestField8" DisplayName="Test Field 8" Type="Lookup" List="' + $List1.Id.ToString('B') + '" ShowField="Title" />'
$Field8 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field8.Update()
$ClientContext.Load($Field8)

$Xml = '<Field Name="TestField9" DisplayName="Test Field 9" Type="LookupMulti" Mult="TRUE" List="' + $List1.Id.ToString('B') + '" ShowField="Title" />'
$Field9 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field9.Update()
$ClientContext.Load($Field9)

$Xml = '<Field Name="TestField10" DisplayName="Test Field 10" Type="Boolean" />'
$Field10 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field10.Update()
$ClientContext.Load($Field10)

$Xml = '<Field Name="TestField11" DisplayName="Test Field 11" Type="User" />'
$Field11 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field11.Update()
$ClientContext.Load($Field11)

$Xml = '<Field Name="TestField12" DisplayName="Test Field 12" Type="UserMulti" Mult="TRUE" />'
$Field12 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field12.Update()
$ClientContext.Load($Field12)

$Xml = '<Field Name="TestField13" DisplayName="Test Field 13" Type="URL" />'
$Field13 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field13.Update()
$ClientContext.Load($Field13)

$Xml = '<Field Name="TestField14" DisplayName="Test Field 14" Type="Calculated" ResultType="Text">' + `
    '<Formula>=[Title]</Formula>' + `
    '<FieldRefs>' + `
    '<FieldRef Name="Title" />' + `
    '</FieldRefs>' + `
    '</Field>'
$Field14 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field14.Update()
$ClientContext.Load($Field14)

$ClientContext.ExecuteQuery()

$View1 = New-Object Microsoft.SharePoint.Client.ViewCreationInformation
$View1.Title = 'TestView1'
$View1.ViewFields = @(
    'Test Field 1'
    'Test Field 2'
    'Test Field 3'
    'Test Field 4'
)
$View1 = $List1.Views.Add($View1)
$View1.Title = 'Test View 1'
$View1.Update()
$ClientContext.Load($View1)

$View2 = New-Object Microsoft.SharePoint.Client.ViewCreationInformation
$View2.Title = 'TestView2'
$View2.ViewFields = @(
    'Test Field 1'
    'Test Field 2'
    'Test Field 3'
    'Test Field 4'
)
$View2 = $List1.Views.Add($View2)
$View2.Title = 'Test View 2'
$View2.Update()
$ClientContext.Load($View2)

$View3 = New-Object Microsoft.SharePoint.Client.ViewCreationInformation
$View3.Title = 'TestView3'
$View3.ViewFields = @(
    'Test Field 1'
    'Test Field 2'
    'Test Field 3'
    'Test Field 4'
)
$View3 = $List1.Views.Add($View3)
$View3.Title = 'Test View 3'
$View3.Update()
$ClientContext.Load($View3)

$ClientContext.ExecuteQuery()

$ListItem1 = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
$ListItem1 = $List1.AddItem($ListItem1)
$ListItem1['Title'] = 'Test List Item 1'
$ListItem1.Update()

$ListItem2 = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
$ListItem2 = $List1.AddItem($ListItem2)
$ListItem2['Title'] = 'Test List Item 2'
$ListItem2.Update()

$ListItem3 = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
$ListItem3 = $List1.AddItem($ListItem3)
$ListItem3['Title'] = 'Test List Item 3'
$ListItem3.Update()

$ClientContext.ExecuteQuery()

$ListItem1['TestField1'] = 'Test Value 1'
$ListItem1['TestField2'] = 'Test Value 1'
$ListItem1['TestField3'] = 'Test Value 1'
$ListItem1['TestField4'] = @('Test Value 1', 'Test Value 2', 'Test Value 3')
$ListItem1['TestField5'] = 1
$ListItem1['TestField6'] = 1
$ListItem1['TestField7'] = [datetime]'10/10/2010'
$ListItem1['TestField10'] = $true
$ListItem1['TestField13'] = 'http://www.example.com, Test Value 1'
$ListItem1.Update()
$ClientContext.Load($ListItem1)

$ListItem2['TestField1'] = 'Test Value 2'
$ListItem2['TestField2'] = 'Test Value 2'
$ListItem2['TestField3'] = 'Test Value 2'
$ListItem2['TestField4'] = 'Test Value 2'
$ListItem2['TestField5'] = 2
$ListItem2['TestField6'] = 2
$ListItem2['TestField7'] = [datetime]'12/20/2016'
$ListItem2['TestField10'] = $false
$ListItem2['TestField13'] = 'http://www.example.com, Test Value 2'
$ListItem2.Update()
$ClientContext.Load($ListItem2)

$ListItem3['TestField1'] = 'Test Value 3'
$ListItem3['TestField2'] = 'Test Value 3'
$ListItem3['TestField3'] = 'Test Value 3'
$ListItem3['TestField4'] = 'Test Value 3'
$ListItem3['TestField5'] = 3
$ListItem3['TestField6'] = 3
$ListItem3['TestField7'] = [datetime]'12/25/2017'
$ListItem3['TestField10'] = $true
$ListItem3['TestField13'] = 'http://www.example.com, Test Value 3'
$ListItem3.Update()
$ClientContext.Load($ListItem3)

$ClientContext.ExecuteQuery()

$Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestAttachment1')
$Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
$Attachment1 = New-Object Microsoft.SharePoint.Client.AttachmentCreationInformation
$Attachment1.FileName = 'TestAttachment1.txt'
$Attachment1.ContentStream = $Stream
$Attachment1 = $ListItem1.AttachmentFiles.Add($Attachment1)
$ClientContext.Load($Attachment1)

$Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestAttachment2')
$Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
$Attachment2 = New-Object Microsoft.SharePoint.Client.AttachmentCreationInformation
$Attachment2.FileName = 'TestAttachment2.txt'
$Attachment2.ContentStream = $Stream
$Attachment2 = $ListItem1.AttachmentFiles.Add($Attachment2)
$ClientContext.Load($Attachment2)

$Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestAttachment3')
$Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
$Attachment3 = New-Object Microsoft.SharePoint.Client.AttachmentCreationInformation
$Attachment3.FileName = 'TestAttachment3.txt'
$Attachment3.ContentStream = $Stream
$Attachment3 = $ListItem1.AttachmentFiles.Add($Attachment3)
$ClientContext.Load($Attachment3)

$ClientContext.ExecuteQuery()

$DocLib1 = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$DocLib1.Title = 'TestDocLib1'
$DocLib1.Description = ''
$DocLib1.TemplateType = 101
$DocLib1 = $Web1.Lists.Add($DocLib1)
$DocLib1.Title = 'Test Documents 1'
$DocLib1.Update()
$ClientContext.Load($DocLib1)
$ClientContext.Load($DocLib1.RootFolder)

$ClientContext.ExecuteQuery()

$Folder1 = $DocLib1.RootFolder.Folders.Add('TestFolder1')
$Folder1.Update()
$ClientContext.Load($Folder1)
$ClientContext.Load($Folder1.ListItemAllFields)

$Folder2 = $Folder1.Folders.Add('TestFolder2')
$Folder2.Update()
$ClientContext.Load($Folder2)
$ClientContext.Load($Folder2.ListItemAllFields)

$Folder3 = $Folder1.Folders.Add('TestFolder3')
$Folder3.Update()
$ClientContext.Load($Folder3)
$ClientContext.Load($Folder3.ListItemAllFields)

$Folder4 = $Folder3.Folders.Add('TestFolder4')
$Folder4.Update()
$ClientContext.Load($Folder4)
$ClientContext.Load($Folder4.ListItemAllFields)

$ClientContext.ExecuteQuery()

$Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestFile1')
$Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
$File1 = New-Object Microsoft.SharePoint.Client.FileCreationInformation
$File1.Url = 'TestFile1.txt'
$File1.ContentStream = $Stream
$File1 = $Folder1.Files.Add($File1)
$File1.Update()
$ClientContext.Load($File1)
$ClientContext.Load($File1.ListItemAllFields)

$Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestFile2')
$Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
$File2 = New-Object Microsoft.SharePoint.Client.FileCreationInformation
$File2.Url = 'TestFile2.txt'
$File2.ContentStream = $Stream
$File2 = $Folder1.Files.Add($File2)
$File2.Update()
$ClientContext.Load($File2)
$ClientContext.Load($File2.ListItemAllFields)

$Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestFile3')
$Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
$File3 = New-Object Microsoft.SharePoint.Client.FileCreationInformation
$File3.Url = 'TestFile3.txt'
$File3.ContentStream = $Stream
$File3 = $Folder1.Files.Add($File3)
$File3.Update()
$ClientContext.Load($File3)
$ClientContext.Load($File3.ListItemAllFields)

$Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestFile4')
$Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
$File4 = New-Object Microsoft.SharePoint.Client.FileCreationInformation
$File4.Url = 'TestFile4.txt'
$File4.ContentStream = $Stream
$File4 = $Folder4.Files.Add($File4)
$File4.Update()
$ClientContext.Load($File4)
$ClientContext.Load($File4.ListItemAllFields)

$ClientContext.ExecuteQuery()

$TestConfig = @{
    SiteUrl = $ClientContext.Site.ServerRelativeUrl
    WebId = $Web1.Id
    WebTitle = $Web1.Title
    WebUrl = $Web1.ServerRelativeUrl
    ContentTypeId = $ContentType1.StringId
    ContentTypeName = $ContentType1.Name
    ListId = $List1.Id
    ListTitle = $List1.Title
    ListUrl = $List1.RootFolder.ServerRelativeUrl
    ListName = $List1.RootFolder.Name
    FieldId = $Field1.Id
    FieldTitle = $Field1.Title
    FieldName = $Field1.InternalName
    ViewId = $View1.Id
    ViewTitle = $View1.Title
    ViewUrl = $View1.ServerRelativeUrl
    ListItemId = $ListItem1.Id
    ListItemUniqueId = $ListItem1.FieldValues['UniqueId']
    AttachmentFileName = $Attachment1.FileName
    DocLibId = $DocLib1.Id
    DocLibTitle = $DocLib1.Title
    DocLibUrl = $DocLib1.RootFolder.ServerRelativeUrl
    DocLibName = $DocLib1.RootFolder.Name
    FolderId = $Folder1.ListItemAllFields.FieldValues['UniqueId']
    FolderName = $Folder1.Name
    FolderUrl = $Folder1.ServerRelativeUrl
    FileId = $File1.ListItemAllFields.FieldValues['UniqueId']
    FileName  = $File1.Name
    FileUrl  = $File1.ServerRelativeUrl
    UserId = $User1.Id
    UserName = $User1.LoginName
    UserEmail = $User1.Email
    GroupId = $Group1.Id
    GroupName = $Group1.Title
}
$TestConfig |
    ConvertTo-Json -Compress |
    Out-File "$($PSScriptRoot)\TestConfiguration.json"
