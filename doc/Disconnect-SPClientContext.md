# Disconnect-SPClientContext

## SYNOPSIS
Disconnects from SharePoint site.

## SYNTAX

```
Disconnect-SPClientContext [[-ClientContext] <ClientContext>]
```

## DESCRIPTION
The Disconnect-SPClientContext function disposes the current client context.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Disconnect-SPClientContext
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
Position: 1
Default value: $SPClient.ClientContext
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Disconnect-SPClientContext.md](https://github.com/karamem0/SPClient/blob/master/doc/Disconnect-SPClientContext.md)

