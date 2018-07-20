component {
    function init(){
        variables.textCache = {};
    }

    function getText(franchiseeKey, language, textSection){
        return readTextFile(franchiseeKey, language, textSection);
    }

    private function readTextFile(franchiseeKey, language, textFileName){
        local.file =  Expandpath("/lang") & "/#franchiseeKey#/#language#/#textFileName#.json";
        if(FileExists(file)){
            return deserializeJSON(fileRead(file));
        }
        return {};
    }

    function getServeyResponses(applicationKey, language){
        return serveyResponses[applicationKey][language];
    }
}