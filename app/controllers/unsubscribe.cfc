component accessors="true"{

    property uuidUtility;
    property applicantService;
    property emailLetterService;

    function init(fw){
        variables.fw = fw;
    }

    /** Given a valid applicant id, unsubscribe other wise ask for the users email */
    function default(rc){
        if(!structKeyExists(rc,"a"))
            return;
        try{
            var id = uuidUtility.fromBase64(rc.a);
        }
        catch (any e){
            rc.error = e;
            return;
        }
        var email = emailLetterService.unsubscribeApplicant(
            applicantService.read(id)
        );
        rc.test = local;
        session.unsubscribed = email;
        fw.redirect(".done");
    }

    function byEmail(rc){
        var email = rc.email?:"";
        email = emailLetterService.unsubscribeEmail(email);
        session.unsubscribed = email;
        fw.redirect(".done");
    }

    function done(){
        if(!structKeyExists(session, "unsubscribed"))
            fw.redirect(":unsubscribe");
        rc.email = session.unsubscribed;
    }

}