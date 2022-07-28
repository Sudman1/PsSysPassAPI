<#
.SYNOPSIS
    Search for SysPass Categories
.DESCRIPTION
    Search for SysPass Categories
.NOTES

.EXAMPLE
    Find-SysPassCategory -Regex "c.*t"

    id name           description
    -- ----           -----------
    10 Action         Action Passwords
     2 Carrot         Orange things
    30 Cat            Animals
    15 Court
     1 Zero Count     Category with no results
    ...
#>
function Find-SysPassCategory {
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

        categorysearch @params | Where-Object {$_.name -match $Regex} | Select-Object -First $Count
    }

    end {

    }
}
