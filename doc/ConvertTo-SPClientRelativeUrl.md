# ConvertTo-SPClientRelativeUrl

## SYNOPSIS
Makes a relative url.

## SYNTAX

```
ConvertTo-SPClientRelativeUrl [-ClientContext <ClientContext>] [-Url] <String>
```

## DESCRIPTION
The ConvertTo-SPClientRelativeUrl function converts a server absolute url to a server relative url.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
ConvertTo-SPClientRelativeUrl "https://example.sharepoint.com/path/to/list"
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

[https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientRelativeUrl.md](https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientRelativeUrl.md)

