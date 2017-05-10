function Kill-Database {
    Param (
        $DBName = $null,
        $ServerName = "(local)"
    )

    if ($DBName -eq $null) {
        
        write-host Please provide a database name -ForegroundColor Red
        return
    }

    if (-NOT (Get-Module -Name sqlps)) {
        
        write-host Loading sqlps module -ForegroundColor Gray
        import-module sqlps
    }

    $srv = new-Object Microsoft.SqlServer.Management.Smo.Server($ServerName)    
    
    if($srv.Databases[$DBName]) {
        
        # https://msdn.microsoft.com/en-us/library/microsoft.sqlserver.management.smo.server.killdatabase.aspx
        $srv.KillDatabase($DBName)

        write-host Database [$DBName] KILLED on [$ServerName] -ForegroundColor green

    } else {

        write-host Database [$DBName] does not exist on [$ServerName] -ForegroundColor red
    }
}
