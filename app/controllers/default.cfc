component {

    function init(fw){
        variables.fw = fw;
    }
    /* point the applicant to the correct franchise based on domain used */
    function default(rc){
        if(cgi.HTTP_HOST.findNoCase("work4em.com")){
            fw.redirect("applicant:Utah");
        }
        if(cgi.HTTP_HOST.findNoCase("jobs.emkansascity.com")){
            fw.redirect("applicant:KansasCity");
        }
        if(cgi.HTTP_HOST.findNoCase("devemutah.solutionsatwork.com")){
            fw.redirect("applicant:KansasCity");
        }
        fw.redirect("applicant:Utah");
    }

}