# Provides keybindings tab compeletion when starting/stopping/restarting a service...
# Example -  on Typing "SQL" and hitting tab will show popup:
#   sstart -n MSSQLSERVER
# References:
#   https://foxdeploy.com/2017/01/13/adding-tab-completion-to-your-powershell-functions/



function sstop{
    [CmdletBinding()]
    Param($Server=$env:COMPUTERNAME)
    DynamicParam {
       Build-RuntimeParam
    }

    begin {

        $Service = $PsBoundParameters[$ParameterName]

        stop-service -name $Service
        
        get-service -Name $Service
    }
}

function sstart{
    [CmdletBinding()]
    Param($Server=$env:COMPUTERNAME)
    DynamicParam {
        Build-RuntimeParam
    }

    begin {

        $Service = $PsBoundParameters[$ParameterName]

        start-service -name $Service
        
        get-service -Name $Service
    }
}

function srestart {
    [CmdletBinding()]
    Param($Server=$env:COMPUTERNAME)
    DynamicParam {
        Build-RuntimeParam
    }

    begin {

        $Service = $PsBoundParameters[$ParameterName]

        restart-service -name $Service

        get-service -Name $Service
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
        $arrSet = Get-Service | select name
        $arrSetAsString = $arrSet | Foreach {[string] $_.Name }
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSetAsString )

        # Add the ValidateSet to the attributes collection
        $AttributeCollection.Add($ValidateSetAttribute)
 
        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
}
