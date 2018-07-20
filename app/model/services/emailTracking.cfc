component accessors="true"{

    property beanFactory;
    property applicantService;
    property emailLetterService;

    public function init(){}

    public function create(){
        throw("Not yet implemented");
    }
    public function read(){
        throw("Not yet implemented");
    }
    public function write(){
        throw("Not yet implemented");
    }
    public function delete(){
        throw("Not yet implemented");
    }

    public function getApplicantEmailsByDate(required franchiseeId, required startDate, required endDate){
        var sd = CreateDateTime(year(startDate), month(startDate), day(startDate), 0, 0, 0);
        var ed = CreateDateTime(year(endDate), month(endDate), day(endDate), 23, 59, 59);

        var qTrackings = queryExecute("
            select eat.msg_id, eat.applicant_id, eat.sent
            from email_applicant_tracking eat
            join applicant a
                on eat.applicant_id = a.id
            join positions p
                on a.position = p.id
            where eat.sent between :sd and :ed
            and p.franchisee_id = :franchiseeId
            order by sent
        ",{
            sd: {
                CFSQLType: "cf_sql_timestamp",
                value: sd
            },
            ed: {
                CFSQLType: "cf_sql_timestamp",
                value: ed
            },
            franchiseeId: {
                CFSQLType: "int",
                value: franchiseeId
            }
        });
        var applicantIds = [];
        var letterIds = [];
        qTrackings.each(function(tracking){
            applicantIds.append(tracking["applicant_id"]);
            letterIds.append(tracking["msg_id"]);
        });

        var applicants = applicantService.readArray(applicantIds);
        var letters = emailLetterService.readArray(letterIds);
        var records = [];
        qTrackings.each(function(tracking,i){
            var record = beanFactory.getBean("emailTrackingBean");
            record.setApplicant(applicants[i]);
            record.setLetter(letters[i]);
            record.setSent(tracking.sent);
            records.append(record);
        });
        return records;

    }

}
