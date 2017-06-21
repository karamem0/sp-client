# Remove-SPClientUser

## SYNOPSIS
Deletes the user.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientUser [-ClientContext <ClientContext>] [-ClientObject] <User>
```

### Identity
```
Remove-SPClientUser [-ClientContext <ClientContext>] -Identity <Int32>
```

### Name
```
Remove-SPClientUser [-ClientContext <ClientContext>] -Name <String>
```

### Email
```
Remove-SPClientUser [-ClientContext <ClientContext>] -Email <String>
```

## DESCRIPTION
The Remove-SPClientUser function deletes the user from the site.
If the user could not be found, throws exception.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientUser $user
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientUser -Identity 7
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientUser -Name "i:0#.f|membership|admin@example.com"
```

### -------------------------- Example 4 --------------------------
```
Remove-SPClientUser -Email "admin@example.com"
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
Indicates the user to delete.

```yaml
Type: User
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the user ID.

```yaml
Type: Int32
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the user login name.

```yaml
Type: String
Parameter Sets: Name
Aliases: LoginName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Email
Indicates the user E-mail.

```yaml
Type: String
Parameter Sets: Email
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.User

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientUser.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientUser.md)

