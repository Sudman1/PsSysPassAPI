<#
.SYNOPSIS
    Search for accounts
.DESCRIPTION
    Search for accounts
.NOTES
    Private function
.EXAMPLE

#>
function accountsearch {
    [CmdletBinding()]
    param (
        # User's API token
        [Parameter()]
        [string] $authToken,

        # Text to search for
        [Parameter()]
        [string] $text,

        # Number of results to display
        [Parameter()]
        [int] $count,

        # Category's Id for filtering
        [Parameter()]
        [int] $categoryId,

        # Client's Id for filtering
        [Parameter()]
        [int] $clientId,

        # Tags' Id for filtering
        [Parameter()]
        [array] $tagsId,

        # Operator used for filtering. It can be either 'or' or 'and'
        [Parameter()]
        [string] $op
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "account/search" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object id, name, login, url, notes, categoryName, clientName
        }
    }

    end {

    }
}

