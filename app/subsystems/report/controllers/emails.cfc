component accessors="true" {

    property emailsService;

    function init(fw){
        variables.fw = fw;
    }

    function before(rc){
        if(!session.user.hasPermission("report")){
            fw.redirect("");
        }
    }

    function web(rc){
        if(!structKeyExists(rc, "startDate") || !structKeyExists(rc, "endDate")){
            fw.redirect(".emails");
        }
        param name="rc.city" default="";
        rc.emailMessages = emailsService.getByDateAndCity(session.user.getFranchiseeId(), rc.startDate, rc.endDate, rc.city);
    }

    function excel(rc){
        local.emailMessages = emailsService.getByDateAndCity(session.user.getFranchiseeId(), rc.sd, rc.ed, rc.c?:"");
        local.wb = emailsService.getReportAsSpreadsheet(emailMessages);
        cfheader(name = "Content-Disposition", value = 'inline; fileName="Applicant-Report.xlsx"');
        cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable="#spreadSheetReadBinary(wb)#");
        abort;
    }
}