
Import-Module WebAdministration


function Build-Sln() {

    # Build the solution, is this the right compiler version?
    invoke-expression("C:\Windows\Microsoft.Net\Framework\v4.0.30319\msbuild.exe D:\svn\WebSite\src\Web.sln /v:q")
}

function Remove-WebSite() {

    remove-item IIS:\AppPools\WebSite1 -Recurse
    remove-item IIS:\Sites\Website1 -Recurse

}
