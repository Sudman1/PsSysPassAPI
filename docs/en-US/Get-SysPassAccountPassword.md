---
external help file: PsSysPassAPI-help.xml
Module Name: PsSysPassAPI
online version:
schema: 2.0.0
---

# Get-SysPassAccountPassword

## SYNOPSIS
Search for SysPass Accounts

## SYNTAX

```
Get-SysPassAccountPassword [-Id] <Int32> [-AuthToken <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Search for SysPass Accounts

## EXAMPLES

### EXAMPLE 1
```
Find-SysPassAccount -Text "use"
```

User1
User2
User3
PurpleUser
Fuse
...

## PARAMETERS

### -Id
The regex text to search for. If null or empty, then all accounts will be returned

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: AccountId

Required: True
Position: 1
Default value: .*
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -AuthToken
Credential object containing the API token and token password to use for this request.
If not specified, this cmdlet will look for the value set by Connect-SysPass.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
