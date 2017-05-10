
Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'

function DEBUG {
    Param(
        $Message = $null
    )

    if($Message -ne $null) {

        write-host $Message -ForegroundColor Gray
    }
}


function INFO {
    Param(
        $Message = $null
    )

    if($Message -ne $null) {

        write-host $Message -ForegroundColor Green
    }
}


function WARN {
    Param(
        $Message = $null
    )

    if($Message -ne $null) {

        write-host $Message -ForegroundColor Red
    }
}

DEBUG "Loading profile..." 

DEBUG "Setting prompt..."



function prompt { "[" + $Env:username +  "] -> " }



