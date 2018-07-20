component accessors="true" {

    property applicantsService;
    property emailLetterService;
    property positionService;

    function init(fw){
        variables.fw = fw;
    }

    function before(rc){
        if(!session.user.hasPermission("report")){
            fw.redirect("");
        }
    }
    function default(){
        //Hard coding for Utha. Will need to get the users franchise/s at some point.
        rc.positions = positionService.getForFranchisee(session.user.getFranchiseeId());
    }

    function web(rc){
        param name="rc.position" default="";
        if(!structKeyExists(rc, "startDate") || !structKeyExists(rc, "endDate")){
            fw.redirect(".applicant");
        }
        param name="rc.city" default="";
        rc.applicants = applicantsService.search(session.user.getFranchiseeId(), rc.startDate, rc.endDate, '', rc.city);
        rc.emails = emailLetterService.readAll(session.user.getFranchiseeId());
        //Hard coding for Utha. Will need to get the users franchise/s at some point.
        rc.positions = positionService.getForFranchisee(session.user.getFranchiseeId());
        rc.canViewDebug = session.user.hasPermission("admin");
    }

    function excel(rc){
        local.applicants = applicantsService.search(session.user.getFranchiseeId(), rc.sd, rc.ed, rc.ln, rc.c, rc.p);
        local.wb = applicantsService.getReportAsSpreadsheet(applicants);
        cfheader(name = "Content-Disposition", value = 'inline; fileName="Applicant-Report.xlsx"');
        cfcontent(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", variable="#spreadSheetReadBinary(wb)#");
        abort;
    }

    function sendEmail(rc){
        param name="rc.returnFormat" default="json";
        local.emailsSent = applicantsService.sendEmails(
            emailLetterService.read(rc.emailId),
            listToArray(rc["APPLICANTS[]"]),
            unsubscribeURL()
        );
        fw.renderData()
        .data({
            "totalSent": emailsSent
        })
        .type(rc.returnFormat);
    }

    function deleteapplicant(rc){
        fw.renderData()
        .data(applicantsService.delete(rc.applicantId))
        .type(rc.returnFormat);
    }

    function updateNote(rc){
        fw.renderData()
        .data(applicantsService.updateNote(rc.applicantId, rc.note))
        .type(rc.returnFormat);
    }

    private function unsubscribeURL(){
        return "http://"
            & cgi.HTTP_HOST
            & fw.buildURL(":unsubscribe");
    }
}