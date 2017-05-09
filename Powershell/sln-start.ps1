function sln-tmg {

    if (CurrentUserIsAdmin) {
        write-host starting Zenith.Tmg.sln... -ForegroundColor Gray 
        start E:\Repos\MySolution\MySolution.sln
    } else {
        write-host Console not running in administrator mode! -ForegroundColor Red
    }
}


function CurrentUserIsAdmin() {
    return ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] “Administrator”)
}
