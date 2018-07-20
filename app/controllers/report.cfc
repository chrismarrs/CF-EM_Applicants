component accessors="true" {

    property applicantService;
    property franchiseService;

    function init(fw){
        variables.fw = fw;
    }

    function before(rc){
        if(!session.user.hasPermission("report")){
            fw.redirect("");
        }
    }
}