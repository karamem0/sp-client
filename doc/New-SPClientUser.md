# New-SPClientUser

## SYNOPSIS
Creates a new user.

## SYNTAX

```
New-SPClientUser [[-ClientContext] <ClientContext>] [-Name] <String> [[-Title] <String>] [[-Email] <String>]
 [[-IsSiteAdmin] <Boolean>] [[-Retrievals] <String>]
```

## DESCRIPTION
The New-SPClientUser function adds a new user to the site.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientUser -Name "i:0#.f|membership|john@example.com"
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
Indicates the login name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: LoginName

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Indicates the display name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Email
Indicates the E-mail.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsSiteAdmin
Indicates a value whether the user is a site collection administrator.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Retrievals
Indicates the data retrieval expression.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

