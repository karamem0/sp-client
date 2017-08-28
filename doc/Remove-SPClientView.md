# Remove-SPClientView

## SYNOPSIS
Deletes the view.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientView [-ClientContext <ClientContext>] [-ClientObject] <View>
```

### Title
```
Remove-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind>
 -Title <String>
```

### Url
```
Remove-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind> -Url <String>
```

### Identity
```
Remove-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind>
 -Identity <Guid>
```

## DESCRIPTION
The Remove-SPClientView function removes the view from the list.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientView $view
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientView $list -Identity "E9F79B5B-4A14-46A9-983C-78387C40255B"
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientView $list -Url "/Lists/List1/CustomView.aspx"
```

### -------------------------- Example 4 --------------------------
```
Remove-SPClientView $list -Title "Custom View"
```

## PARAMETERS

### -ClientContext
Indicates the client context.
If not specified, uses a default context.

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

### -ClientObject
Indicates the view to delete.

```yaml
Type: View
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentObject
Indicates the list which the view is contained.

```yaml
Type: SPClientViewParentPipeBind
Parameter Sets: Title, Url, Identity
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the view GUID.

```yaml
Type: Guid
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
Indicates the view URL.

```yaml
Type: String
Parameter Sets: Url
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Indicates the view title.

```yaml
Type: String
Parameter Sets: Title
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.View or SPClient.SPClientViewParentPipeBind

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientView.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientView.md)

