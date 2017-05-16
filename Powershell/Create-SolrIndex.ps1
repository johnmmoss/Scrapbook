

function Create-SolrIndex() {    
    Param(
        $IndexPath = "E:\Solr\Index\AcmeMvc",
        $TemplateFolderName = "collection1"
    )

    if((Test-Path $IndexPath) -ne $true) {
        
        write-host Index Path [$IndexPath] does not exist -ForegroundColor red
        return 

    } else {

        $TemplateFolderNamePath = $IndexPath + "\" + $TemplateFolderName

        if ((Test-Path $TemplateFolderNamePath) -ne $true) {
            
            cd $IndexPath

            write-host Creating indexes in index folder [$IndexPath] using template folder [$TemplateFolderNamePath] -ForegroundColor Gray

            write-host $TemplateFolderNamePath

            copy $TemplateFolderName  acmemvc_core_index -r
            copy $TemplateFolderName  acme_master_index -r
            
            echo name=acmemvc_core_index  > .\acmemvc_core_index\core.properties
            echo name=acme_master_index  > .\acme_master_index\core.properties            
            
        } else {

            write-host Index Path [$IndexPath] does not exist -ForegroundColor red
       }        
    }    
}
