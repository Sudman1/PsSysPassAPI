<#
.SYNOPSIS
    Edit account's password
.DESCRIPTION
    Edit account's password
.NOTES
    Private function
.EXAMPLE

#>
function accounteditPass {
    [CmdletBinding(DefaultParameterSetName="ImplicitAuth")]
    param (
        # User's API token
        [Parameter(ParameterSetName="ExplicitAuth")]
        [string] $authToken,

        # API token's pass
        [Parameter(ParameterSetName="ExplicitAuth")]
        [string] $tokenPass,

        # Account's Id
        [Parameter(Mandatory)]
        [int] $id,

        # Account's password
        [Parameter(Mandatory)]
        [string] $pass,

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

        $payload = New-JsonRpcPayload -method "account/editPass" -params $PSBoundParameters

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

