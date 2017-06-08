# Connect-SPClientContext

## SYNOPSIS
Connects to SharePoint site.

## SYNTAX

### NetworkCredential
```
Connect-SPClientContext [-Network] -Url <String> [-Credential] <PSCredential> [-PassThru]
```

### NetworkPassword
```
Connect-SPClientContext [-Network] -Url <String> -UserName <String> -Password <SecureString> -Domain <String>
 [-PassThru]
```

### OnlineCredential
```
Connect-SPClientContext [-Online] -Url <String> [-Credential] <PSCredential> [-PassThru]
```

### OnlinePassword
```
Connect-SPClientContext [-Online] -Url <String> -UserName <String> -Password <SecureString> [-PassThru]
```

## DESCRIPTION
The Connect-SPClientContext function creates a new client context and sets to
current.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Connect-SPClientContext -Network -Url "https://example.com" -UserName "john" -Password (ConvertTo-SecureString -String "p@ssword" -AsPlainText -Force) -Domain "example.com"
```

### -------------------------- Example 2 --------------------------
```
Connect-SPClientContext -Online -Url "https://example.sharepoint.com" -Credential $credential
```

## PARAMETERS

### -Network
If specified, connects to SharePoint Server (On-premise).

```yaml
Type: SwitchParameter
Parameter Sets: NetworkCredential, NetworkPassword
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online
If specified, connects to SharePoint Online.

```yaml
Type: SwitchParameter
Parameter Sets: OnlineCredential, OnlinePassword
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
Indicates the site url.

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

### -UserName
Indicates the user name.

```yaml
Type: String
Parameter Sets: NetworkPassword, OnlinePassword
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Indicates the password.

```yaml
Type: SecureString
Parameter Sets: NetworkPassword, OnlinePassword
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
Indicates the domain.

```yaml
Type: String
Parameter Sets: NetworkPassword
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Indicates the credential.

```yaml
Type: PSCredential
Parameter Sets: NetworkCredential, OnlineCredential
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -PassThru
If specified, returns a client context.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

