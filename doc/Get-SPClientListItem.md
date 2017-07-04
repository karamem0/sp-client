# Get-SPClientListItem

## SYNOPSIS
Gets one or more list items.

## SYNTAX

### All (Default)
```
Get-SPClientListItem [-ClientContext <ClientContext>] [-ParentObject] <SPClientListItemParentParameter>
 [-FolderUrl <String>] [-Scope <String>] [-ViewFields <String[]>] [-Query <String>] [-RowLimit <Int32>]
 [-Position <ListItemCollectionPosition>] [-NoEnumerate] [-Retrieval <String>]
```

### Identity
```
Get-SPClientListItem [-ClientContext <ClientContext>] [-ParentObject] <SPClientListItemParentParameter>
 -Identity <Int32> [-Retrieval <String>]
```

### IdentityGuid
```
Get-SPClientListItem [-ClientContext <ClientContext>] [-ParentObject] <SPClientListItemParentParameter>
 -IdentityGuid <Guid> [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientListItem function retrieves list items using CAML query.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientListItem
```

### -------------------------- Example 2 --------------------------
```
<FieldRef Name='Title'/></OrderBy>" -RowLimit 10
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientListItem -Identity 7
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientListItem -IdentityGuid "77DF0F67-9B13-4499-AC14-25EB18E1D3DA"
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientListItem -Retrieval "Title"
```

## PARAMETERS

### -ClientContext
Indicates the client context.
If not specified, uses default context.

```yaml
Type: ClientContext
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: $SPClient.ClientContext
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentObject
Indicates the list which the list items are contained.

```yaml
Type: SPClientListItemParentParameter
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FolderUrl
Indicates the folder URL.

```yaml
Type: String
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Indicates the scope of retrievals.
  - FilesOnly: Only the files of a specific folder. 
  - Recursive: All files of all folders. 
  - RecursiveAll: All files and all subfolders of all folders.
If not specified, only the files and subfolders of a specific folder.

```yaml
Type: String
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ViewFields
Indicates the collection of view columns.

```yaml
Type: String[]
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Query
Indicates the XML representation of query.

```yaml
Type: String
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RowLimit
Indicates the number of items.
This parameter is used for item pagination.

```yaml
Type: Int32
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position
Indicates the starting position.
This parameter is used for item pagination.

```yaml
Type: ListItemCollectionPosition
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoEnumerate
If specified, suppresses enumeration in output.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
Indicates the list item ID.

```yaml
Type: Int32
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentityGuid
Indicates the list item GUID.

```yaml
Type: Guid
Parameter Sets: IdentityGuid
Aliases: UniqueId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Retrieval
Indicates the data retrieval expression.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or SPClient.SPClientListItemParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.ListItemCollection or Microsoft.SharePoint.Client.ListItem

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientListItem.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientListItem.md)

