

# E:\Scripts\start-console.bat - "C:\Program Files\ConEmu\ConEmu64.exe" /config "shell" /dir "c:\" /cmd powershell -noexit -new_console:a
#  -> https://blogs.technet.microsoft.com/heyscriptingguy/2012/05/21/understanding-the-six-powershell-profiles/
# Show Profiles: 
#  -> $PROFILE | Format-List *

# This was already here!
Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'

function Show-ProfilesLocation () {
    $PROFILE | Format-List * -Force
}

function Show-ModulesLocation () {
	$env:PSModulePath.Split(';') 
}

INFO "Loading profile..." 
INFO "Setting prompt..."

function prompt { "[" + $Env:username +  "] -> " }

. E:\Code\Scrapbook\Powershell\Cmds-ServiceHelpers.ps1

. E:\Code\Scrapbook\Powershell\Cmds-WebsiteHelpers.ps1

# For windows shell: https://github.com/lzybkr/PSReadLine
# Install with PowershellGalleryGet
import-module PSReadLine

# http://powertab.codeplex.com/
# Install locally
import-module E:\temp\PowerTab\PowerTab.psm1

CLEAR
