

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
write-host Loaded Parse-CsprojRefs... -ForegroundColor Gray



function Get-CsprojRefs() {
    Process {        
        gci $src -Recurse -Filter *.csproj |        Parse-CsprojRefs 
    }

}
write-host Loaded Get-CsprojRefs... -ForegroudColor gray


# Get refs All
New-Alias gra Get-CsprojRefs 

#Get refs lib
New-Alias grl Get-CsprojRefs | Where-Object {  $_.Path -ne $null -and $_.Path.StartsWith("..\..\lib") }

#Get regs package
New-Alias grp Get-CsprojRefs | Where-Object {  $_.Path -ne $null -and $_.Path.StartsWith("..\packages") }

write-host Set aliases gra grl grp ... -ForegroudColor gray

write-host thankyoucomeagain! ... -ForegroudColor gray