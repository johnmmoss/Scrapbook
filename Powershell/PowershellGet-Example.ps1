# PowershellGet 
#   - MSDN: https://msdn.microsoft.com/en-us/powershell/reference/5.1/powershellget/powershellget
# How to setup an internal repository in Powershell 
#   - https://redmondmag.com/articles/2016/12/23/internal-nuget-repository-in-powershell.aspx
# Creating a PowershellGet repository 
#   - https://richardspowershellblog.wordpress.com/2015/01/04/creating-a-powershellget-repository/
# Build a TFS 2015 Powershell Module using nuget 
#   - https://agileramblings.com/2015/07/23/building-a-tfs-2015-powershell-module-using-nuget/

#New-ModuleManifest -Path C:\Test-Module.psd1

# 1.) Copy a module to a module directory
# Example Module at :https://github.com/johnmmoss/Scrapbook/tree/master/Powershell/ModuleDemo/BuildHelpers
# For Module dirctories see:
$env:PSModulePath.Split(';') # | % { start $_ }

# 2.) Install proget locally :from https://inedo.com/proget/download and create a feed MSPowershell... 
# Local proget server/feed at: http://localhost:81/nuget/MSPowershell
Register-PSRepository  -Name InternalPowerShellModules -SourceLocation  http://localhost:81/nuget/MSPowershell -PackageManagementProvider NuGet  -PublishLocation http://localhost:81/nuget/MSPowershell  -InstallationPolicy Trusted

# You can view repositorys 
Get-PSRepository 

# Your module *should* be available once in the correct directory
Get-Module -ListAvailable

# 3.) Now we Publish the module to our local nuget
Publish-Module -Name  BuildHelpers -Repository InternalPowerShellModules -NuGetApiKey "Admin:Admin"

# 4.) Now if we search the module we can find it
Find-Module -Name BuildHelpers -Repository  InternalPowerShellModules # | Install-Module
