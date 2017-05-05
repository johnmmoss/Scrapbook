# Calls the git exe
# Wraps in Invoke-Expression for ease of Pester mocking
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
