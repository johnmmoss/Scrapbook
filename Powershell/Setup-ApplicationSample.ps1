
# TODO Write cmdlets :(


$REPO_DIR = "E:\Repos"

Create-SqlDatabase -name "AcmeDriver"

Create-SqlLogin -name "authuser" -Database "AcmeDriver"

Publish-SqlDatabase -server 'local'

Create-IISWebsite -Name "AcmeCustomerService" -Port 8080

Build-Sln -Name "AcmeCustomerService" 

Publish-Sln -Profile "Debug"
