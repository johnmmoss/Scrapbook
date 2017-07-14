

    #
    # Pester stub test
    #
    
    # Function in Calc-Numbers.ps1
    function Calc-Numbers {

    }

    # Test in Calc-Numbers.test.ps1
    $here = Split-Path -Parent $MyInvocation.MyCommand.Path
    $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
    . "$here\$sut"

    Describe "Calc-Numbers" {
        It "does something useful" {
            $true | Should Be $false
        }
    }

    #
    #  Testing parameters
    #
    It "when parameter is null or empty" {
        
		(( Update-Stats ) 2>&1) -match "Please provide the param!" | should be $true
	}	
    
    #
    # Simple Mocks
    #
    Mock Remove-Item  { }
	
	It "cleans directory of files" {

		Clean-Directory

		Assert-MockCalled Remove-Item
	}

    #
    # Parameter filter mocks
    #
    Mock Copy-Item { } -ParameterFilter { $Recurse -eq $true; $Force -eq $true }

    It "passes recurse to Copy-Item" {

		Copy-MyFiles

		Assert-MockCalled Copy-Item
	}

    #
    # Wrap framework calls in powershell methods to mock
    #
    Mock Download-File

    It "when source is null or empty" {
        
		Encrypt-Config

        Assert-MockCalled Download-File
    }	
    
    # Custom function
    function Download-File() {
	    Param($sourceUrl, $destinationPath)

	    ((New-Object System.Net.WebClient).DownloadFile($sourceUrl, $destinationPath))
    }