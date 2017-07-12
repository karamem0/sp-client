# Get-SPClientList

## SYNOPSIS
Gets one or more lists.

## SYNTAX

### All (Default)
```
Get-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentParameter> [-NoEnumerate]
 [-Retrieval <String>]
```

### Identity
```
Get-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentParameter>
 -Identity <Guid> [-Retrieval <String>]
```

### Url
```
Get-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentParameter> -Url <String>
 [-Retrieval <String>]
```

### Name
```
Get-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentParameter> -Name <String>
 [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientList function lists all lists or retrieve the specified list.
If not specified filterable parameter, returns all lists of the site.
Otherwise, returns a list which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientList $web
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientList $web -Identity "CE5D9232-37A1-41D0-BCDB-B8C59958B831"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientList $web -Url "/Lists/CustomList"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientList $web -Name "Custom List"
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientList $web -Retrieval "Title"
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
Indicates the site which the lists are contained.

```yaml
Type: SPClientListParentParameter
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
Indicates the list GUID.

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
Indicates the list URL.

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

### -Name
Indicates the list title or internal name.

```yaml
Type: String
Parameter Sets: Name
Aliases: Title

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

### None or SPClient.SPClientListParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.List[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientList.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientList.md)

