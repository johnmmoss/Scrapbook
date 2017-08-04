
# Show all sln files in the src root
#Get-Slns

# Show all projects for a given solution
#Get-SlnRefs "E:\Code\Website1.sln"

# Show all solutions that reference a given project
#Show-Refs ServiceLayer

# Show all references in a project
#Get-ProjRefs "E:\Code\Library\ServiceLayer\ServiceLayer.csproj"

# Show all solutions that use a particular project
#Show-ProjUsages ServiceLayer

$src_root = "E:\Code"

function Get-Slns() {
    gci -Path $src_root -Filter *.sln -Recurse | select Name, FullName
}

function Get-SlnRefs() {
    param($SlnPath = $null)
    
    if($SlnPath -eq $null) {
        write-error "Please provide a SlnName"
        return;            
    }
         
    $lines = select-string -Path $SlnPath -Pattern  "^Project.*"
    
    $lines | % {
    
        $pattern =  "Project.*=\s`"([^`"]*)`", `"([^`"]*)"

        if ([Regex]::IsMatch($_.Line, $pattern) ) {
        
            $matches = [Regex]::Matches($_.Line, $pattern)
        
            $name = $matches[0].Groups[1].Value
            $path = $matches[0].Groups[2].Value
            $fullPath = (Resolve-Path ((Split-path $SlnPath -Parent) + "\" + $path)).Path

            $object = New-Object –TypeName PSObject
            $object | Add-Member -MemberType NoteProperty –Name Name –Value $name
            $object | Add-Member –MemberType NoteProperty –Name Path –Value $path
            $object | Add-Member –MemberType NoteProperty –Name FullPath –Value $fullpath
         
            $object
        }
    }
}

function Get-ProjRefs() {
        Param($path)
        [xml] $axml= Get-Content $path
        $ns = new-object Xml.XmlNamespaceManager $axml.NameTable
        $ns.AddNamespace("d", "http://schemas.microsoft.com/developer/msbuild/2003")
        $nodes = $axml.SelectNodes( "/d:Project/d:ItemGroup/d:Reference", $ns)
    
        foreach ($node in $nodes) {
            $object = New-Object –TypeName PSObject
            $object | Add-Member -MemberType NoteProperty –Name File –Value (split-path $path -leaf)
            $object | Add-Member –MemberType NoteProperty –Name Name –Value $node.Include
            $object | Add-Member –MemberType NoteProperty –Name Path –Value $node.HintPath
         
            $object
        }
    
} 

function Show-ProjUsage() {
    Param($ProjectName = $null)

    if($ProjectName -eq $null) {
        write-error "Please provide the project name"
        return;
    }

    gci -Path $src_root -Filter *.sln -Recurse  |  % {
        $exists = (select-string "^Project.*`"$ProjectName`"" $_.FullName).Matches.Count

        if ($exists -gt 0) {
            write-host $_.FullName   -ForegroundColor green
        } else {
            write-host $_.FullName -ForegroundColor gray
        }
    }
}
