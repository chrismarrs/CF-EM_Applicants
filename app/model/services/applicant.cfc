component accessors="true" {

    property beanFactory;
    function init(){}

    function create(positionId){
        local.id = createUUID();
        queryExecute("insert into applicant
            (id, position)
            values
            (:id, :positionId)",
            {
                id = {
                    value = id,
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                },
                positionId = {
                    value = positionId,
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                }
            }
        );
        return read(id);
    }

    function read(id){
        return getByIds([id])[1];
    }

    function readArray(ids){
        return getByIds(ids);
    }

    function getByDateCreated(required franchiseeId, required startDate, required endDate){
        return search({
            franchiseeId: franchiseeId,
            startDate: startDate,
            endDate: endDate
        });
    }

    function search(struct args = {}){
        var sql = "select a.id
            from applicant a
            join positions p
                on a.position = p.id
            where p.franchisee_id = ?";
        var params = [{
            CFSQLType: "int",
            value: args.franchiseeId
        }];
        if(args.keyExists("startDate") && isDate(args.startDate)){
            sql &= " and datecreated >= ?";
            params.append({
                CFSQLType: "cf_sql_timestamp",
                value: CreateDateTime(year(args.startDate), month(args.startDate), day(args.startDate), 0, 0, 0)
            });
        }
        if(args.keyExists("endDate") && isDate(args.endDate)){
            sql &= " and datecreated <= ?";
            params.append({
                CFSQLType: "cf_sql_timestamp",
                value: CreateDateTime(year(args.endDate), month(args.endDate), day(args.endDate), 23, 59, 59)
            });
        }
        var qApplicants = queryExecute(sql, params);
        return readArray(
            qApplicants.reduce(function(ids, row){
                ids.append(row.id);
                return ids;
            }, [])
        );
    }

    function update(applicant){
        updateArray([applicant]);
    }

    function updateArray(applicants){
        //Update applicant records
        local.params = [];
        local.ids = [];
        local.insertValues = "";
        local.isFirst = true;
        for(local.applicant in applicants){
            arrayAppend(ids, applicant.getId());
            if(!isFirst){
                insertValues &= ",";
            }
            else{
                isFirst = false;
            }
            insertValues &= "
                (?,?,?,?,?,?,?,?,?,?,?)";
            arrayAppend(params, {
                value= applicant.getId(),
                CFSQLType = "cf_sql_char",
                maxLength = 36
            });
            arrayAppend(params, {
                value= applicant.getpositionId(),
                CFSQLType = "cf_sql_varchar",
                maxLength = 36
            });
            arrayAppend(params, {
                value= applicant.getFirstName(),
                CFSQLType = "cf_sql_varchar"
            });
            arrayAppend(params, {
                value= applicant.getLastName(),
                CFSQLType = "cf_sql_varchar"
            });
            arrayAppend(params, {
                value= applicant.getEmail(),
                CFSQLType = "cf_sql_varchar"
            });
            arrayAppend(params, {
                value= applicant.getAddress(),
                CFSQLType = "cf_sql_varchar"
            });
            arrayAppend(params, {
                value= applicant.getCity(),
                CFSQLType = "cf_sql_varchar"
            });
            arrayAppend(params, {
                value= applicant.getState(),
                CFSQLType = "cf_sql_varchar"
            });
            arrayAppend(params, {
                value= applicant.getZipCode(),
                CFSQLType = "cf_sql_varchar"
            });
            arrayAppend(params, {
                value= applicant.getIsCompleted(),
                CFSQLType = "cf_sql_tinyInt"
            });
            arrayAppend(params, {
                value= applicant.getDeleted(),
                CFSQLType = "cf_sql_tinyInt"
            });
        }
        queryExecute("insert into applicant
            (id, position, firstName, lastName, email, address, city, state, zipCode, complete, deleted)
            values" & insertValues & "
            on duplicate key update
                firstName = values(firstName),
                lastName = values(lastName),
                email = values(email),
                address = values(address),
                city = values(City),
                state = values(state),
                zipCode = values(zipCode),
                complete = values(complete),
                deleted= values(deleted)"
            ,
            params
        );

        //Update attributes
        queryExecute("delete from applicant_attributes
            where applicant_id in (:ids)",
            {
                ids = {
                    value = arrayToList(ids),
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                }
            });
        params = [];
        insertValues = "";
        isFirst = true;
        for(local.applicant in applicants){
            for(local.attrKey in applicant.getAttributes()){
                if(!isFirst){
                    insertValues &= ",";
                }
                else{
                    isFirst = false;
                }
                insertValues &= "
                (?, (select id from attributes where attributeKey = ?), ?)";
                arrayAppend(params, {
                    value= applicant.getId(),
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                });
                arrayAppend(params,{
                    value = attrKey,
                    CFSQLType = "cf_sql_varchar"
                });
                arrayAppend(params,{
                    value = applicant.getAttr(attrKey),
                    CFSQLType = "cf_sql_varchar"
                });

            }
        }
        if(len(insertValues)){
            // applicants may have no attributes.
            queryExecute("insert ignore into applicant_attributes
                (applicant_id, attributeKey_id, value)
                values" & insertValues,
                params
            );
        }

        //update References
        queryExecute("delete from `references`
            where applicant_id in (:ids)",
            {
                ids = {
                    value = arrayToList(ids),
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                }
            });
        params = [];
        insertValues = "";
        isFirst = true;
        for(local.applicant in applicants){
            for(local.reference in applicant.getReferences()){
                if(!isFirst){
                    insertValues &= ",";
                }
                else{
                    isFirst = false;
                }
                insertValues &= "
                (?,?,?,?,?)";
                arrayAppend(params,{
                    value= reference.id,
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                });
                arrayAppend(params, {
                    value= applicant.getId(),
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                });
                arrayAppend(params,{
                    value = reference.name,
                    CFSQLType = "cf_sql_varchar"
                });
                arrayAppend(params,{
                    value = reference.phone,
                    CFSQLType = "cf_sql_char",
                    maxLength = 25
                });
                arrayAppend(params,{
                    value = reference.relationship,
                    CFSQLType = "cf_sql_varchar"
                });

            }
        }
        if(len(insertValues)){
            // applicants may have no references
            queryExecute("insert into `references`
                (id, applicant_id, name, phone, relationship)
                values" & insertValues,
                params
            );
        }

        //update WorkHistory
        queryExecute("delete from work_history
            where applicant_id in (:ids)",
            {
                ids = {
                    value = arrayToList(ids),
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                }
            });
        params = [];
        insertValues = "";
        isFirst = true;
        for(local.applicant in applicants){
            for(local.workHistory in applicant.getWorkHistory()){
                if(!isFirst){
                    insertValues &= ",";
                }
                else{
                    isFirst = false;
                }
                insertValues &= "
                (?,?,?,?,?,?,?,?,?,?)";
                arrayAppend(params,{
                    value= workHistory.id,
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                });
                arrayAppend(params, {
                    value= applicant.getId(),
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                });
                arrayAppend(params,{
                    value = workHistory.name,
                    CFSQLType = "cf_sql_varchar"
                });
                arrayAppend(params,{
                    value = workHistory.phone,
                    CFSQLType = "cf_sql_char",
                    maxLength = 25
                });
                arrayAppend(params,{
                    value = workHistory.supervisorName,
                    CFSQLType = "cf_sql_varchar"
                });
                arrayAppend(params,{
                    value = workHistory.jobTitle,
                    CFSQLType = "cf_sql_varchar"
                });
                arrayAppend(params,{
                    value = workHistory.responsibilities,
                    CFSQLType = "cf_sql_varchar"
                });
                arrayAppend(params,{
                    value = workHistory.startDate,
                    CFSQLType = "cf_sql_date",
                    null = !isDate(workHistory.startDate)
                });
                arrayAppend(params,{
                    value = workHistory.endDate,
                    CFSQLType = "cf_sql_date",
                    null = !isDate(workHistory.endDate)
                });
                arrayAppend(params,{
                    value = workHistory.reasonForLeaving,
                    CFSQLType = "cf_sql_varchar"
                });

            }
        }
        if(len(insertValues)){
            // applicants may have no work hisotry
            queryExecute("insert into `work_history`
                (id, applicant_id, name, phone, supervisorName, jobTitle, responsibilities, startDate, endDate, reasonForLeaving)
                values" & insertValues,
                params
            );
        }
    }

    function delete(id){
        deleteArray([id]);
    }

    function deleteArray(ids){
        queryExecute("update applicant
            set deleted = 1
            where id in (:ids)",
            {
                ids = {
                    value = arrayToList(ids),
                    CFSQLType = "cf_sql_char",
                    maxLength = 36
                }
            }
        );
    }

    private function getByIds(arrIds){
        local.applicants = {};
        local.params = {
            ids = {
                value = arrayToList(arrIds),
                CFSQLType = "cf_sql_char",
                list = true,
                maxLength = 36
            }
        };
        local.qApplicat = queryExecute(
            "select
                id,
                position,
                firstName,
                lastName,
                email,
                (
                    select max(u.date)
                    from unsubscribed u
                    where u.email = applicant.email
                    group by u.email
                ) as unsubscribed,
                address,
                city,
                state,
                zipCode,
                complete,
                deleted,
                dateCreated
            from applicant
            where id in (:ids)",
            params
        );
        local.qAttributes = queryExecute(
            "select applicant_id, attributeKey, value
            from applicant_attributes aa
            join attributes a
                on a.id = aa.attributeKey_id
            where applicant_id in (:ids)",
            params
        );
        local.qReferences = queryExecute(
            "select id, applicant_id, name, phone, relationship
            from `references`
            where applicant_id in (:ids)
            order by name",
            params
        );
        local.qWorkHistory = queryExecute(
            "select
                id,
                applicant_id,
                name,
                phone,
                supervisorName,
                jobTitle,
                responsibilities,
                startDate,
                endDate,
                reasonForLeaving
            from work_history
            where applicant_id in (:ids)
            order by startDate",
            params
        );
        for(local.rApplicant in qApplicat){
            local.applicant = beanFactory.getBean("applicantBean");
            applicant.setId(rApplicant.id);
            applicant.setPositionId(rApplicant.position);
            applicant.setFirstName(rApplicant.firstName);
            applicant.setLastName(rApplicant.lastName);
            applicant.setAddress(rApplicant.address);
            applicant.setEmail(rApplicant.email);
            applicant.setUnsubscribed(rApplicant.unsubscribed);
            applicant.setCity(rApplicant.city);
            applicant.setState(rApplicant.state);
            applicant.setZipCode(rApplicant.zipCode);
            applicant.setIsCompleted(rApplicant.complete);
            applicant.setDeleted(rApplicant.deleted);
            applicant.setDateCreated(rApplicant.dateCreated);
            applicants[rApplicant.id] = applicant;
        }
        for(local.rAttr in qAttributes){
            if(StructKeyExists(applicants, rAttr.applicant_id)){
                applicants[rAttr.applicant_id].setAttr(rAttr.attributeKey, rAttr.value);
            }

        }
        for(local.rReference in qReferences){
            if(StructKeyExists(applicants, rReference.applicant_id)){
                applicants[rReference.applicant_id].addRefrence(
                    rReference.id,
                    rReference.name,
                    rReference.phone,
                    rReference.relationship
                );
            }
        }
        for(local.rWorkHistory in qWorkHistory){
            if(StructKeyExists(applicants, rWorkHistory.applicant_id)){
                applicants[rWorkHistory.applicant_id].addWorkHistory(
                    rWorkHistory.id,
                    rWorkHistory.name,
                    rWorkHistory.phone,
                    rWorkHistory.supervisorName,
                    rWorkHistory.jobTitle,
                    rWorkHistory.responsibilities,
                    rWorkHistory.startDate,
                    rWorkHistory.endDate,
                    rWorkHistory.reasonForLeaving
                );
            }
        }
        return arrIds.map(function(id){
            if(structKeyExists(applicants, id))
                return applicants[id];
            var applicant = beanFactory.getBean("applicantBean");
            return applicant;
        });
    }

    function setAttributes(arrAttrKeys){
        local.params = [];
        insertValues = "";
        isFirst = true;
        for(local.key in arrAttrKeys){
            if(!isFirst){
                insertValues &= ",";
            }
            else{
                isFirst = false;
            }
            insertValues &= "(?)";
            arrayAppend(params, {
                value = key,
                CFSQLType = "cf_sql_varchar"
            });
        }
        if(len(insertValues)){
            queryExecute("insert into attributes
                (attributeKey)
                values " & insertValues & "
                on duplicate key update attributeKey = attributeKey",
                params
            );
        }
    }

    function getByEmails(arrEmails){
        local.qIds = queryExecute("select id
        from applicant
        where email in (:emails)",
        {
            CFSQLType = "cf_sql_varchar",
            value= arrEmails.toList(),
            list = true
        });
        local.ids = [];
        for(local.rId in qIds){
            ids.append(rId.id);
        }
        return getByIds(ids);
    }
}