
set-alias get Invoke-RestMethod

# Get all project definitions
$all = GET https://tfsserver:8081/DefaultCollection/project1/_apis/build/definitions?api-version=2.0 -UseDefaultCredentials 
$all.value | % { write-host $_.name  $_.Id }

# Update the trigger path filter
# Note, will work if UseWorkSpaceMappings is false
$result = GET https://tfsserver:8081/DefaultCollection/project1/_apis/build/definitions/110?api-version=2.0 -UseDefaultCredentials
$result.triggers[1].pathFilters = $result.triggers[1].pathFilters += "-$/Path/to/filter"
$body = ConvertTo-Json $result -Compress -Depth 4
Invoke-RestMethod -URI https://tfsserver:8081/DefaultCollection/project1/_apis/build/definitions/110?api-version=2.0 -Body $body -Method put -ContentType "application/json"  -UseDefaultCredentials


# To update workspace mappings...
$result = GET https://tfsserver:8081/DefaultCollection/project1/_apis/build/definitions/110?api-version=2.0 -UseDefaultCredentials
$new = New-Mapping "$/project1/Application/MySite1" "\Application\MySite1"
# tfvcMapping is not properly formed (???) hence the gymnasitcs
$obj = ConvertFrom-Json $result.repository.properties.tfvcMapping 
$obj.mappings = $obj.mappings += @( $new )
$result.repository.properties.tfvcMapping = ConvertTo-Json $obj -Compress
$body = ConvertTo-Json $result -Compress -Depth 4
Invoke-RestMethod -URI https://tfsserver:8081/DefaultCollection/project1/_apis/build/definitions/110?api-version=2.0 -Body $body -Method put -ContentType "application/json"  -UseDefaultCredentials


function New-Mapping {
    Param($serverPath,  $localPath, $type = "cloak")

    $new = New-Object –TypeName PSObject
    $new | Add-Member –MemberType NoteProperty –Name serverPath –Value $serverPath
    $new | Add-Member –MemberType NoteProperty –Name localPath –Value $localPath
    $new | Add-Member -MemberType NoteProperty –Name mappingType –Value $type

    $new
}
