<cfoutput>
    <section id="applicantRecords">
        <header>
            <label>
                Email Type:
                <select name="emailId" id="emailId">
                    <option value="">Select an email</option>
                    <cfloop array="#rc.emails#" index="email">
                        <option value="#email.getId()#">#email.getName()#</option>
                    </cfloop>
                </select>
            </label>
            <label>
                Position:
                <select id="position" name="position">
                    <option value="">All</option>
                    <cfloop array="#rc.positions#" index="position">
                        <option value="#position.id#" #rc.position eq position.id?'selected':''#>#position.name#</option>
                    </cfloop>
                </select>
            </label>
            <label>
                Last Name:
                <input type="text" id="lastName" value="#rc.lastName#" autocomplete='off'>
            </label>
            <label class="boxToggle">
                    All
                <input type="checkBox" id="checkAll">
            </label>
        </header>
        <form id="applicantRecords" action="#buildURL(".sendEmail")#" method="post">
            <cfloop array="#rc.applicants#" index="applicant">
                <cfset show = true>
                <cfset show = show && (!len(rc.lastName) or left(applicant.getLastName(), len(rc.lastName)) eq rc.lastName) />
                <cfset show = show && (!len(rc.position) or applicant.getPositionId() eq rc.position) />
                <article class="applicant row" id="#applicant.getId()#" #show?'':'style="display:none"'#>
                    <div class="col-md-12">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <span class="name" data-first-name="#applicant.getFirstName()#" data-last-name="#applicant.getLastName()#">#applicant.getFirstName()# #applicant.getLastName()#</span>
                                    <br>
                                    Applied: #dateFormat(applicant.getDateCreated(),"MM/DD/YYYY")#
                                    (#applicant.getPosition()#)
                                    Franchise: #applicant.getFranchises().name#
                                    <br>
                                </h3>
                                <span class="pull-right email">
                                    <label>
                                        <cfif applicant.isUnsubscribed()>
                                            Unsubscribed <input type="checkBox" disabled="disabled">
                                        <cfelse>
                                            Send Email <input class="cbk_sendEmail" type="checkBox" name="cbk_sendEmail" value="#applicant.getId()#">
                                        </cfif>
                                    </label>
                                </span>
                                <span class="pull-right clickable panel-collapsed"><i class="glyphicon glyphicon-chevron-down"></i></span>
                            </div>
                            <div class="panel-body panel-collapsed" style="display:none">
                                <section class="applicant-details row">
                                    <div class="col-md-4">
                                        Date Available:
                                        <cfif isDate(applicant.getAttr("startDate"))>
                                            #dateFormat(applicant.getAttr("startDate"),"MM/DD/YYYY")#
                                        <cfelse>
                                            #applicant.getAttr("startDate")#
                                        </cfif>
                                        <header>Contact</header>
                                        Phone:
                                        #applicant.getAttr("phone")#
                                        <br>
                                        #applicant.getEmail()#
                                        <br>
                                        #applicant.getAddress()#
                                        <br>
                                        #applicant.getCity()#,
                                        #applicant.getState()#
                                        #applicant.getZipCode()#
                                    </div>
                                    <div class="col-md-4">
                                        <header>Survey Questions</header>
                                        How heard:
                                        #(applicant.getAttr("hdyh") neq "other")?
                                            applicant.getAttr("hdyh"):
                                            applicant.getAttr("hdyhOther")#
                                        <br>
                                        Most Attractive:
                                        #applicant.getAttr("jobAttractive")#
                                        <br>
                                        Work in County:
                                        #listChangeDelims(applicant.getAttr("counties"),", ")#
                                        <br>
                                        Driver's License:
                                        #yesNoFormat(applicant.getAttr("license"))#
                                        <br>
                                        Clean Driving Record:
                                        #yesNoFormat(applicant.getAttr("drivingRecord"))#
                                        <br>
                                        Proper Auto insurance:
                                        #yesNoFormat(applicant.getAttr("autoInsurance"))#
                                        <br>
                                        Smart Phone with Data:
                                        #yesNoFormat(applicant.getAttr("smartPhone"))#
                                        <br>
                                        Part/Full Time:
                                        #applicant.getAttr("partOrFull")#
                                        <br>
                                        Janitorial Experience:
                                        #yesNoFormat(applicant.getAttr("priorJanitorial"))#
                                        #applicant.getAttr("priorJanitorial")?applicant.getAttr("priorJanitorialExplain"):''#
                                        <br>
                                        Lift 45lbs:
                                        #yesNoFormat(applicant.getAttr("lift"))#
                                        <br>
                                        Convicted Felon:
                                        #yesNoFormat(applicant.getAttr("felon"))#
                                    </div>
                                    <div class="col-md-4">
                                        <header>Language</header>
                                        English Fluent:
                                        #yesNoFormat(applicant.getAttr("englishFluent"))#
                                        <br>
                                        Bilingual:
                                        #yesNoFormat(applicant.getAttr("bilingual"))#
                                        <br>
                                        Additional Language:
                                        #applicant.getAttr("otherLanguages")#
                                    </div>
                                </section>
                                <section class="row">
                                    <div class="col-md-4">
                                        <button class="delete" type="button">Delete Applicant</button>
                                    </div>
                                </section>
                                <section class="row">
                                    <cfset wh = applicant.getWorkHistory()>
                                    <header>
                                        Work History
                                    </header>
                                    <div class="col-md-4">
                                        <cfif wh.len() gte 1>
                                            <header>#wh[1].name#</header>
                                            Phone: #wh[1].phone# <br>
                                            Supervisor: #wh[1].supervisorName# <br>
                                            Job Title: #wh[1].jobTitle# <br>
                                            Responsibilities: #wh[1].responsibilities# <br>
                                            Start Date: #dateFormat(wh[1].startDate,"MM/DD/YYYY")# <br>
                                            End Date: #dateFormat(wh[1].endDate,"MM/DD/YYYY")# <br>
                                            Reason For Leaving: #wh[1].reasonForLeaving# <br>
                                        </cfif>
                                    </div>
                                    <div class="col-md-4">
                                        <cfif wh.len() gte 2>
                                            <header>#wh[2].name#</header>
                                            Phone: #wh[2].phone# <br>
                                            Supervisor: #wh[2].supervisorName# <br>
                                            Job Title: #wh[2].jobTitle# <br>
                                            Responsibilities: #wh[2].responsibilities# <br>
                                            Start Date: #dateFormat(wh[2].startDate,"MM/DD/YYYY")# <br>
                                            End Date: #dateFormat(wh[2].endDate,"MM/DD/YYYY")# <br>
                                            Reason For Leaving: #wh[2].reasonForLeaving# <br>
                                        </cfif>
                                    </div>
                                    <div class="col-md-4">
                                        <cfif wh.len() gte 3>
                                            <header>#wh[3].name#</header>
                                            Phone: #wh[3].phone# <br>
                                            Supervisor: #wh[3].supervisorName# <br>
                                            Job Title: #wh[3].jobTitle# <br>
                                            Responsibilities: #wh[3].responsibilities# <br>
                                            Start Date: #dateFormat(wh[3].startDate,"MM/DD/YYYY")# <br>
                                            End Date: #dateFormat(wh[3].endDate,"MM/DD/YYYY")# <br>
                                            Reason For Leaving: #wh[3].reasonForLeaving# <br>
                                        </cfif>
                                    </div>
                                </section>
                                <section class="row">
                                    <cfset ref = applicant.getReferences()>
                                    <header>
                                        References
                                    </header>
                                    <div class="col-md-4">
                                        <cfif ref.len() gte 1>
                                            Name: #ref[1].Name#<br>
                                            Phone: #ref[1].phone#<br>
                                            Relationship: #ref[1].relationship#<br>
                                        </cfif>
                                    </div>
                                    <div class="col-md-4">
                                        <cfif ref.len() gte 2>
                                            Name: #ref[2].Name#<br>
                                            Phone: #ref[2].phone#<br>
                                            Relationship: #ref[2].relationship#<br>
                                        </cfif>
                                    </div>
                                    <div class="col-md-4">
                                        <cfif ref.len() gte 3>
                                            Name: #ref[3].Name#<br>
                                            Phone: #ref[3].phone#<br>
                                            Relationship: #ref[3].relationship#<br>
                                        </cfif>
                                    </div>
                                </section>
                                <section calss="row">
                                    <header>
                                        Applicant Notes
                                    </header>
                                    <div class="col-md-12">
                                        <textarea>#applicant.getAttr("notes")#</textarea>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </article>
            </cfloop>
        </form>
        <button onclick="downloadAsExcel()">
            Export To Excel
        </button>
        <button onclick="sendEmails()">
            Send Email
        </button>
        <cfif rc.canViewDebug>
            <div id="debug"> </div>
        </cfif>
    </section>
    <cfsavecontent variable = "rc.pageJS">
        <script>
            function downloadAsExcel(){
                window.location = "#buildURL(".excel")#?"
                    + "ln=" + $("##lastName").val()
                    + "&c=#rc.city#"
                    + "&sd=#rc.startDate#"
                    + "&ed=#rc.endDate#"
                    + "&p=" + $("##position").val() ;
            }

            function sendEmails(){
                var emailsToSend = $(".cbk_sendEmail:checked").length;
                if(emailsToSend == 0){
                    alert("You have not selected any applicants.  No emails will be sent");
                    return;
                }
                if(!$("##emailId").val().length){
                    alert("Please select an email letter to send");
                    return;
                }

                if(!confirm("You are attempting to send " + emailsToSend
                    + " email" + ( (emailsToSend > 1)?"s":"" )
                    + " to the selected applicants.  Are you sure you want to send an email to these recipients?")){
                    return;
                }
                var ids = $(".cbk_sendEmail:checked").map(function(){
                    return this.value;
                }).get();
                $("##debug").html("");
                $.ajax({
                    url: "#buildURL(".sendEmail")#",
                    method: "POST",
                    data: {
                        returnFormat: "json",
                        emailId: $("##emailId").val(),
                        applicants: ids
                    }
                })
                .done(function(data, textStatus, jqXHR) {
                    alert(data.totalSent + " emails have been sent");
                })
                .fail(function(jqXHR, textStatus, errorThrown) {
                    $("##debug").html(jqXHR.responseText);
                })
                .always(function() {
                });
            }
            $(document).on('click', '.panel-heading span.clickable', function(e){
                var $this = $(this);
                if(!$this.hasClass('panel-collapsed')) {
                    $this.parents('.panel').find('.panel-body').slideUp();
                    $this.addClass('panel-collapsed');
                    $this.find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
                } else {
                    $this.parents('.panel').find('.panel-body').slideDown();
                    $this.removeClass('panel-collapsed');
                    $this.find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
                }
            });

            function filter(){
                var positionText = $("##position option:selected").text().trim();
                var lastName = $("##lastName").val().trim();
                $("article.applicant").each(function(i, applicant){
                    var title = $(applicant).find("h3.panel-title").text().trim();
                    var aLastName = $(applicant).find(".name").get(0).dataset.lastName;
                    var show = true;
                    show = show && (lastName.length == 0 || aLastName.toLowerCase().lastIndexOf(lastName.toLowerCase()) == 0);
                    show = show && (positionText === "All" || title.indexOf(positionText) >= 0);
                    if(show){
                        $(this).show();
                        if(!$(this).find(".cbk_sendEmail").prop("checked"))
                            $(this).find(".cbk_sendEmail").prop("checked",  $("##checkAll").prop("checked"));
                    }
                    else{
                        $(this).hide();
                        $(this).find(".cbk_sendEmail").prop("checked",  false);
                    }
                });

            }

            $(function(){
                $("##position, ##lastName").on("change", filter);
                $("##lastName").on("input", filter);
                $("##checkAll").on("change",function(){
                    var isChecked = $(this).prop("checked");
                    $(".cbk_sendEmail").each(function(i,cb){
                        if($(cb).closest(".applicant").is(":visible")){
                            $(cb).prop("checked", isChecked);
                        }
                    });
                });
                $(".delete").on("click",function(){
                    let applicant = $(this).closest(".applicant");
                    let applicantId = applicant.attr("id");
                    let name = applicant.find(".name").text().trim();
                    if(confirm("Delete applicant: " + name + "?")){
                        $("##debug").html("");
                        $.ajax({
                            url: "#buildURL(".deleteApplicant")#",
                            method: "POST",
                            data: {
                                returnFormat: "json",
                                applicantId: applicantId
                            }
                        })
                        .done(function(data, textStatus, jqXHR) {
                            let applicant = document.getElementById(data.id);
                            if(!applicant)
                                return;
                            applicant.parentNode.removeChild(applicant);
                        })
                        .fail(function(jqXHR, textStatus, errorThrown) {
                            $("##debug").html(jqXHR.responseText);
                        })
                        .always(function() {
                        });
                    }
                });
                $(".applicant textarea").each(function(){
                    var timer = null;
                    $(this).on('propertychange input', function(){
                        var ta = this;
                        if(timer != null)
                            clearTimeout(timer);
                        timer = setTimeout(function(){
                            updateNote(ta);
                        }, 1000);
                    })
                });
                $("##applicantRecords").on("submit", function(e){
                    e.preventDefault();
                    sendEmails();
                });
            });

            function updateNote(textArea){
                let text = textArea.value.trim();
                var applicant = $(textArea).closest(".applicant");
                let applicantId = applicant.attr("id");
                $.ajax({
                    url: "#buildURL(".updateNote")#",
                    method: "POST",
                    data: {
                        returnFormat: "json",
                        applicantId: applicantId,
                        note: text
                    }
                })
                .done(function(data, textStatus, jqXHR) {
                    console.log("Note saved.");
                })
                .fail(function(jqXHR, textStatus, errorThrown) {
                    $("##debug").html(jqXHR.responseText);
                })
                .always(function() {
                });
            }
        </script>
    </cfsavecontent>
</cfoutput>