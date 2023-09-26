
function Get-GhRepoPropertiesShema{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Owner
    )

    $command = "orgs/{0}/properties/schema" -f $Owner
    $ret = gh api $command

    return $ret

} Export-ModuleMember -Function Get-GhRepoPropertiesShema
