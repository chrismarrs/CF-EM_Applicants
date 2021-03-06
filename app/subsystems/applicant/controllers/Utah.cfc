component accessors="true" extends="Base" {
    function init( fw ) {
        variables.fw = fw;
        variables.locationKey = "Utah";
        variables.locationId = 1;
        variables.applicantAttrs = [
            "hdyh",
            "hdyhOther",
            "confirmEmail",
            "phone",
            "jobAttractive",
            "englishFluent",
            "bilingual",
            "otherLanguages",
            "counties",
            "license",
            "drivingRecord",
            "transportation",
            "autoInsurance",
            "smartPhone",
            "partOrFull",
            "priorJanitorial",
            "priorJanitorialExplain",
            "lift",
            "startDate",
            "notes",
            "felon"
        ];
        variables.maxWorkHistorys = 3;
        variables.maxReferences = 2;
        variables.finishedEmailId = 1;
    }

}