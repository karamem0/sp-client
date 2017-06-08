# Use-SPClientType

## SYNOPSIS
Loads SharePoint Client Components assemblies.

## SYNTAX

```
Use-SPClientType [[-LiteralPath] <String>]
```

## DESCRIPTION
The Use-SPClientType function loads SharePoint Client Components assemblies.
  - Microsoft.SharePoint.Client.dll
  - Microsoft.SharePoint.Client.Runtime.dll

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Use-SPClientType
```

### -------------------------- Example 2 --------------------------
```
Use-SPClientType -LiteralPath "C:\Users\John\Documents"
```

## PARAMETERS

### -LiteralPath
Indicates the path that locates SharePoint Client Components.
If not
specified, loads from the location below.
  - Current working directory
  - Global assembly cache (GAC)

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

