﻿<#
.SYNOPSIS
    Create client
.DESCRIPTION
    Create client
.NOTES
    Private function
.EXAMPLE

#>
function clientcreate {
    [CmdletBinding(DefaultParameterSetName="ImplicitAuth")]
    param (
        # User's API token
        [Parameter(Mandatory, ParameterSetName="ExplicitAuth")]
        [string] $authToken,

        # Client's name
        [Parameter(Mandatory)]
        [string] $name,

        # Client's description
        [Parameter()]
        [string] $description,

        # Set client as global. It can be either 0 or 1
        [Parameter()]
        [int] $global
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

        $payload = New-JsonRpcPayload -method "client/create" -params $PSBoundParameters

        Write-Debug "Payload:`n$payload"

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"

        Write-Debug "Response:`n$($response | ConvertTo-Json)"

        if ($response.result.resultCode -eq 0) {
            $response.result.result
        } else {
            if ($response.error.code -eq -32603) {
                Write-Error "Could not perform search. Check API Authorizations for Account Search."
            }
            else {
                Write-Error "$($response.error.message): $($response.error.code)"
            }
        }
    }

    end {

    }
}

