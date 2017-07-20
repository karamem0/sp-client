# Get-SPClientView

## SYNOPSIS
Gets one or more views.

## SYNTAX

### All (Default)
```
Get-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind> [-NoEnumerate]
 [-Retrieval <String>]
```

### Identity
```
Get-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind> -Identity <Guid>
 [-Retrieval <String>]
```

### Url
```
Get-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind> -Url <String>
 [-Retrieval <String>]
```

### Title
```
Get-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind> -Title <String>
 [-Retrieval <String>]
```

### Default
```
Get-SPClientView [-ClientContext <ClientContext>] [-ParentObject] <SPClientViewParentPipeBind> [-Default]
 [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientView function lists all views or retrieves the specified view.
If not specified filterable parameter, returns all views of the list.
Otherwise, returns a view which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientView $list
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientView $list -Identity "E9F79B5B-4A14-46A9-983C-78387C40255B"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientView $list -Url "/Lists/List1/CustomView.aspx"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientView $list -Title "Custom View"
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientView $list -Default
```

### -------------------------- Example 6 --------------------------
```
Get-SPClientView $list -Retrieval "Title"
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
Indicates the list which the views are contained.

```yaml
Type: SPClientViewParentPipeBind
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

### -Default
If specified, returns the default view.

```yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases: 

Required: True
Position: Named
Default value: False
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

### None or SPClient.SPClientViewParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.View[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientView.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientView.md)

