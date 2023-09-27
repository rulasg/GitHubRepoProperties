
function Get-RepoPropertiesShema{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Owner
    )

    # $command = "orgs/{0}/properties/schema" -f $Owner
    $command = Resolve-API -Name SCHEMA -Owner $Owner -WithHost

    $ret = gh api $command

    if(!$?){
        throw "Error: $ret"
    }

    return $ret | ConvertFrom-Json

} Export-ModuleMember -Function Get-RepoPropertiesShema

function Add-RepoPropertiesSchema{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$Owner,
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][string]$Description,
        [Parameter()][string]$AllowedValues
    )

    $token = Get-Token

    # $uri = "$($GH_HOST)/$($APIs.SCHEMA)" -f $Owner
    $uri = Resolve-API -Name SCHEMA -Owner $Owner -WithHost

    $body_String = @"
[
    {
        "property_name": "$Name",
        "description": "$Description",
        "value_type": "string"
    }
]
"@

    $body_SetValues = @"
[
    {
        "property_name": "$Name",
        "description": "$Description",
        "value_type": "single_select",
        "allowed_values": $AllowedValues
    }
]
"@

    $body = $AllowedValues ? $body_SetValues : $body_String

    try {
        $result = Invoke-RestMethod -Uri $uri -Authentication Bearer -Token $token -Method PATCH -Body $body
    }
    catch {
        $errorMessage =  ($_.ErrorDetails.Message | ConvertFrom-Json ).message
        Write-Error -Message "Failed to set repo schema`n$($errorMessage)"
        return $null
    }

    return $result

} Export-ModuleMember -Function Add-RepoPropertiesSchema

