<#
.SYNOPSIS
    Create category
.DESCRIPTION
    Create category
.NOTES
    Private function
.EXAMPLE

#>
function categorycreate {
    [CmdletBinding()]
    param (
        # User's API token
        [Parameter()]
        [string] $authToken,

        # Category's name
        [Parameter(Mandatory)]
        [string] $name,

        # Category's description
        [Parameter()]
        [string] $description
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "category/create" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}

