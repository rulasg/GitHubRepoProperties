
function GitHubRepoPropertiesTest_Schema_Get{

    Assert-NotImplemented

    # $result = Get-RepoPropertiesShema -Owner "SolidifyDemo"
} 

function GitHubRepoPropertiesTest_Schema_Add_TyeString{

    Assert-NotImplemented

    # $propName = "Test_$((New-Guid).Guid.Substring(0,8))"

    # $result = Add-RepoPropertiesSchema -Owner "SolidifyDemo" -Name $propName -Description "test description"
}

function GitHubRepoPropertiesTest_Add_TypeSingleSelect{

    # Assert-NotImplemented

    $propName = "Test_$((New-Guid).Guid.Substring(0,8))"

    $param = @{
        Owner = "SolidifyDemo"
        Name = $propName
        Description = "test description"
        AllowedValues = '["value1","value2","Value3"]'
    }
    
    $result = Add-RepoPropertiesSchema @param

    $resultProp= $result | Where-Object {$_.property_name -like $propName}

    Assert-AreEqual -Expected $param.Name -Presented $resultProp.property_name
    Assert-AreEqual -Expected $param.Description -Presented $resultProp.description
    Assert-AreEqual -Expected "single_select" -Presented $resultProp.value_type
    $presentedValues = $resultProp.allowed_values | ConvertTo-Json -Compress
    Assert-AreEqual -Expected $param.AllowedValues -Presented $presentedValues

}
