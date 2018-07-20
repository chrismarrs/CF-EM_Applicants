component accessors="true" {

    property applicantService;
    property emailLetterService;
    property emailTrackingService;

    function getByDateAndCity(franchiseeId, startDate, endDate, city){
        var trakings = emailTrackingService.getApplicantEmailsByDate(
            franchiseeId,
            startDate,
            endDate
        );
        return trakings.filter(function(tracking){
            if(!len(city)){
                return true;
            }
            var city = tracking.getApplicant.getCity();
            return FindNoCase(city, city) == 1;
        });
    }

    function getReportAsSpreadsheet(emailMessages, isXLSX = true){
        var wb = spreadsheetNew("Applicant Report", isXLSX);
        var headers = [
            "First Name",
            "Last Name",
            "City",
            "State",
            "Zip",
            "Email",
            "Send Date",
            "Email Name"
        ];
        var data = [];

        emailMessages.each(function(msg){
            var applicant = msg.getApplicant();
            data.append([
                applicant.getFirstName(),
                applicant.getLastName(),
                applicant.getCity(),
                applicant.getState(),
                applicant.getZipCode(),
                applicant.getEmail(),
                dateFormat(msg.getSent(),"MM/DD/YYYY"),
                msg.getLetter().getName()
            ]);
        });

        spreadsheetAddRow(wb, headers.toList());
        for(local.d in data){
            spreadsheetAddRow(wb, d.toList());
        }

        headers.each(function(name, i){
            if(FindNoCase("Date", name))
                spreadsheetFormatColumn(wb,{
                    dataformat: "MM/DD/YYYY"
                }, i);
        });
        return wb;
    }

}