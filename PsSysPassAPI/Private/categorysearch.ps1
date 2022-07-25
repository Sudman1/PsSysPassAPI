<#
.SYNOPSIS
    Search for categories
.DESCRIPTION
    Search for categories
.NOTES
    Private function
.EXAMPLE

#>
function categorysearch {
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

        $payload = New-JsonRpcPayload -method "category/search" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}

