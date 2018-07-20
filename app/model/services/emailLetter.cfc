component accessors="true"{

    property beanFactory;
    property mustache;
    property uuidUtility;

    public function init(){
        variables.cacheKey = "_emailLetters";
    }

    private function loadLetters(){
        if(structKeyExists(request,cacheKey)){
            return;
        }
        local.qMsgs = queryexecute("
            select `id`, `franchisee_Id`, `name`, `subject`, `from`, `body`, `enabled`
            from email_msg
            order by `id`
        ");
        request[cacheKey] = {
            stct:{},
            arr:[]
        };
        for(local.rMsg in qMsgs){
            local.msg = beanFactory.getBean("emailLetterBean",{
                id: rMsg.id,
                franchiseeId: rMsg.franchisee_Id,
                name: rMsg.name,
                subject: rMsg.subject,
                from: rMsg.from,
                body: rMsg.body,
                enabled: rMsg.enabled
            });
            request[cacheKey].stct[rMsg.id] = msg;
            request[cacheKey].arr.append(msg);
        }
    }

    function read(id){
        loadLetters();
        return request[cacheKey].stct[id];
    }

    function readArray(ids){
        loadLetters();
        return ids.map(function(id){
            return read(id);
        });
    }

    function readAll(required franchiseeId ,enabledOnly = true){
        loadLetters();
        local.out = request[cacheKey].arr;
        local.out = local.out.filter(function(msg){
            return msg.getFranchiseeId() == franchiseeId;
        });
        if(enabledOnly){
            local.out = local.out.filter(function(msg){
                return msg.getEnabled();
            });
        }
        return local.out;
    }

    function sendToApplicants(msg, applicants, unsubscribeURL){
        local.mustache = beanFactory.getBean("Mustache");
        local.mail = new mail();
        local.trackingRecords = [];
        mail.setFrom(msg.getFrom());
        mail.setSubject(msg.getSubject());
        mail.setType("html");
        applicants.each(function(applicant){
            mail.setTo(applicant.getEmail());
            mail.send(
                body = mustache.render(msg.getBody(), {
                    firstName: applicant.getFirstName(),
                    lastName: applicant.getLastName(),
                    unsubscribeLink: unsubscribeURL
                        & "?a="
                        & EncodeForHTML(uuidUtility.toBase64(applicant.getId()))
                })
            );
            trackingRecords.append({
                msgId: msg.getId(),
                applicantId: applicant.getId()
            });
        });
        writeApplicantTrackings(trackingRecords);
        return arrayLen(trackingRecords);
    }

    function sendToApplicant(msg, applicant, unsubscribeURL){
        sendToApplicants(msg, [applicant], unsubscribeURL);
    }

    private function writeApplicantTrackings(trackingRecords){
        local.params = [];
        local.valuesText = "";
        trackingRecords.each(function(tr,i){
            params.append({
                CFSQLType = "cf_sql_char",
                maxLength = "36",
                value = tr.msgId
            });
            params.append({
                CFSQLType = "cf_sql_char",
                maxLength = "36",
                value = tr.applicantId
            });
            params.append({
                CFSQLType = "cf_sql_timestamp",
                value = Now()
            });
            valuesText &= ((i != 1)?",":"" ) & "(?,?,?)";
        });

        queryexecute("insert into email_applicant_tracking
        (msg_id, applicant_id, sent)
        values
        #valuesText#",
        params);
    }

    private function writeApplicantTracking(msgId, applicantId){
        writeApplicantTrackings([
            {msgId:msgId, applicantId:applicantId}
        ]);
    }

    function unsubscribeApplicant(applicant){
        unsubscribeEmail(applicant.getEmail());
        return applicant.getEmail();
    }

    function unsubscribeEmail(email){
        unsubscribeEmails([email]);
    }

    function unsubscribeEmails(emails){
        var unsubscribeEmails = emails.filter(function(email){
            return len(email);
        });
        if(!arrayLen(unsubscribeEmails)){
            return;
        }
        var params = [];
        var valuesText = "";
        unsubscribeEmails.each(function(email,i){
            valuesText &=  ((i != 1)?",":"") & "(?)";
            params.append({
                CFSQLType: "cf_sql_varchar",
                value: email
            });
        });
        queryExecute("INSERT INTO `unsubscribed`
            (`email`)
            VALUES #valuesText#;
        ", params);
    }

    function getUnsubscribeURL(fw){
        return "http://"
            & cgi.HTTP_HOST
            & fw.buildURL(":unsubscribe");
    }

}