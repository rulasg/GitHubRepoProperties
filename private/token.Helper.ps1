function Get-Token{
    [CmdletBinding()]

    $ret = $env:GH_TOKEN | ConvertTo-SecureString -AsPlainText

    return $ret
}