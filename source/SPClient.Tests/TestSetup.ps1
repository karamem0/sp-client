#Requires -Version 3.0

$CommonProgramFiles = $Env:CommonProgramFiles
if (-not [System.Environment]::Is64BitProcess -and
    -not [string]::IsNullOrEmpty($Env:CommonProgramW6432)) {
    $CommonProgramFiles = $Env:CommonProgramW6432
}
Add-Type -Path "$($CommonProgramFiles)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "$($CommonProgramFiles)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

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
$ClientContext.Load($Web1)

$Web2 = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$Web2.Url = 'TestWeb2'
$Web2.Language = '1033'
$Web2.WebTemplate = 'STS#1'
$Web2.Title = 'Test Web 2'
$Web2.Description = ''
$Web2.UseSamePermissionsAsParentSite = $false
$Web2 = $Web1.Webs.Add($Web2)
$ClientContext.Load($Web2)

$Web3 = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$Web3.Url = 'TestWeb3'
$Web3.Language = '1033'
$Web3.WebTemplate = 'STS#1'
$Web3.Title = 'Test Web 3'
$Web3.Description = ''
$Web3.UseSamePermissionsAsParentSite = $false
$Web3 = $Web1.Webs.Add($Web3)
$ClientContext.Load($Web3)

$Web4 = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$Web4.Url = 'TestWeb4'
$Web4.Language = '1033'
$Web4.WebTemplate = 'STS#1'
$Web4.Title = 'Test Web 4'
$Web4.Description = ''
$Web4.UseSamePermissionsAsParentSite = $false
$Web4 = $Web3.Webs.Add($Web4)
$ClientContext.Load($Web4)

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

$Xml = '<Field Type="Text" Name="TestField1" DisplayName="Test Field 1" />'
$Field1 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field1.Update()
$ClientContext.Load($Field1)

$Xml = '<Field Type="Note" Name="TestField2" DisplayName="Test Field 2" />'
$Field2 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field2.Update()
$ClientContext.Load($Field2)

$Xml = `
    '<Field Type="Choice" Name="TestField3" DisplayName="Test Field 3">' + `
    '<CHOICES>' + `
    '<CHOICE>Test Value 1</CHOICE>' + `
    '<CHOICE>Test Value 2</CHOICE>' + `
    '<CHOICE>Test Value 3</CHOICE>' + `
    '</CHOICES>' + `
    '</Field>'
$Field3 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field3.Update()
$ClientContext.Load($Field3)

$Xml = '<Field Type="Number" Name="TestField4" DisplayName="Test Field 4" />'
$Field4 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field4.Update()
$ClientContext.Load($Field4)

$Xml = '<Field Type="Currency" Name="TestField5" DisplayName="Test Field 5" />'
$Field5 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field5.Update()
$ClientContext.Load($Field5)

$Xml = '<Field Type="DateTime" Name="TestField6" DisplayName="Test Field 6" />'
$Field6 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field6.Update()
$ClientContext.Load($Field6)

$Xml = '<Field Type="Boolean" Name="TestField7" DisplayName="Test Field 7" />'
$Field7 = $List1.Fields.AddFieldAsXml($Xml, $true, 8)
$Field7.Update()
$ClientContext.Load($Field7)

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
$ListItem1['TestField1'] = 'Test List Item 1'
$ListItem1['TestField2'] = 'Test List Item 1'
$ListItem1['TestField3'] = 'Test Value 1'
$ListItem1['TestField4'] = 1
$ListItem1['TestField5'] = 1
$ListItem1['TestField6'] = [datetime]'10/10/2010'
$ListItem1['TestField7'] = 1
$ListItem1.Update()
$ClientContext.Load($ListItem1)

$ListItem2 = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
$ListItem2 = $List1.AddItem($ListItem2)
$ListItem2['Title'] = 'Test List Item 2'
$ListItem2['TestField1'] = 'Test List Item 2'
$ListItem2['TestField2'] = 'Test List Item 2'
$ListItem2['TestField3'] = 'Test Value 2'
$ListItem2['TestField4'] = 2
$ListItem2['TestField5'] = 2
$ListItem2['TestField6'] = [datetime]'12/20/2016'
$ListItem2['TestField7'] = 0
$ListItem2.Update()
$ClientContext.Load($ListItem2)

$ListItem3 = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
$ListItem3 = $List1.AddItem($ListItem3)
$ListItem3['Title'] = 'Test List Item 3'
$ListItem3['TestField1'] = 'Test List Item 3'
$ListItem3['TestField2'] = 'Test List Item 3'
$ListItem3['TestField3'] = 'Test Value 3'
$ListItem3['TestField4'] = 3
$ListItem3['TestField5'] = 3
$ListItem3['TestField6'] = [datetime]'12/25/2017'
$ListItem3['TestField7'] = 1
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

$Web1.BreakRoleInheritance($false, $false)

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
$User1 = $Group1.Users.Add($User1)
$ClientContext.Load($User1)

$User2 = New-Object Microsoft.SharePoint.Client.UserCreationInformation
$User2.LoginName = "i:0#.f|membership|testuser2@$($Env:LoginDomain)"
$User2.Title = 'Test User 2'
$User2 = $Group2.Users.Add($User2)
$ClientContext.Load($User2)

$User3 = New-Object Microsoft.SharePoint.Client.UserCreationInformation
$User3.LoginName = "i:0#.f|membership|testuser3@$($Env:LoginDomain)"
$User3.Title = 'Test User 3'
$User3 = $Group3.Users.Add($User3)
$ClientContext.Load($User3)

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
    AttachmentFileName = $Attachment1.FileName
    UserId = $User1.Id
    UserName = $User1.LoginName
    UserEmail = $User1.Email
    GroupId = $Group1.Id
    GroupName = $Group1.LoginName
}
$TestConfig |
    ConvertTo-Json -Compress |
    Out-File "$($PSScriptRoot)\TestConfiguration.json"
