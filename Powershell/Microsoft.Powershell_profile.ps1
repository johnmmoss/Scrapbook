

# E:\Scripts\start-console.bat - "C:\Program Files\ConEmu\ConEmu64.exe" /config "shell" /dir "c:\" /cmd powershell -noexit -new_console:a
#  -> https://blogs.technet.microsoft.com/heyscriptingguy/2012/05/21/understanding-the-six-powershell-profiles/
# Show Profiles: 
#  -> $PROFILE | Format-List *

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

function show-profiles () {
    $PROFILE | Format-List * -Force
}

INFO "Loading profile..." 
INFO "Setting prompt..."

function prompt { "[" + $Env:username +  "] -> " }

CLEAR



