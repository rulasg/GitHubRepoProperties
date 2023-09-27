
$GH_HOST = 'https://api.github.com'

$APIs = @{
    SCHEMA = 'orgs/{owner}/properties/schema'
    REPO_PROPERTIES = 'repos/{owner}/{repo}/properties'
}

function Resolve-API{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][ValidateSet('SCHEMA', 'REPO_PROPERTIES')]
        [string]$Name,
        [Parameter()][string]$Owner,
        [Parameter()][string]$Repo,
        [Parameter()][switch]$WithHost
    )

    $uri = $APIs.$Name

    if(!$uri){
        throw "Error: API $Name not found"
    }

    if($Owner){ $uri = $uri.replace('{owner}', $Owner)}

    if($Repo){ $uri = $uri.replace('{repo}', $Repo)}

    if($WithHost){ $uri = "$($GH_HOST)/$uri" }

    return $uri

} Export-ModuleMember -Function Resolve-API