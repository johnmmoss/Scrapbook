function Install-Pester {
    Param
    (
        $ModulePath = "C:\Users\johnm\Documents\WindowsPowerShell\Modules",
        $PesterRepoUrl = "https://github.com/pester/Pester.git"
    )
    $PesterModulePath = "$ModulePath\Pester"
    if ((Test-Path $PesterModulePath) -eq $true) {

        Write-Host Deleting existing folder [$PesterModulePath] -ForegroundColor Gray
        Remove-Item $PesterModulePath -Recurse -Force  
    }

    $current = Get-Location
    Set-Location $ModulePath

    Write-Host Cloneing https://github.com/pester/Pester.git to [$ModulePath]... -ForegroundColor gray
    $exp = '& "C:\Program Files\Git\bin\git.exe" clone "https://github.com/pester/Pester.git"'
    Invoke-Expression -Command $exp
    Write-Host PLEASE NOTE: git reports standard output to stderr??? -ForegroundColor Green

    Set-Location $current

    Write-Host Installing Module... -ForegroundColor Gray
    Import-Module -Name Pester
    Write-Host Module Installed! -ForegroundColor Gray
    
    Write-Host Installed Commands: -ForegroundColor Green
    Get-Module -Name Pester | Select -ExpandProperty ExportedCommands

    Write-Host Setup Pester complete! -ForegroundColor Green
}