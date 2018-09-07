function Install-SqlServerExpress() {

    $productName = "SqlServerExpress"
    $url = "https://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLEXPR_x64_ENU.exe"
    $localPath = "$env:temp\$($productName).exe"
    $logFile = "C:\Program Files\Microsoft SQL Server\110\Setup Bootstrap\Log\Summary.txt"

    write-host Starting scripted install of $productName -ForegroundColor green
    write-host Downloading [$productName] from [$url]  -ForegroundColor gray
    write-host Saving $productName exe to $localPath -ForegroundColor gray

    # Download the file to temp directory
    ((New-Object System.Net.WebClient).DownloadFile($url, $localPath))
    
    $command = $localPath + ' /ACTION=install /QS /INSTANCENAME="sqlexpress" /IACCEPTSQLSERVERLICENSETERMS=1 /FEATURES=SQLENGINE /SQLSYSADMINACCOUNTS="HST\John.Moss"'
    
    write-host Executing command [$command] -ForegroundColor gray
    write-host "Review logs for installation result: [C:\Program Files\Microsoft SQL Server\110\Setup Bootstrap\Log\Summary.txt]" -ForegroundColor gray

    if (Test-Path $logFile) {
        mv $logFile $($logFile + "." + $(Get-Date).ToString("yyyyMMdd_HHmmss"))
    }

    $logMessage = $Null
    $serviceInstalled =$Null

    iex ($command)
   
    do {
    
       write-host Installing $productName... -ForegroundColor Gray

       # logFile will have a final result of Pass or False
       if (Test-Path $logFile) {
            $logMessage = (gc $logFile | select-string "Final result:") -eq $Null
       }

       # If logfile is Pass the service will be installed
       $serviceInstalled = (get-service | where { $_.Name -eq 'MSSQL$SQLEXPRESS' })

       start-sleep -s 10

    } while ( 
        ($serviceInstalled -eq $Null) -or ($logMessage -eq $Null)
    )
    
    write-host Installation script complete -ForegroundColor green
}
