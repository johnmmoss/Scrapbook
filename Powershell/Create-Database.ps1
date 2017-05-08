#Create-Database -DBName "Customer"

# Note leaves the command line at "PS SQLSERVER:"

function Create-Database {
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
    $db = New-Object Microsoft.SqlServer.Management.Smo.Database($srv, $DBName)
    $db.Create()

    write-host Database [$DBName] Created on [$ServerName] -ForegroundColor green
}
