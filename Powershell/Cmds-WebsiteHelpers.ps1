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

        $WebSite = $PsBoundParameters[$ParameterName]

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

        $WebSite = $PsBoundParameters[$ParameterName]

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

        $WebSite = $PsBoundParameters[$ParameterName]

        start-website -name $WebSite
        stop-website -name $WebSite

        get-website | where { $_.Name -eq $WebSite }
    }
}

function Build-RuntimeParam() {
        $ParameterName = 'Name'

        # Create the dictionary 
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
 
        # Create the collection of attributes
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]

        # Create and set the parameters' attributes
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $true
        $ParameterAttribute.Position = 1
 
        #Add the attributes to the attributes collection
        $AttributeCollection.Add($ParameterAttribute)

        #Code to generate the values that our user can tab through
        $arrSet = Get-Website | select name
        $arrSetAsString = $arrSet | Foreach {[string] $_.Name }
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSetAsString )

        # Add the ValidateSet to the attributes collection
        $AttributeCollection.Add($ValidateSetAttribute)
 
        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
}
