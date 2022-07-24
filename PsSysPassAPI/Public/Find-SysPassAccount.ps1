function Find-SysPassAccount {
    [CmdletBinding()]
    param (
        # Credential object containing the API token and token password to use for this request. If not specified, this cmdlet will look for the value set by Connect-SysPass.
        [pscredential] $AuthToken,

        # The Text to search for. If null or empty, then all accounts will be returned
        [string] $Text,

        # The number of results to display
        [int] $Count,

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

    }

    end {

    }
}
