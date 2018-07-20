<cfoutput>
    <cfset appText = rc.applicationText />
    <cfset wh = rc.applicant.getWorkHistory() />
    <form id="Utah-application" name="workHistory" action="#buildURL(".postWorkHistory")#" method="post" data-parsley-validate="">
        <article id="workHistory">
            <header class="text-center">#
                appText.workHistory.header#
                <br>
                <small>#appText.workHistory.subHeader#</small>
            </header>
            <cfloop index = "i" from = "1" to = "#arrayLen(wh)#">
                <section class="workHistory" data-employer-idx="#i#">
                    <input type="hidden" name="uuid#i#" value="#wh[i].id#" />
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="employer#i#">#appText.workHistory.employer.label#</label>
                            <div id="employer#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="employer#i#" name="employer#i#" required=""
                                value="#wh[i].name#"
                                placeholder="#appText.workHistory.employer.placeholder#"
                                data-parsley-errors-container="##employer#i#Error"
                                data-parsley-required-message="#appText.workHistory.employer.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="employerPhone#i#">#appText.workHistory.employerPhone.label#</label>
                            <div id="employerPhone#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="employerPhone#i#" name="employerPhone#i#" required=""
                                value="#wh[i].phone#"
                                placeholder="#appText.workHistory.employerPhone.placeholder#"
                                placeholder="#appText.workHistory.employerPhone.placeholder#"
                                data-parsley-pattern="^[\d\+\-\.\(\)\/\s]*$"
                                data-parsley-pattern-message="#appText.workHistory.employerPhone.pattern#"
                                data-parsley-errors-container="##employerPhone#i#Error"
                                data-parsley-required-message="#appText.workHistory.employerPhone.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="supervisor#i#">#appText.workHistory.supervisor.label#</label>
                            <div id="supervisor#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="supervisor#i#" name="supervisor#i#" required=""
                                value="#wh[i].supervisorName#"
                                placeholder="#appText.workHistory.supervisor.placeholder#"
                                data-parsley-errors-container="##supervisor#i#Error"
                                data-parsley-required-message="#appText.workHistory.supervisor.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="jobTitle#i#">#appText.workHistory.jobTitle.label#</label>
                            <div id="jobTitle#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="jobTitle#i#" name="jobTitle#i#" required=""
                                value="#wh[i].jobTitle#"
                                placeholder="#appText.workHistory.jobTitle.placeholder#"
                                data-parsley-errors-container="##jobTitle#i#Error"
                                data-parsley-required-message="#appText.workHistory.jobTitle.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="responsibilities#i#">#appText.workHistory.responsibilities.label#</label>
                            <div id="responsibilities#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="responsibilities#i#" name="responsibilities#i#" required=""
                                value="#wh[i].responsibilities#"
                                placeholder="#appText.workHistory.responsibilities.placeholder#"
                                data-parsley-errors-container="##responsibilities#i#Error"
                                data-parsley-required-message="#appText.workHistory.responsibilities.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="employmentStart#i#">#appText.workHistory.employmentStart.label#</label>
                            <div id="employmentStart#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="employmentStart#i#" name="employmentStart#i#" required=""
                                value="#dateFormat(wh[i].startDate,"MM/DD/YYYY")#"
                                data-employer-id="#i#" class="employmentStartDate"
                                placeholder="#appText.workHistory.employmentStart.placeholder#"
                                data-parsley-errors-container="##employmentStart#i#Error"
                                data-parsley-required-message="#appText.workHistory.employmentStart.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="employmentEnd#i#">#appText.workHistory.employmentEnd.label#</label>
                            <br>
                            Leave empty if still employed
                            <div id="employmentEnd#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="employmentEnd#i#" name="employmentEnd#i#"
                                value="#dateFormat(wh[i].endDate,"MM/DD/YYYY")#"
                                placeholder="#appText.workHistory.employmentEnd.placeholder#"
                                data-employer-id="#i#" class="employmentEndDate"
                                data-parsley-errors-container="##employmentEnd#i#Error"
                                data-parsley-required-message="#appText.workHistory.employmentEnd.required#">
                        </div>
                    </fieldset>
                    <fieldset class="row">
                        <div class="col-md-8">
                            <label for="reasonForLeaving#i#">#appText.workHistory.reasonForLeaving.label#</label>
                            <div id="reasonForLeaving#i#Error"></div>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="reasonForLeaving#i#" name="reasonForLeaving#i#" required=""
                                value="#wh[i].reasonForLeaving#"
                                placeholder="#appText.workHistory.reasonForLeaving.placeholder#"
                                data-parsley-errors-container="##reasonForLeaving#i#Error"
                                data-parsley-required-message="#appText.workHistory.reasonForLeaving.required#">
                        </div>
                    </fieldset>
                    <hr>
                </section>
            </cfloop>
        </article>
        <div class="row">
            <div class="col-md-12 text-center">
                <input type="submit" name="submit" value="SUBMIT" />
            </div>
        </div>
    </form>
</cfoutput>
<cfsavecontent variable = "rc.pageJS">
    <script>
        $(function(){
            $(".employmentStartDate").each(function(){
                var startDate = $(this);
                var endDate = $("#employmentEnd" + startDate.data("employerId"));
                startDate.datepicker({
                    showOn: "button",
                    buttonText: "Calendar",
                    changeMonth: true,
                    changeYear: true
                })
                .on("change", function(){
                    endDate.datepicker("option", "minDate", getDate(this))
                    .next('button').button({
                        icons: {
                            primary: "ui-icon-calendar"
                        },
                        text:false
                    });
                    $(this).trigger("input");
                })
                .next('button').button({
                    icons: {
                        primary: "ui-icon-calendar"
                    },
                    text:false
                });
                endDate.datepicker({
                    showOn: "button",
                    buttonText: "Calendar",
                    changeMonth: true,
                    changeYear: true
                })
                .on("change", function(){
                    startDate.datepicker("option", "maxDate", getDate(this))
                    .next('button').button({
                        icons: {
                            primary: "ui-icon-calendar"
                        },
                        text:false
                    });
                    $(this).trigger("input");
                })
                .next('button').button({
                    icons: {
                        primary: "ui-icon-calendar"
                    }, text:false
                });
            });
            $(".workHistory").each(function(index, section){
                var employerIdx = $(section).data("employerIdx");
                if(employerIdx === 1){
                    return;
                }
                $("#employer"+employerIdx).on("change", function(){
                    toggleHistory(employerIdx);
                });
                $("#employer"+employerIdx).trigger("change");
            });
        });

        function getDate(input){
            try {
                return $.datepicker.parseDate("mm/dd/yy", input.value);
            }
            catch (e){
                return null;
            }
        }

        function toggleHistory(employerIdx){
            if($("#employer" + employerIdx).val().length === 0){
                $("#employer" + employerIdx).removeAttr("required");
                $("#employerPhone" + employerIdx).removeAttr("required").trigger("input");
                $("#supervisor" + employerIdx).removeAttr("required").trigger("input");
                $("#jobTitle" + employerIdx).removeAttr("required").trigger("input");
                $("#responsibilities" + employerIdx).removeAttr("required").trigger("input");
                $("#employmentStart" + employerIdx).removeAttr("required").trigger("input");
                $("#employmentEnd" + employerIdx).removeAttr("required").trigger("input");
                $("#reasonForLeaving" + employerIdx).removeAttr("required").trigger("input");
            }
            else{
                $("#employer" + employerIdx).attr("required", "");
                $("#employerPhone" + employerIdx).attr("required", "").trigger("input");
                $("#supervisor" + employerIdx).attr("required", "").trigger("input");
                $("#jobTitle" + employerIdx).attr("required", "").trigger("input");
                $("#responsibilities" + employerIdx).attr("required", "").trigger("input");
                $("#employmentStart" + employerIdx).attr("required", "").trigger("input");
                $("#employmentEnd" + employerIdx).attr("required", "").trigger("input");
                $("#reasonForLeaving" + employerIdx).removeAttr("required").trigger("input");
            }
        }
    </script>
</cfsavecontent>