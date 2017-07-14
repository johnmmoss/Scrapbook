
write-host Starting win7-install-ps4-32bit... -ForegroundColor green
write-host -ForegroundColor red
write-host *** NB There will be popups *** -ForegroundColor red
write-host -ForegroundColor red

# Load DotNet452 Module
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/johnmmoss/Scrapbook/master/Powershell/Install-dotnet452.ps1'))

# Load Powershell4 Module
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/johnmmoss/Scrapbook/master/Powershell/Install-Powershell4.ps1'))

#gwmi win32_operatingsystem | select osarchitecture #Is32Bit

Install-Dotnet452

Install-Powershell4 -Is32Bit

Restart-Computer -Force

