# Remove-SPClientField

## SYNOPSIS
Deletes the column.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientField [-ClientContext <ClientContext>] [-ClientObject] <Field>
```

### Name
```
Remove-SPClientField [-ClientContext <ClientContext>] [-ParentObject] <SPClientFieldParentParameter>
 -Name <String>
```

### Identity
```
Remove-SPClientField [-ClientContext <ClientContext>] [-ParentObject] <SPClientFieldParentParameter>
 -Identity <Guid>
```

## DESCRIPTION
The Remove-SPClientField function removes the column from the list.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientField $field
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientField $list -Identity "39ED73EB-FDD8-4870-91A5-EEE0ACB966B2"
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientField $list -Name "Custom Field"
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

### -ClientObject
Indicates the column to delete.

```yaml
Type: Field
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentObject
Indicates the list which the column is contained.

```yaml
Type: SPClientFieldParentParameter
Parameter Sets: Name, Identity
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the column GUID.

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

### -Name
Indicates the column title or internal name.

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

## INPUTS

### None or Microsoft.SharePoint.Client.Field or SPClient.SPClientFieldParentParameter

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientField.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientField.md)

