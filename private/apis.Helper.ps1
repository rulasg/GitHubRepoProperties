
$GH_HOST = 'https://api.github.com'

$APIs = @{
    SCHEMA = 'orgs/{owner}/properties/schema'
    REPO_PROPERTIES = 'repos/{owner}/{repo}/properties/values'
}

function Resolve-API{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,Position=0)]
        [ValidateSet('SCHEMA', 'REPO_PROPERTIES')]
        [string]$Name,
        [Parameter(Position=1)][string]$Owner,
        [Parameter(Position=2)][string]$Repo,
        [Parameter()][string]$GhHost
    )

    $uri = $APIs.$Name

    if([string]::IsNullOrWhiteSpace($GhHost)){ $GhHost = $GH_HOST }

    if(!$uri){
        throw "Error: API $Name not found"
    }

    $remote = Get-RemoteSplit

    if([string]::IsNullOrWhiteSpace($Owner)){ $Owner = $remote.Owner }
    if([string]::IsNullOrWhiteSpace($Repo)){ $Repo = $remote.Repo }
    if([string]::IsNullOrWhiteSpace($GhHost)){ $GhHost = $remote.GhHost }

    # Replace if exists
    if($Owner){ $uri = $uri.replace('{owner}', $Owner)}
    if($Repo){ $uri = $uri.replace('{repo}', $Repo)}

    $uri = "$GhHost/$uri"

    return $uri

} Export-ModuleMember -Function Resolve-API

function Get-RemoteSplit{
    [CmdletBinding()]
    param()

    $url = git remote get-url origin 2>$null

    if(!$url){
        return $null
    }

    $owner = $url | Split-Path -parent | Split-Path -leaf
    $repo = $url | Split-Path -leafbase
    $ghhost = $url | Split-Path -parent | Split-Path -parent | Split-Path -leaf

    $ret = [PSCustomObject]@{
        Owner = $owner
        Repo = $repo
        GhHost = $ghhost
    }

    return $ret

} Export-ModuleMember -Function Get-RemoteSplit