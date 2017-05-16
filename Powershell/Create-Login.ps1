
Import-Module SQLPS -DisableNameChecking

#Create-Login -loginName "XXX1" -password "Password1!"

function Create-Login() {
    Param(    
        $loginName =  $null,
        $password = $null,
        $instanceName = "(local)"
    )

    if ($loginName -eq $null) {
        
        write-host Please provide a LoginName -ForegroundColor Red
        return
    }

    if ($password -eq $null) {
        
        write-host Please provide a Password -ForegroundColor Red
        return
    }

    $server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName

    # drop login if it exists
    if ($server.Logins.Contains($loginName))  
    {   
        Write-Host Login $loginName already exists on server $instanceName -ForegroundColor red
        return
    }

    $login = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Login -ArgumentList $server, $loginName
    $login.LoginType = [Microsoft.SqlServer.Management.Smo.LoginType]::SqlLogin
    $login.PasswordExpirationEnabled = $false
    $login.PasswordPolicyEnforced = $false
    #$login.AddToRole("sysadmin")
    $login.Create($password)

    Write-Host("Login $loginName created successfully.")
}
