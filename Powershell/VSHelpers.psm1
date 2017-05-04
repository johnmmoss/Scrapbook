# Set prompt 
function prompt { "[" + $Env:username +  "] -> " }
 
 
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

function Get-Refs-Lib() {
    Get-CsprojRefs | Where-Object {  $_.Path -ne $null -and $_.Path.StartsWith("..\..\lib") }
}

function Get-Refs-Package() {
    Get-CsprojRefs | Where-Object {  $_.Path -ne $null -and $_.Path.StartsWith("..\packages") }
}


function Get-RefsPath() {
    Param([string]$Name="System.Web")
    
    (Get-Project -all).Object.References  | Where-Object { $_.Name -eq $Name } | Select-Object Identity, Path
}

function Test-Dte {

    $sln = [EnvDTE.Solution]$dte.Solution;

     $sln.Projects

    write-host $sln.Count

}

# Get refs All
New-Alias gra Get-CsprojRefs 

#Get refs lib
New-Alias grl Get-Refs-Lib

#Get refs package
New-Alias grp Get-Refs-Package

Export-ModuleMember -Function Get-CsprojRefs
Export-ModuleMember -Function Get-Refs-Lib
Export-ModuleMember -Function Get-Refs-Package

Export-ModuleMember -Function Test-Dte
Export-ModuleMember -Function Get-RefsPath

Export-ModuleMember -Alias gra
Export-ModuleMember -Alias grl
Export-ModuleMember -Alias grp
