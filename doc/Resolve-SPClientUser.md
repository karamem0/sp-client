# Resolve-SPClientUser

## SYNOPSIS
Resolves login name to user.

## SYNTAX

```
Resolve-SPClientUser [[-ClientContext] <ClientContext>] [-Name] <String>
```

## DESCRIPTION
The Resolve-SPClientUser function checks whether the specified login name belongs to a valid user.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Resolve-SPClientUser "i:0#.f|membership|admin@example.com"
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

### -Name
Indicates login name or E-mail address.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### Microsoft.SharePoint.Client.User

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Resolve-SPClientUser.md](https://github.com/karamem0/SPClient/blob/master/doc/Resolve-SPClientUser.md)

