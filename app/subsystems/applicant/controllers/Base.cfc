component accessors="true" {

    property languageService;
    property stateService;
    property applicantService;
    property emailLetterService;
    property positionService;


    function default(){
        fw.redirect(".start");
    }

    function setApplicantService(applicantService){
        variables.applicantService = applicantService;
        applicantService.setAttributes(applicantAttrs);
    }

    function applicantType(rc){
       rc.positions = positionService.getForFranchisee(locationId).filter(function(position){
           return position.enabled;
       });
    }

    function postApplicantType(rc){
        session.positionId = rc.pid;
        var applicant = getApplicantObj();
        applicant.setPositionId(session.positionId);
        applicant.save();
        fw.redirect(".applicant");
    }

    function position(rc){
        param name="rc.id" default="";
        param name="rc.pid" default="#rc.id#";
        if(!rc.pid.len())
            fw.redirect(".applicantType");
       rc.position = positionService.getPosition(rc.pid);
    }

    function positions(rc){
        rc.positions = positionService.getForFranchisee(locationId).filter(function(position){
            return position.enabled;
        });
    }

    function applicant(rc){
        rc.applicant = getApplicantObj();
        rc.applicationText = languageService.getText(
            locationKey, getLang(), "applicant"
        );
        rc.stateList = stateService.getStateList();
    }

    function postApplicant(rc){
        local.applicant = getApplicantObj();
        applicant.setFirstName(form.firstName);
        applicant.setLastName(form.lastName);
        applicant.setEmail(form.email);
        applicant.setAddress(form.address);
        applicant.setCity(form.city);
        applicant.setState(form.state);
        applicant.setZipCode(form.zipCode);

        for(local.attrKey in applicantAttrs){
            if(!StructKeyExists(form, attrKey)){
                continue;
            }
            applicant.setAttr(attrKey, form[attrKey]);
        }

        if(FindNoCase("other", form.hdyh)){
            applicant.setAttr("hdyhOther", form.hdyhOther);
        }

        applicant.save();
        fw.redirect(".workhistory");
    }

    function workhistory(rc){
        local.applicant = getApplicantObj();
        for(local.i = arrayLen(applicant.getWorkHistory()) + 1; i <= maxWorkHistorys; i++){
            applicant.newWorkHistory(
                name = "",
                phone = "",
                supervisorName = "",
                jobTitle = "",
                responsibilities = "",
                startDate = "",
                endDate = "",
                reasonForLeaving = ""
            );
        }
        rc.applicant = applicant;
        rc.applicationText = languageService.getText(
            locationKey, getLang(), "applicant"
        );
    }

    function postWorkHistory(rc){
        local.applicant = getApplicantObj();
        applicant.clearWorkHistory();
        for(local.i = 1; i <= maxWorkHistorys; i++){
            if(!structKeyExists(form, "employer#i#")){
                continue;
            }
            if(!len(form["employer#i#"])){
                continue;
            }
            applicant.addWorkHistory(
                form["uuid#i#"],
                form["employer#i#"],
                form["employerPhone#i#"],
                form["supervisor#i#"],
                form["jobTitle#i#"],
                form["responsibilities#i#"],
                form["employmentStart#i#"],
                form["employmentEnd#i#"],
                form["reasonForLeaving#i#"]
            );
        }
        applicant.save();
        fw.redirect(".references");
    }

    function references(rc){
        local.applicant = getApplicantObj();
        for(local.i = arrayLen(applicant.getReferences()) + 1; i <= maxReferences; i++){
            applicant.newRefrence("","","");
        }
        rc.applicant = applicant;
        rc.applicationText = languageService.getText(
            locationKey, getLang(), "applicant"
        );
    }

    function postReferences(rc){
        local.applicant = getApplicantObj();
        applicant.clearReferences();
        for(local.i = 1; i <= maxReferences; i++){
            if(!structKeyExists(form, "name#i#")){
                continue;
            }
            if(!len(form["name#i#"])){
                continue;
            }
            applicant.addRefrence(
                form["uuid#i#"],
                form["name#i#"],
                form["phone#i#"],
                form["relationship#i#"]
            );
        }
        applicant.save();
        emailLetterService.sendToApplicant(
            emailLetterService.read(finishedEmailId),
            applicant,
            emailLetterService.getUnsubscribeURL(fw)
        );
        fw.redirect(".finished");
    }

    function finished(rc){
        local.applicant = getApplicantObj();
        if(hasAllData(applicant))
            applicant.finished();
        applicant.save();
        rc.applicationText = languageService.getText(
            locationKey, getLang(), "applicant"
        );
    }

    /** Returns a new applicant obj or loads current on based on session.applicantId */
    private function getApplicantObj(){
        if(!structKeyExists(session,"positionId")){
            fw.redirect(".applicantType");
        }
        if(StructKeyExists(session, "applicantId")){
            var applicant = applicantService.read(session.applicantId);
        }
        else {
            var applicant = applicantService.create(session.positionId);
        }
        if(!len(applicant.getId())){
            // applicant some how not found, create anew
            applicant = applicantService.create(session.positionId);
        }
        session.applicantId = applicant.getId();
        return applicant;
    }

    private function getLang(){
        param name="cookie.lang" default="en";
        return cookie.lang;

    }

    /* check if we have key data form all pages. */
    private function hasAllData(applicant){
        //applicant data
        if(!len(applicant.getFirstName()))
            return false;
        if(!len(applicant.getLastName))
            return false;
        if(!len(applicant.getEmail()))
            return false;
        if(!applicant.getWorkHistory().len())
            return false;
        if(!applicant.getReferences().len())
            return false;
        return true;
    }

}