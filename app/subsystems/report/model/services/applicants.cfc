component accessors="true" {

    property applicantService;
    property emailLetterService;

    function search(franchiseId, startDate, endDate, lastName="", city = "", position = ""){
        local.applicants = applicantService.getByDateCreated(
            franchiseId,
            startDate,
            endDate
        );
        return applicants.filter(function(applicant){
            if(!applicant.getIsCompleted()){
                return false;
            }
            if(applicant.getDeleted()){
                return false;
            }
            if(len(lastName)){
                if(FindNoCase(lastName, applicant.getLastName()) != 1){
                    return false;
                }
            }
            if(len(city)){
                var isMatch = false;
                var fnc = FindNoCase(city,applicant.getCity());
                //Begins with text
                isMatch = isMatch || (len(city) <= 1 && fnc == 1);
                isMatch = isMatch || (len(city) > 1 && fnc > 0);
                if(!isMatch)
                    return false;
            }
            if(len(position)){
                return applicant.getpositionId() == position;
            }
            return true;
        });
    }

    function getReportAsSpreadsheet(applicants, isXLSX = true){
        local.wb = spreadsheetNew("Applicant Report", isXLSX);
        local.headers = [
            "Franchise",
            "Job Name",
            "Apply Date",
            "How Heard",
            "First Name",
            "Last Name",
            "Address",
            "City",
            "State",
            "Zip",
            "Email",
            "Phone",
            "Most Attractive",
            "Fluent English",
            "Bilingual",
            "Additional Language",
            "Work in County",
            "Driver's License",
            "Clean Driving Record",
            "Proper Auto Insurance",
            "Smart Phone with Data",
            "Part/Full Time",
            "Janitorial Experience",
            "Lift 45lbs",
            "Felony Conviction",
            "Date Available"
        ];
        for(local.i = 1; i <= 3; i++){
            headers.append([
                "Employer #i#",
                "Employer #i# Phone",
                "Employer #i# Supervisor",
                "Employer #i# Job Title",
                "Employer #i# Responsibilities",
                "Employer #i# Start Date",
                "Employer #i# End Date",
                "Employer #i# Reason For Leaving"
            ], true);
        }
        for(local.i = 1; i <= 2; i++){
            headers.append([
                "Reference #i# Name",
                "Reference #i# Phone Number",
                "Reference #i# Relationship"
            ], true);
        }
        headers.append("Notes");
        local.data = [];
        for(local.applicant in applicants){
            local.applicantData = [
                applicant.getFranchises().name,
                applicant.getposition(),
                applicant.getDateCreated(),
                (applicant.getAttr("hdyh") neq "other")?
                    applicant.getAttr("hdyh"):
                    applicant.getAttr("hdyhOther"),
                applicant.getFirstName(),
                applicant.getLastName(),
                applicant.getAddress(),
                applicant.getCity(),
                applicant.getState(),
                applicant.getZipCode(),
                applicant.getEmail(),
                applicant.getAttr("phone"),
                applicant.getAttr("jobAttractive"),
                yesNoFormat(applicant.getAttr("englishFluent")),
                yesNoFormat(applicant.getAttr("bilingual")),
                applicant.getAttr("otherLanguages"),
                listChangeDelims(applicant.getAttr("counties"),", "),
                yesNoFormat(applicant.getAttr("license")),
                yesNoFormat(applicant.getAttr("drivingRecord")),
                yesNoFormat(applicant.getAttr("autoInsurance")),
                yesNoFormat(applicant.getAttr("smartPhone")),
                applicant.getAttr("partOrFull"),
                trim(
                    yesNoFormat(applicant.getAttr("priorJanitorial"))
                    &  (applicant.getAttr("priorJanitorial")?
                        " " & applicant.getAttr("priorJanitorial"):
                        "")
                ),
                yesNoFormat(applicant.getAttr("lift")),
                yesNoFormat(applicant.getAttr("felon")),
                isDate(applicant.getAttr("startDate"))?
                    dateFormat(applicant.getAttr("startDate"),"MM/DD/YYYY")
                    : applicant.getAttr("startDate")
            ];
            local.workHistory = applicant.getWorkHistory();
            for(local.i = 1; i <= 3; i++){
                local.whd = ['','','','','','','',''];
                if(i <= workHistory.len()){
                    whd = [
                        workHistory[i].Name,
                        workHistory[i].phone,
                        workHistory[i].supervisorName,
                        workHistory[i].jobTitle,
                        workHistory[i].responsibilities,
                        workHistory[i].startDate,
                        workHistory[i].endDate,
                        workHistory[i].reasonForLeaving
                    ];
                }
                applicantData.append(whd,true);
            }
            local.references = applicant.getReferences();
            for(local.i = 1; i <= 2; i++){
                local.rd = ['','',''];
                if(i <= references.len()){
                    rd = [
                        references[i].Name,
                        references[i].phone,
                        references[i].Relationship
                    ];
                }
                applicantData.append(rd,true);
            }
            applicantData.append(applicant.getAttr("notes"));
            data.append(applicantData);
        }

        //Text qualify the data
        for(local.x = 1; x <= arrayLen(data); x++ ){
            for(local.y = 1; y <= arrayLen(data[x]); y++){
                data[x][y] = "'#data[x][y]#'";
            }
        }
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

    function sendEmails(letter, applicantIds, unsubscribeURL){
        local.applicants = applicantService.readArray(applicantIds);
        return emailLetterService.sendToApplicants(letter, applicants, unsubscribeURL);
    }

    function delete(applicantId){
        applicantService.delete(applicantId);
        return {id:applicantId};
    }

    function updateNote(applicantId, note){
        var applicant = applicantService.read(applicantId);
        applicant.setAttr("notes", note);
        applicant.save();
        return {"id": applicantId};
    }

}