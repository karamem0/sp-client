# Remove-SPClientField

## SYNOPSIS
Deletes the field.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientField [-ClientContext <ClientContext>] [-ClientObject] <Field>
```

### Name
```
Remove-SPClientField [-ClientContext <ClientContext>] [-ParentList] <List> -Name <String>
```

### Identity
```
Remove-SPClientField [-ClientContext <ClientContext>] [-ParentList] <List> -Identity <Guid>
```

## DESCRIPTION
The Remove-SPClientField function deletes the field from the list.

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
Indicates the field to delete.

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

### -ParentList
Indicates the list which the field is contained.

```yaml
Type: List
Parameter Sets: Name, Identity
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the field GUID.

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
Indicates the field title or internal name.

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

## OUTPUTS

## NOTES

## RELATED LINKS

