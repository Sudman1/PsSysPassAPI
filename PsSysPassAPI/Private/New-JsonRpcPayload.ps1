<#
.SYNOPSIS
    Create a new JSON RPC v2 payload
.DESCRIPTION
    Create a new JSON RPC v2 payload
.NOTES
    Private Function

.EXAMPLE
    $payload = New-JsonRpcPayload
    $payload.
#>

function New-JsonRpcPayload {
    [CmdletBinding()]
    param (
        [string] $method = "undefined",
        [hashtable] $params,
        [int] $id = 1
    )

    begin {

    }

    process {
        $obj = [ordered] @{
            "jsonrpc" = "2.0"
            "method" = $method
            "params" = $params
            "id" = $id
        }
        $obj | ConvertTo-Json
    }

    end {

    }
}
