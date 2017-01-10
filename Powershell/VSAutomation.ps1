#Powershell Reference: https://docs.nuget.org/ndocs/tools/powershell-reference

#Solution
#https://lostechies.com/erichexter/2010/10/07/using-solution-factory-nupack-to-create-opinionated-visual-studio-solutions/

#
#Visual Studio automation
#

Add-Type -Path  'C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\PublicAssemblies\EnvDTE.dll'

Add-Type -Path 'C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\PublicAssemblies\VSLangProj.dll'

Add-Type -Path 'C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\PublicAssemblies\VSLangProj80.dll'

Add-Type -Path 'C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\PublicAssemblies\EnvDTE80.dll'


#http://jameschambers.com/2011/06/powershell-script-examples-for-nuget-packages/

$project.Object.References | Where-Object { $_.Name -eq 'NameOfReference' } | ForEach-Object { $_.Remove() }


$sln = [EnvDTE.Solution]$dte.Solution

(Get-Project -Name Nhsic.ClinicalAudit.Nboca.Web).Object.References.Count

(Get-Project -Name Nhsic.ClinicalAudit.Nboca.Web).Object.References | Where-Object { $_.Name.StartsWith('System') } | ForEach-Object { $_.Remove() }

Get-Project -all


#
# List all references 
#
(Get-Project -Name Nhsic.ClinicalAudit.Nboca.Web).Object.References  | Where-Object { $_.Name -eq "Castle.Core" } | Select-Object ContainingProject.ProjectName, Identity, Path


#
# Add a reference
#
(Get-Project -Name Nhsic.ClinicalAudit.Nboca.Web).Object.References.Add("System.Web")

function psuedocode() {

    # given this package
    $package = "RhinoMock";

    # if its not isntalled as a package
    # install it

    #find all occurences of this package

    # if is package 
    # leave
    # else
    # remove and add new reference to package

}

# http://stackoverflow.com/questions/28897015/how-can-i-get-with-powershell-the-project-version-in-visual-studio
function Get-ProjectVersion([string] $ProjectName)
{
    $project = Get-Project -Name $ProjectName
    $assemblyPath = $project.ProjectItems.Item("Properties").ProjectItems.Item("AssemblyInfo.cs").Properties.Item("FullPath").Value

    $assemblyInfo = Get-Content -Path $assemblyPath
    if (!$assemblyInfo)
    {
        return $null
    }                

    $versionMatches = [regex]::Match($assemblyInfo, "\[assembly\: AssemblyVersion\(`"((\d+)\.(\d+)\.(\d+)\.?(\d*)){1}`"\)\]")

    if (!$versionMatches -or !$versionMatches.Groups -or $versionMatches.Groups.Count -le 0)
    {
        return $null
    }

    return $versionMatches.Groups[1].Value
}