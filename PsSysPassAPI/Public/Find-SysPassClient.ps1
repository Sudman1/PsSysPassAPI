<#
.SYNOPSIS
    Search for SysPass Clients
.DESCRIPTION
    Search for SysPass Clients
.NOTES

.EXAMPLE
    Find-SysPassCient

    id name   description  hash isGlobal
    -- ----   -----------  ---- --------
    1 Client                          0
    2 CSSD   Service Desk             0
.EXAMPLE
    Find-SysPassCient -Regex "^C.*"

    id name   description  hash isGlobal
    -- ----   -----------  ---- --------
    1 Client                          0
    2 CSSD   Service Desk             0
#>
function Find-SysPassClient {
    [CmdletBinding()]
    param (
        # Credential object containing the API token and token password to use for this request. If not specified, this cmdlet will look for the value set by Connect-SysPass.
        [pscredential] $AuthToken,

        # The regex text to search for. If null or empty, then all accounts will be returned
        [string] $Regex = ".*",

        # The number of results to display
        [int] $Count = [int]::MaxValue
    )

    begin {

    }

    process {
        $params = @{}

        if ($PSBoundParameters.ContainsKey("AuthToken")) {
            $params["authToken"] = $AuthToken.UserName
        }

        clientsearch @params | Where-Object {$_.name -match $Regex} | Select-Object -First $Count
    }

    end {

    }
}
