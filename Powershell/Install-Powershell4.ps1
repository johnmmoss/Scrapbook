
# Note that theres a bug x86 never runs :(

function Install-Powershell4() {

    Param(
        $64Bit = $true
    )

    $currentPsVersion = (get-host).Version.Major;

    if ((get-host).Version.Major -ge 4) {
        write-host Powershell version $currentPsVersion is already installed -ForegroundColor Red
        return;
    }

    $ps4DownloadUrl = "http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu"

    if ($64Bit -eq $false) {
        $ps4DownloadUrl = "https://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x86-MultiPkg.msu"
    }
    
    $ps4LocalPath = "$env:temp\ps4.msu"

    write-host Starting scripted install of Powershell 4.0 -ForegroundColor green
    write-host Downloading Powershell 4.0 from $ps4DownloadUrl  -ForegroundColor gray
    write-host Saving Powershell 4.0 to $ps4LocalPath -ForegroundColor gray

     # Download an image using DownloadFile method
     ((New-Object System.Net.WebClient).DownloadFile($ps4DownloadUrl, $ps4LocalPath))
 
    $wusaPath = "$env:windir\System32\wusa.exe"
    write-host Windows Update exe path: $wusaPath -ForegroundColor gray
 
    $command = "$wusaPath $ps4LocalPath /quiet /norestart"

    write-host Executing command [$command]

    iex ($command)
}
