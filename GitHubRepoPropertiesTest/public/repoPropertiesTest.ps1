
function GitHubRepoPropertiesTest_RepoProperties_Get{
    
    # $result = Get-RepoProperties -Owner "SolidifyDemo" -Repo "rulasg-kk-1"
    
    Set-Location '/Users/rulasg/code/rulasg-kk-1'
    Get-RepoProperties

    Assert-NotImplemented
}

function GitHubRepoPropertiesTest_RepoProperties_Set{

    # Assert-NotImplemented
    
    # $result = Set-RepoProperties -Owner "SolidifyDemo" -Repo "rulasg-kk-1" -Property Department -Value "1234"
    $result = Set-RepoProperties -Owner "SolidifyDemo" -Repo "bit21" -Property 'kk' -Value "1234"
    Assert-IsNull -Object $result
    
    $result = Set-RepoProperties -Owner "SolidifyDemo" -Repo "rulasg-kk-1" -Property CostCenter -Value "1234"
    Assert-AreEqual -Expected "1234" -Presented $result.CostCenter

}