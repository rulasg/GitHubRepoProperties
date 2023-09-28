
function Get-RepoPropertiesShema{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,Position=0)]
        [string]$Owner
    )

    $command = "orgs/{0}/properties/schema" -f $Owner

    $ret = gh api $command

    if(!$?){
        throw "Error: $ret"
    }

    return $ret | ConvertFrom-Json

} Export-ModuleMember -Function Get-RepoPropertiesShema
