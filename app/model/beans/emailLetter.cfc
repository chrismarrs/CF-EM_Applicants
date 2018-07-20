component accessors="true" {

    property id;
    property franchiseeId;
    property name;
    property subject;
    property from;
    property body;
    property bodyText;
    property enabled;

    function init(
        id = "",
        franchiseeId = "",
        name = "",
        subject = "", from = "",
        body = "", bodyText = "",
        enabled = ""
    ){
        variables.id = id;
        variables.franchiseeId = franchiseeId;
        variables.name = name;
        variables.subject = subject;
        variables.from = from;
        variables.body = body;
        variables.bodyText = bodyText;
        variables.enabled = enabled;
    }

}