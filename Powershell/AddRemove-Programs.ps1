# View all installed programs
 Get-WmiObject -Class Win32_Product
 
 # Filter above down
  Get-WmiObject -Class Win32_Product | 
    where { $_.name -match "Microsoft SQL Server"}
    
# Uninstall all programs that start match a string    
 Get-WmiObject -Class Win32_Product | 
    where { $_.name -match "Microsoft SQL Server"} | foreach {
        
        write-host Uninstalling $_.name
        $_.UnInstall()
    }
    
