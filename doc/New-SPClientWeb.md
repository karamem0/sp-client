# New-SPClientWeb

## SYNOPSIS
Creates a new subsite.

## SYNTAX

```
New-SPClientWeb [-ClientContext <ClientContext>] [-ParentObject] <SPClientWebParentPipeBind> -Url <String>
 [-Title <String>] [-Description <String>] [-Locale <String>] [-Template <SPClientWebTemplateIdentityPipeBind>]
 [-UniquePermissions] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientWeb function adds a new subsite to the site.

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

### -ParentObject
Indicates the site which a subsite to be created.

```yaml
Type: SPClientWebParentPipeBind
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
If not specified, uses default title of the site template.

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

### -Locale
Indicates the locale ID in which the language is used.
If not specified, uses the parent site language.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Language

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Template
Indicates the template name.

```yaml
Type: SPClientWebTemplateIdentityPipeBind
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UniquePermissions
If specified, the site uses unique permissions.

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

### -Retrieval
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

### None or SPClient.SPClientWebParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.Web

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientWeb.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientWeb.md)

