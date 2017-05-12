

# Get modules that have been imported into the current session
Get-Module 

# Get installed modules and available modules
Get-Module -ListAvailable -Name sqlps

# load a module if not already loaded
if (-NOT (Get-Module -Name sqlps)) {
	
	write-host Loading sqlps module -ForegroundColor Gray
	import-module sqlps
}

# View installed modules
Get-Module 

# Find the path of installed modules
(Get-Module -ListAvailable ISE).path

#View commands for a module
Get-Command -Module PackageManagement

# https://blogs.msdn.microsoft.com/powershell/2016/09/29/powershellget-and-packagemanagement-in-powershell-gallery-and-github/

import-module    # Imports a module into the current session if it is already loaded
install-module   # Installs a module from a repository (run Get-PSRepository) and imports it to the current session
                 # N.B. If you run a module that is installed but not loaded, then it will automatically load!

# https://www.reddit.com/r/PowerShell/comments/5zr43t/importmodule_vs_installmodule/?st=j2inte6y&sh=653c5c14

#Show all commands in a module
Get-Command -Module PackageManagement
    
#There is a $profile variable that you can use to figure out where that location is for your machine

# The following command prints possible path locations:
$env:PSModulePath.Split(';') | % { start $_ }

C:\Users\d-jmoss\Documents\WindowsPowerShell\Modules\VSHelpers

C:\Users\d-jmoss\Documents\WindowsPowerShell\Modules;
C:\Program Files\WindowsPowerShell\Modules;
C:\Windows\system32\WindowsPowerShell\v1.0\Modules\;
C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\

# Using $dte to add a new class
#http://stevemichelotti.com/package-manager-console-for-more-than-managing-packages/

import-module Test-Module.psm1   # Needs to be in a folder called Test-Module see: http://stackoverflow.com/questions/6412921/powershell-import-module-doesnt-find-modules

Say-Hello

#List installed modules
Get-Module

# 1. Just call a powershell module .psm1 instead of ps1 and now you can import it
# 2. Import using 
#      import-module C:/path/to/module/Test-Module.psm1
# OR
#  - Create a folder called Test-Module and put Test-Module.psm1 into it.
#  - Call "$env:PSModulePath" to see the modules and then move this folder into one of these, e.g:
#     C:\Program Files\WindowsPowerShell\Modules\Test-Module\Test-Module.psm1
#  - now you can call "Import-Module Test-Module.ps1" it will be on the command line



function Parse-CsprojRefs() {
    Process {
        [xml] $axml= Get-Content $_.FullName
        $ns = new-object Xml.XmlNamespaceManager $axml.NameTable
        $ns.AddNamespace("d", "http://schemas.microsoft.com/developer/msbuild/2003")
        $nodes = $axml.SelectNodes( "/d:Project/d:ItemGroup/d:Reference", $ns)
    
        foreach ($node in $nodes) {
            $object = New-Object –TypeName PSObject
            $object | Add-Member -MemberType NoteProperty –Name File –Value $_.Name
            $object | Add-Member –MemberType NoteProperty –Name Name –Value $node.Include
            $object | Add-Member –MemberType NoteProperty –Name Path –Value $node.HintPath
         
            $object
        }
    }
} 

function Get-CsprojRefs() {
    Process {        
        gci $src -Recurse -Filter *.csproj |        Parse-CsprojRefs 
    }

}

New-Alias gra Get-CsprojRefs 

New-Alias grl Get-CsprojRefs | Where-Object {  $_.Path -ne $null -and $_.Path.StartsWith("..\..\lib") }

New-Alias grp Get-CsprojRefs | Where-Object {  $_.Path -ne $null -and $_.Path.StartsWith("..\packages") }


gci $src -Recurse -Filter *.csproj |
    Select-Csproj-Refs |
    Where-Object {  $_.Path -ne $null -and $_.Path.StartsWith("..\..\lib") }  | 
    Group-Object File |   
    Measure-Object -Property Count -Sum |
    Format-Table Sum  -AutoSize
