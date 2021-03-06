
# Examples From: 
#   -  http://www.powershellmagazine.com/2014/03/12/get-started-with-pester-powershell-unit-testing-framework/
#   -  http://www.powershellmagazine.com/2014/03/27/testing-your-powershell-scripts-with-pester-assertions-and-more/
#   -  https://github.com/PowerShell/PowerShell/blob/master/docs/testing-guidelines/WritingPesterTests.md

# http://stackoverflow.com/questions/37926844/how-to-mock-a-call-to-an-exe-file-with-pester

Setup-Pester

cd E:\code\Scrapbook\Powershell\PesterDemo

# Create the new fixture...
New-Fixture -Path HelloWorldExample -Name Get-HelloWorld

# Run the tests
Invoke-Pester

function Setup-Pester {
    
    $ModulePath = "C:\Users\johnm\Documents\WindowsPowerShell\Modules"
    $PesterModulePath = "$ModulePath\Pester"
    
    if ((Test-Path $PesterModulePath) -eq $true) {

        write-host Deleting Existing -ForegroundColor Gray
        ri $PesterModulePath -Recurse -Force  
    }

    write-host Cloneing https://github.com/pester/Pester.git to [$ModulePath]... -ForegroundColor gray
    $current = pwd
    cd C:\Users\johnm\Documents\WindowsPowerShell\Modules
    git clone https://github.com/pester/Pester.git # Reports an error because git clone uses standard out
    write-host PLEASE NOTE: git reports standard output to stderr??? -ForegroundColor Green
    cd $current

    write-host Installing Module... -ForegroundColor Gray
    Import-Module Pester
    write-host Module Installed! -ForegroundColor Gray
    
    write-host Installed Commands: -ForegroundColor Green
    Get-Module -Name Pester | Select -ExpandProperty ExportedCommands

    write-host Setup Pester complete! -ForegroundColor Green
}

# Run to get user module path... C:\Users\johnm\Documents\WindowsPowerShell\Modules
function Get-UserModulePath {
 
    $Path = $env:PSModulePath -split ";" -match $env:USERNAME
 
    if (-not (Test-Path -Path $Path))
    {
        New-Item -Path $Path -ItemType Container | Out-Null
    }
    $Path
}