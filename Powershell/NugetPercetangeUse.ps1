
function Select-CsprojRefs() {

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

function Write-PercentageNuget() {

    Process {
        $srcPath = $_.FullName

        $total = (gci $srcPath -Filter *.csproj -Recurse | Select-CsprojRefs | Where-Object { $_.Path -ne $null } ).Count

        $nuget = (gci $srcPath -Filter *.csproj -Recurse | Select-CsprojRefs | Where-Object { $_.Path -ne $null -and $_.Path.StartsWith("..\package") } ).Count

        $percent = [convert]::ToInt32($nuget / $total * 100)

        write-host "$srcPath - $percent% ($nuget/$total)"
    }
}

gci D:\svn |   Write-PercentageNuget 