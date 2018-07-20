component accessors="true" {

    property applicantService;
    property franchiseService;
    property positionService;

    property id;
    property positionId;
    property firstName;
    property lastName;
    property address;
    property city;
    property state;
    property zipCode;
    property email;
    property isCompleted;
    property deleted;
    property dateCreated;

    property unsubscribed;

    property attributes;
    property references;
    property workHistory;

    function init(){
        variables.attributes = {};
        variables.references = [];
        variables.workHistory = [];
    }

    function setAttr(attrKey, value){
        attributes[lcase(attrKey)] = value;
    }

    function getAttr(attrKey){
        attrKey = lcase(attrKey);
        if(!StructKeyExists(attributes, attrKey)){
            return "";
        }
        return attributes[attrKey];
    }

    function isUnsubscribed(){
        return isDate(variables.unsubscribed);
    }

    function save(){
        applicantService.update(this);
    }

    function delete(){
        applicantService.delete(id);
    }

    function clearReferences(){
        references = [];
    }

    function newRefrence (name, phone, relationship){
        addRefrence(createUUID(), name, phone, relationship);
    }

    function addRefrence(id, name, phone, relationship){
        arrayAppend(references,{
            id = id,
            name = name,
            phone = phone,
            relationship = relationship
        });
    }

    function clearWorkHistory(){
        workHistory = [];
    }

    function newWorkHistory(name, phone, supervisorName, jobTitle, responsibilities, startDate, endDate, reasonForLeaving){
        addWorkHistory(createUUID(), name, phone, supervisorName, jobTitle, responsibilities, startDate, endDate, reasonForLeaving);
    }

    function addWorkHistory(id, name, phone, supervisorName, jobTitle, responsibilities, startDate, endDate, reasonForLeaving){
        arrayAppend(workHistory,{
            id = createUUID(),
            name = name,
            phone = phone,
            supervisorName = supervisorName,
            jobTitle = jobTitle,
            responsibilities = responsibilities,
            startDate = startDate,
            endDate = endDate,
            reasonForLeaving = reasonForLeaving
        });
    }

    function finished(){
        isCompleted = 1;
    }

    function getFranchises(){
        return franchiseService.getFranchisesById(getFranchisee());
    }

    function getFranchisee(){
        return positionService.getPosition(positionId).franchiseeId;
    }

    function getPosition(){
        return positionService.getPosition(positionId).name;
    }

}