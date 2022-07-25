<#
.SYNOPSIS
    Search for clients
.DESCRIPTION
    Search for clients
.NOTES
    Private function
.EXAMPLE

#>
function clientsearch {
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
        [int] $count
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "client/search" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}

