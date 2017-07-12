# Debug-SPClientObject

## SYNOPSIS
Dumps a client object.

## SYNTAX

```
Debug-SPClientObject [-InputObject] <ClientObject>
```

## DESCRIPTION
The Debug-SPClientObject function converts a client object to hashtable that contains loaded properties.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Debug-SPClientObject $object
```

## PARAMETERS

### -InputObject
Indicates the client object.

```yaml
Type: ClientObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.ClientObject

## OUTPUTS

### System.Collections.Generic.Dictionary`2[System.String,System.Object]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Debug-SPClientObject.md](https://github.com/karamem0/SPClient/blob/master/doc/Debug-SPClientObject.md)

