#
# Test-WSman - Test the WinRm service
#
test-wsman 192.148.111.12

$password = ConvertTo-SecureString -String "P@sSwOrd" -AsPlainText -Force
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList "MyDomain\MyUsername",  $password

Test-Wsman 192.148.111.12 -Authentication Default -Credential $Credential -Port 5985   

# Test using kerberos, cant use IP address, must be a name
Test-wsman MyComputer-01 -Authentication Kerberos -Credential $Credential

#
# WinRm - Windows Remote Management Command Line Tool
#
winrm get winrm/config 

# Enumerate Listeners
winrm e winrm/config
winrm e winrm/config/listener

# Create a listeners
winrm quickconfig
winrm quickconfig -transport:https

#delete listener
winrm delete winrm/config/Listener?Address=*+Transport=HTTP

#
# Win rs can be used to run remote commands
#
winrs -?

#
# PsSession uses WinRm to start a session
# 
Enter-PsSession MyServer-01
cd ..\Desktop
ls # Displays whats on your MyServer-01 desktop
Exit-PSSession

#
# Invoke-Command to run a remote command on a server
#
Invoke-Command -ComputerName MyServer-01 -Command { ipconfig } 