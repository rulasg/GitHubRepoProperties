
function Get-RepoProperties{
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipelineByPropertyName)][string]$Owner,
        [parameter(ValueFromPipelineByPropertyName)][string]$Repo
    )

    # $command = "repos/{0}/{1}/properties" -f $Owner, $Repo
    $command = Resolve-API REPO_PROPERTIES $Owner $Repo

    $command | Write-Verbose

    $result = gh api $command

    # check the last execution
    if(!$?){
        Write-Error -Message "Failed to get repo properties"
        return $null
    }

    $ret = $result | ConvertFrom-Json
    
    return $ret.properties
    
} Export-ModuleMember -Function Get-RepoProperties


function Set-RepoProperties{
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipelineByPropertyName)][string]$Owner,
        [parameter(ValueFromPipelineByPropertyName)][string]$Repo,
        [parameter(Mandatory)][string]$Property,
        [parameter(Mandatory)][string]$Value
    )

    $token = Get-Token

    $remote = Get-RemoteSplit

    # if owner is null or whitespace, use the remote owner
    if([string]::IsNullOrWhiteSpace($Owner)){ $Owner = $remote.Owner }
    if([string]::IsNullOrWhiteSpace($Repo)){ $Repo = $remote.Repo }

    # $uri = 'https://api.github.com/repos/{0}/{1}/properties' -f $Owner, $Repo 
    $uri = Resolve-API REPO_PROPERTIES $Owner $Repo

    $body = @"
    {
        "properties": {
          "$Property": "$Value"
        }
    }
"@

    try {
        $result = Invoke-RestMethod -Uri $uri -Authentication Bearer -Token $token -Method PATCH -Body $body
    }
    catch {
        $errorMessage =  ($_.ErrorDetails.Message | ConvertFrom-Json ).message
        Write-Error -Message "Failed to set repo properties`n$($errorMessage)"
        return $null
    }

    $ret = [PSCustomObject]@{
        $Property = $result.properties.$Property
    }

    return $ret


} Export-ModuleMember -Function Set-RepoProperties