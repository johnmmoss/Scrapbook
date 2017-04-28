$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Install-Pester" {
    #
    # GLOBAL MOCKS
    #
    Mock Write-Host        { }    # Override Write-Host so that messages arent printed during test run
    Mock Invoke-Expression { }
    Mock Get-Module        { }
    Mock Import-Module     { }
    #
    # Test Directories
    #
    mkdir TestDrive:\Modules 
    mkdir TestDrive:\Modules\Pester
   
    Context "First removes existing Pester install "{
        It "by deleting Pester folder" {
            
            (Test-Path TestDrive:\Modules\Pester) | Should be $true

            Install-Pester -ModulePath TestDrive:\Modules  
            
            (Test-Path TestDrive:\Modules\Pester) | Should be $false
        }
    }

    Context "Then clones from git " {
        
        Mock Get-Location {  }

        It "first changes dir to modules dir " {

            Mock Set-Location {  }   -ParameterFilter { $Path -eq 'TestDrive:\Modules' }

            Install-Pester -ModulePath TestDrive:\Modules  

            Assert-MockCalled Set-Location 
        }

        It "then calls git.exe and clones to modules dir " {

            Install-Pester -ModulePath TestDrive:\Modules  

            Assert-MockCalled Invoke-Expression
        }

        It "finishes by reverting the dir back " {

            Mock Set-Location {  }   -ParameterFilter { $Path -eq $here }

            Install-Pester -ModulePath TestDrive:\Modules  

            Assert-MockCalled Set-Location
        }
    }

    Context "Finishes by" {

        It "importing the module" {
            
            Install-Pester -ModulePath TestDrive:\Modules  

            Assert-MockCalled Import-Module
        }

        It "then lists the available commands" {

            Install-Pester -ModulePath TestDrive:\Modules  

            Assert-MockCalled Get-Module
        }
    }
}
