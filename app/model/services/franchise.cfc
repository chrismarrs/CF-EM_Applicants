/** Data is cached into the request */
component accessors="true"{
    private function getFranchises(){
        if(structKeyExists(request, "_franchises")){
            return Request["_franchises"];
        }
        Request["_franchises"] = {};
        queryExecute("
            select
            `id`, `locationKey`, `name`, `enabled`
            from franchisee
        ")
        .each(function(franchisee){
            Request["_franchises"][franchisee.id] = create(
                argumentCollection = franchisee
            );
        });
        return Request["_franchises"];
    }

    function getFranchisesById(id){
        var franchises = getFranchises();
        if(!structKeyExists(franchises, id))
            franchises[id] = create(id = franchises);
        return franchises[id];
    }

    function getAll(){
        var franchises = getFranchises()
        .reduce(function(out, k, v, s){
            out.append(v);
            return out;
        }, []);
        franchises.sort(function(e1,e2){
            return compare(e1.id, e2.id);
        });
        return franchises;
    }

    function create(id = 0, name = ""){
        return {
            id: id,
            locationKey: locationKey,
            name: name,
            enabled: enabled
        };
    }
}