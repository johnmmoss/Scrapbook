
$services = @{

    "Service1" = "Service1GitName";
    "Service2" = "Service2GitName";
    "Service3" = "Service3GitName"
    "Service4" = "Service4GitName";
}


$GIT_URL = "https://tfs-server-01.acme.co.uk/AcmeCollection/ACME/_git/"
$REPO_ROOT = "E:\Repos\"

foreach($service in $services.GetEnumerator()) 
{
    $serviceName = $service.Value
    $repoUrl = $GIT_URL + $serviceName
    $repoDir = $REPO_ROOT + $serviceName

    if((Test-Path $repoDir) -eq $false) {

        Write-Host  $service.Key: Cloneing $serviceName 
        write-host from $repoUrl -ForegroundColor Gray
        write-host to $repoDir -ForegroundColor Gray

        Git-Clone -Url $repoUrl -Source $repoDir

    } else {
        write-host $serviceName path already exists -ForegroundColor red
    }
}

function Git-Clone () {

    Param(
        $Url = $null,
        $Source = $null
    )

    if ($Url -eq $null ) {
        
        write-host Please provide the git repo to clone -ForegroundColor Red
        return
    }

     if ($Source -eq $null ) {
        
        write-host Please provide the directory to clone to -ForegroundColor Red
        return
    }
    $exp = '& "C:\Program Files\Git\bin\git.exe" clone "' +$Url+ '"' + $Source
    write-host running cmd $exp
    Invoke-Expression -Command $exp
    Write-Host Cloned $Url to $Source... -ForegroundColor green
    #Write-Host PLEASE NOTE: git reports standard output to stderr??? -ForegroundColor Green
}
