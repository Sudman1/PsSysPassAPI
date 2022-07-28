<#
.SYNOPSIS
    Edit account
.DESCRIPTION
    Edit account
.NOTES
    Private function
.EXAMPLE

#>
function accountedit {
    [CmdletBinding(DefaultParameterSetName="ImplicitAuth")]
    param (
        # User's API token
        [Parameter(Mandatory, ParameterSetName="ExplicitAuth")]
        [string] $authToken,

        # API token's pass
        [Parameter(Mandatory, ParameterSetName="ExplicitAuth")]
        [string] $tokenPass,

        # Account's Id
        [Parameter(Mandatory)]
        [int] $id,

        # Account's name
        [Parameter()]
        [string] $name,

        # Account's category Id
        [Parameter()]
        [int] $categoryId,

        # Account's client Id
        [Parameter()]
        [int] $clientId,

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

        $commonParameters = "Debug,WarningAction,ErrorVariable,InformationVariable,OutBuffer,Verbose,ErrorAction,InformationAction,WarningVariable,OutVariable,PipelineVariable" -split ","

        foreach ($commonParameter in $commonParameters) {
            if ($PSBoundParameters.ContainsKey($commonParameter)) {
                $PSBoundParameters.Remove($commonParameter)
            }
        }

        if ($PSCmdlet.ParameterSetName -eq "ImplicitAuth") {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "account/edit" -params $PSBoundParameters

        Write-Debug "Payload:`n$payload"

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"

        Write-Debug "Response:`n$($response | ConvertTo-Json)"

        if ($response.result.resultCode -eq 0) {
            $response.result.result
        } else {
            $response.error
        }
    }

    end {

    }
}

