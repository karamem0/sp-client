# New-SPClientWeb

## SYNOPSIS
Creates a new web.

## SYNTAX

```
New-SPClientWeb [-ClientContext <ClientContext>] [-ParentWeb] <Web> -Url <String> [-Title <String>]
 [-Description <String>] [-Language <String>] [-Template <String>] [-UniquePermissions] [-Retrievals <String>]
```

## DESCRIPTION
The New-SPClientWeb function adds a new web to the site.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientWeb -Url "CustomWeb" -Title "Custom Web"
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

### -ParentWeb
Indicates the web which a web to be created.

```yaml
Type: Web
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Url
Indicates the url.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Indicates the title.
If not specified, uses default title of the web template.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Indicates the description.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language
Indicates the locale ID in which the language is used.
If not specified, uses
the parent web language.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Template
Indicates the template name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UniquePermissions
If specified, the web uses unique permissions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.Web

## OUTPUTS

### Microsoft.SharePoint.Client.Web

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientWeb.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientWeb.md)

