<#
.SYNOPSIS
    Create account
.DESCRIPTION
    Create account
.NOTES
    Private function
.EXAMPLE

#>
function accountcreate {
    [CmdletBinding()]
    param (
        # User's API token
        [Parameter()]
        [string] $authToken,

        # API token's pass
        [Parameter(Mandatory)]
        [string] $tokenPass,

        # Account's name
        [Parameter(Mandatory)]
        [string] $name,

        # Account's category Id
        [Parameter(Mandatory)]
        [int] $categoryId,

        # Account's client Id
        [Parameter(Mandatory)]
        [int] $clientId,

        # Account's password
        [Parameter(Mandatory)]
        [string] $pass,

        # Account's tags Id
        [Parameter()]
        [array] $tagsId,

        # Account's user group Id
        [Parameter()]
        [int] $userGroupId,

        # Account's parent Id
        [Parameter()]
        [int] $parentId,

        # Account's login
        [Parameter()]
        [string] $login,

        # Account's access URL or IP
        [Parameter()]
        [string] $url,

        # Account's notes
        [Parameter()]
        [string] $notes,

        # Set account as private. It can be either 0 or 1
        [Parameter()]
        [int] $private,

        # Set account as private for group. It can be either 0 or 1
        [Parameter()]
        [int] $privateGroup,

        # Expire date in UNIX timestamp format
        [Parameter()]
        [int] $expireDate
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "account/create" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}

