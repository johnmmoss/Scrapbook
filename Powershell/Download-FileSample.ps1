 
 # WebClient Class:  https://msdn.microsoft.com/en-us/library/system.net.webclient(v=vs.110).aspx

 # Have a read of the chocolatey script to see more tips: https://chocolatey.org/install.ps1

 # Chocolatey install: https://chocolatey.org/install
 # note that iex is Invoke-Expression!
 #
 #   iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

  write-host temp dir is: $env:Temp

 # Download string and write out to file
 ((New-Object System.Net.WebClient).DownloadString("http://www.google.com"))  | out-file googlehome.txt

 # Download an image using DownloadFile method
 ((New-Object System.Net.WebClient).DownloadFile($url, "C:\Temp\image123.jpg"))
 
 # Download PackageManager exe
 ((New-Object System.Net.WebClient).DownloadFile("https://download.microsoft.com/download/C/4/1/C41378D4-7F41-4BBE-9D0D-0E4F98585C61/PackageManagement_x64.msi", "C:\temp\PackageManagement_x64.msi"))
