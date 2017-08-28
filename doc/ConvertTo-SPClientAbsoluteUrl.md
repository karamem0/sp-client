# ConvertTo-SPClientAbsoluteUrl

## SYNOPSIS
Makes a absolute url.

## SYNTAX

```
ConvertTo-SPClientAbsoluteUrl [-ClientContext <ClientContext>] [-Url] <String>
```

## DESCRIPTION
The ConvertTo-SPClientAbsoluteUrl function converts a server relative url to a server absolute url.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
ConvertTo-SPClientAbsoluteUrl "/path/to/list"
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

### -Url
Indicates the url.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### None or System.String

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientAbsoluteUrl.md](https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientAbsoluteUrl.md)

