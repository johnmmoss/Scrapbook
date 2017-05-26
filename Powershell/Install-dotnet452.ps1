function install-dotnet452 {

    # TODO Check current installed versions!
    
    $dotnet452Url = "https://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe"
    $dotnet452LocalPath = "$env:temp\dotnet452.exe"
    
    write-host Starting scripted install of dotnet452 -ForegroundColor green
    write-host Downloading dotnet452 from $dotnet452Url
    write-host Saving dotnet452 to $dotnet452LocalPath
    
    ((New-Object System.Net.WebClient).DownloadFile($dotnet452Url, $dotnet452LocalPath))
    
    iex "$dotnet452LocalPath  /q /norestart"
    
    do {
    
        write-host Installing dotnet452...  -ForegroundColor Gray

        start-sleep -s 10

    } while ((get-process | where { $_.ProcessName -eq "dotnet452" }) -ne $Null)

    write-host Installation script complete -ForegroundColor green
}
