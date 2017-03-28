
Import-Module WebAdministration


function Build-Sln() {

    # Build the solution, is this the right compiler version?
    invoke-expression("C:\Windows\Microsoft.Net\Framework\v4.0.30319\msbuild.exe D:\svn\WebSite\src\Web.sln /v:q")
}

function Remove-WebSite() {

    remove-item IIS:\AppPools\WebSite1 -Recurse
    remove-item IIS:\Sites\Website1 -Recurse

}

# http://geekswithblogs.net/QuandaryPhase/archive/2013/02/24/create-iis-app-pool-and-site-with-windows-powershell.aspx
# https://www.iis.net/configreference/system.applicationhost/applicationpools/add/processmodel

function Create-Website() {

    $iisAppPoolName = "AppPool1"
    $iisAppPoolDotNetVersion = "v4.0"
    $iisAppName = "Website1"
    $directoryPath = "D:\git\WebSite\src"
    $port = "49006"
    $bindingInformation = ":" + $port + ":"

    #navigate to the app pools root
    cd IIS:\AppPools\

    #check if the app pool exists
    if (!(Test-Path $iisAppPoolName -pathType container))
    {
        #create the app pool
        $appPool = New-Item $iisAppPoolName
        $appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $iisAppPoolDotNetVersion
        $appPool | Set-ItemProperty -Name "processModel.identityType" -value 0

        write-host Created AppPool ClinicalAudit -ForegroundColor green

    } else {
        
        write-host Already exists: AppPool $iisAppPoolName -ForegroundColor red
    }

    #navigate to the sites root
    cd IIS:\Sites\

    #check if the site exists
    if (Test-Path $iisAppName -pathType container)
    {
        write-host Already exists: WebSite $iisAppName -ForegroundColor red

        return
    }

    #create the site
    $iisApp = New-Item $iisAppName -bindings @{protocol="http";bindingInformation=$bindingInformation} -physicalPath $directoryPath
    $iisApp | Set-ItemProperty -Name "applicationPool" -Value $iisAppPoolName   

    write-host Created AppPool $iisAppPoolName -ForegroundColor green
}


New-WebApplication -Name "VirtualDirectory1" -Site 'Website1' -PhysicalPath "D:\svn\VirrtualDirectory1\src\Web1" -ApplicationPool "AppPool1" 