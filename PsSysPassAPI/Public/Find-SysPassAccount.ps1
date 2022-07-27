<#
.SYNOPSIS
    Search for SysPass Accounts
.DESCRIPTION
    Search for SysPass Accounts
.NOTES

.EXAMPLE
    Find-SysPassAccount -Text "use"

    User1
    User2
    User3
    PurpleUser
    Fuse
    ...
#>
function Find-SysPassAccount {
    [CmdletBinding()]
    param (
        # Credential object containing the API token and token password to use for this request. If not specified, this cmdlet will look for the value set by Connect-SysPass.
        [pscredential] $AuthToken,

        # The regex text to search for. If null or empty, then all accounts will be returned
        [string] $Regex = ".*",

        # The number of results to display
        [int] $Count = [int]::MaxValue,

        # Category name to filter on.
        [string] $Category,

        # Client name to filter on
        [string] $Client,

        # Tag names to filter on
        [string[]] $Tag,

        # Operator for filtering. Defaults to 'or'
        [ValidateSet("or", "and")]
        $Operator = "or"
    )

    begin {

    }

    process {
        $params = @{}

        if ($PSBoundParameters.ContainsKey("AuthToken")) {
            $params["authToken"] = $AuthToken.UserName
        }

        if ($PSBoundParameters.ContainsKey("Category")) {
            $params["categoryId"] = (categorysearch -Text "^$Category`$").id
        }

        if ($PSBoundParameters.ContainsKey("Client")) {
            $params["clientId"] = (clientsearch -Text "^$Client`$").id
        }

        if ($PSBoundParameters.ContainsKey("Tag")) {
            $params["tagsId"] = foreach ($id in $Tag) {
                (tagsearch -Text "^$Tag`$").id
            }
        }

        accountsearch @params | Where-Object {$_.name -match $Regex} | Select-Object -First $Count -Property Id, Name, login, url, notes, CategoryName, ClientName
    }

    end {

    }
}
