# Convert-SPClientField

## SYNOPSIS
Converts the column to its derived type.

## SYNTAX

```
Convert-SPClientField [-ClientContext <ClientContext>] [[-Field] <Field>]
```

## DESCRIPTION
The Convert-SPClientField function converts the column to its derived type.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Convert-SPClientField $field
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

### -Field
Indicates the column.

```yaml
Type: Field
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.Field

## OUTPUTS

### Derived type of Microsoft.SharePoint.Client.Field

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Convert-SPClientField.md](https://github.com/karamem0/SPClient/blob/master/doc/Convert-SPClientField.md)

