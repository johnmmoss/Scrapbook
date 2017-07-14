# http://geekswithblogs.net/QuandaryPhase/archive/2013/02/24/create-iis-app-pool-and-site-with-windows-powershell.aspx
# https://www.iis.net/configreference/system.applicationhost/applicationpools/add/processmodel


# Creates a new website with app pool of the same name for .net application
New-Website -Name "Website1" -Port 8080
New-Website -Name "Website2" -Port 8081 -IsSsl True

# New-Website

Import-Module WebAdministration

function New-Website() {

    Param(
        $Name = $null,
        $Port = $null,
        $WebRoot = "E:\Websites",
        $IsSsl = $false
    )

    if ($Name -eq $null) {

        write-host Please provide the name of the site to create
        return
    }

    if ($Port -eq $null) {
        
        write-host Please provide the port for the site
        return
    }

    $iisAppPoolName = $name
    $iisAppPoolDotNetVersion = "v4.0"
    $iisAppName = $name
    $directoryPath = "$WebRoot\$name"
    $bindingInformation = ":" + $port + ":"           # "hostname:port:ipaddress"
    $protocol = "http"

    if($IsSsl) {
        $protocol = "https"
    }

    if((Test-Path $directoryPath ) -eq $false) {

        mkdir $directoryPath
        write-host Directory [$directoryPath] created... -ForegroundColor Gray
    }

    #navigate to the app pools root
    cd IIS:\AppPools\

    #check if the app pool exists
    if (!(Test-Path $iisAppPoolName -pathType container))
    {
        #create the app pool
        $appPool = New-Item $iisAppPoolName
        $appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $iisAppPoolDotNetVersion
        $appPool | Set-ItemProperty -Name "processModel.identityType" -value 4 # https://www.iis.net/configreference/system.applicationhost/applicationpools/add/processmodel
        $appPool | Set-ItemProperty -Name "enable32bitapponwin64" -value true 
        
        write-host Created AppPool: $iisAppPoolName -ForegroundColor green

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

    write-host Created Website: $iisAppPoolName -ForegroundColor green
}
