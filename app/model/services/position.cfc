component accessors="true"{

    property beanFactory;
    property franchiseService;

    function init(fw){
        variables.fw = fw;
    }

    function create(positionId, franchiseeId = 0){
        return {
            id = positionId,
            franchiseeId = franchiseeId,
            name = "",
            descHTML = "",
            enabled = 0,
            deleted = 0
        };
    }

    function read(positionId){
        return getPosition(positionId);
    }

    function update(position){
        queryExecute("
            insert into positions
            (id, franchisee_id, name, descHTML, enabled, deleted)
            values
            (:id, :franchiseeId, :name, :descHTML, :enabled, :deleted)
            on duplicate key update
            name = values(name),
            descHTML = values(descHTML),
            enabled = values(enabled),
            deleted = values(deleted)
        ",{
            id: {
                value: position.id,
                CFSQLType: "cf_sql_char"
            },
            franchiseeId: {
                value: position.franchiseeId,
                CFSQLType: "cf_sql_integer"
            },
            name: {
                value: position.name,
                CFSQLType: "cf_sql_varchar"
            },
            descHTML: {
                value: position.descHTML,
                CFSQLType: "cf_sql_varchar"
            },
            enabled: {
                value: position.enabled,
                CFSQLType: "cf_sql_integer"
            },
            deleted: {
                value: position.deleted,
                CFSQLType: "cf_sql_integer"
            }
        });
    }


    function getForFranchisee(franchiseeId, includeDeleted = false){
        var out = [];
        queryExecute("select
            id, franchisee_id, Name, descHTML, enabled, deleted
            from positions
            where franchisee_id = :franchiseeId
            #!includeDeleted?'and not deleted':''#
            order by franchisee_id, Name, enabled, deleted
        ",{
            franchiseeId: {
                value: franchiseeId,
                CFSQLType = "cf_sql_integer"
            }
        }).each(function(row){
            var position = {};
            position.id = row.id;
            position.franchiseeId = row.franchisee_id;
            position.name = row.name;
            position.descHTML = row.descHTML;
            position.enabled = row.enabled;
            position.deleted = row.deleted;
            out.append(position);
        });
        return out;
    }

    function getPosition(positionId, includeDeleted = false){
        var positions = cache();
        if(StructKeyExists(positions, positionId)){
            return positions[positionId];
        }
        positions[positionId] = create(positionId);
        queryExecute("select
            id, franchisee_id, Name, descHTML, enabled, deleted
            from positions
            where id = :ids
            #!includeDeleted?'and not deleted':''#
            order by franchisee_id, Name, enabled, deleted
        ",{
            ids: {
                value: positionId,
                CFSQLType= "cf_sql_char"
            }
        }).each(function(row){
            positions[row.id] = {
                id = row.id,
                franchiseeId = row.franchisee_id,
                name = row.name,
                descHTML = row.descHTML,
                enabled = row.enabled,
                deleted = row.deleted
            };
        });
        return positions[positionId];
    }

    function getPositionURL(position){
        var franchise = franchiseService.getFranchisesbyId(position.franchiseeId);
        return fw.buildURL("applicant:#franchise.locationKey#.position?id=#position.id#");
    }

    function cache(){
        if(!StructKeyExists(request, "_position-Cache")){
            request["_position-Cache"] = {};
        }
        return request["_position-Cache"];
    }
}