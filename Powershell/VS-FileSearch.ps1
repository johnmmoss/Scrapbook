
# Show all sln files in the src root
Show-Slns

# Show all projects for a given solution
Show-Csprojs "E:\Code\Website1.sln"

# Show all solutions that reference a given project
Show-Refs ServiceLayer

# Show all projects for all solutions
Show-Slns | % {
    write-host $_.Name -ForegroundColor Magenta

    Show-Csprojs $_.FullName | % {
        write-host --> $_.Name
    }
}

$src_root = "E:\Code"

function Show-Slns() {
    gci -Path $src_root -Filter *.sln -Recurse | select Name, FullName
}

function Show-Csprojs() {
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

function Show-Refs() {
    Param($ProjectName = $null)

    if($ProjectName -eq $null) {
        write-error "Please provide the project name"
        return;
    }

    gci -Path $src_root -Filter *.sln -Recurse  |  % {
        $hasServiceLayer = (select-string "^Project.*`"$ProjectName`"" $_.FullName).Matches.Count

        if ($hasServiceLayer -gt 0) {
            write-host $_.FullName   -ForegroundColor green
        } else {
            write-host $_.FullName -ForegroundColor gray
        }
    }
}
