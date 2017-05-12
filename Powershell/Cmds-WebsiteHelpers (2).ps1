# Provides keybindings tab compeletion when starting/stopping/restarting an iis website...
# Example -  on Typing "Cust" and hitting tab will show popup:
#   iis-start -n CustomerApi
# References:
#   https://foxdeploy.com/2017/01/13/adding-tab-completion-to-your-powershell-functions/

function iis-start{
    [CmdletBinding()]
    Param($Server=$env:COMPUTERNAME)
    DynamicParam {
       Build-RuntimeParam
    }

    begin {

        $WebSite = $PsBoundParameters[$ParameterName2]

        start-website -name $WebSite
        
        get-website | where { $_.Name -eq $WebSite }
    }
}

function iis-stop{
    [CmdletBinding()]
    Param($Server=$env:COMPUTERNAME)
    DynamicParam {
        Build-RuntimeParam
    }

    begin {

        $WebSite = $PsBoundParameters[$ParameterName2]

        stop-website -name $WebSite
        
        get-website | where { $_.Name -eq $WebSite }
    }
}

function iis-restart {
    [CmdletBinding()]
    Param($Server=$env:COMPUTERNAME)
    DynamicParam {
        Build-RuntimeParam
    }

    begin {

        $WebSite = $PsBoundParameters[$ParameterName2]

        start-website -name $WebSite
        stop-website -name $WebSite

        get-website | where { $_.Name -eq $WebSite }
    }
}

function Build-RuntimeParam() {
        $ParameterName2 = 'Name'

        # Create the dictionary 
        $RuntimeParameterDictionary2 = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
 
        # Create the collection of attributes
        $AttributeCollection2 = New-Object System.Collections.ObjectModel.Collection[System.Attribute]

        # Create and set the parameters' attributes
        $ParameterAttribute2 = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute2.Mandatory = $true
        $ParameterAttribute2.Position = 1
 
        #Add the attributes to the attributes collection
        $AttributeCollection2.Add($ParameterAttribute2)

        #Code to generate the values that our user can tab through
        $arrSet2 = Get-Website | select name
        $arrSetAsString2 = $arrSet | Foreach {[string] $_.Name }
        $ValidateSetAttribute2 = New-Object System.Management.Automation.ValidateSetAttribute($arrSetAsString2 )

        # Add the ValidateSet to the attributes collection
        $AttributeCollection2.Add($ValidateSetAttribute2)
 
        # Create and return the dynamic parameter
        $RuntimeParameter2 = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName2, [string], $AttributeCollection2)
        $RuntimeParameterDictionary2.Add($ParameterName2, $RuntimeParameter2)
        return $RuntimeParameterDictionary2
}
