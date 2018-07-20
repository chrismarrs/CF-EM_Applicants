<cfoutput>
    <cfset appText = rc.applicationText />
    <cfset applicant = rc.applicant />
    <form id="Utah-application" name="applicant" action="#buildURL(".postApplicant")#" data-parsley-validate="" method="post">
        <h1 class="text-center">
            APPLY NOW!
        </h1>
        <p>
            #appText.jobSummary#
        </p>
        <fieldset class="row">
            <div class="col-md-8">
                <label for="hdyh">
                    #appText.hdyh.label#
                </label>
                <div id="hdyhError"></div>
            </div>
            <div class="col-md-4">
                <select id="hdyh" name="hdyh" required=""
                    class="chosen-select"
                    data-placeholder="#appText.hdyh.placeholder#"
                    data-parsley-errors-container="##hdyhError"
                    data-parsley-required-message="#appText.hdyh.required#">
                    <option value=""></option>
                    <cfloop array="#appText.hdyh.responses#" index="response">
                        <option value="#response.value#" #(applicant.getAttr("hdyh") eq response.value)?'selected':''#>
                            #response.text#
                        </option>
                    </cfloop>
                </select>
            </div>
        </fieldset>
        <fieldset class="row hdyhOther hidden" >
            <div class="col-md-8">
                <label for="hdyhOther">
                    #appText.hdyhOther.label#
                </label>
                <div id="hdyhOtherError"></div>
            </div>
            <div class="col-md-4">
                <input type="text" id="hdyhOther" name="hdyhOther"
                    value="#applicant.getAttr("hdyhOther")#"
                    placeholder="#appText.hdyhOther.placeholder#"
                    data-parsley-errors-container="##hdyhOtherError"
                    data-parsley-required-message="#appText.hdyhOther.required#">
                </input>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-6">
                <label for="firstName">#appText.firstName.label#</label>
                <input type="text" id="firstName" name="firstName" required=""
                    value="#applicant.getFirstName()#"
                    placeholder="#appText.firstName.placeholder#"
                    data-parsley-errors-container="##firstNameError"
                    data-parsley-required-message="#appText.firstName.required#">
                <div id="firstNameError">
                </div>
            </div>
            <div class="col-md-6">
                <label for="lastName">#appText.lastName.label#</label>
                <input type="text" id="lastName" name="lastName" required=""
                    value="#applicant.getLastName()#"
                    placeholder="#appText.lastName.placeholder#"
                    data-parsley-errors-container="##lastNameError"
                    data-parsley-required-message="#appText.lastname.required#">
                <div id="lastNameError">
                </div>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-6">
                <label for="email">#appText.email.label#</label>
                <input type="email" id="email" name="email" required=""
                    value="#applicant.getEmail()#"
                    placeholder="#appText.email.placeholder#"
                    data-parsley-errors-container="##emailError"
                    data-parsley-required-message="#appText.email.required#"
                    data-parsley-type-message="#appText.email.type#">
                <div id="emailError">
                </div>
            </div>
            <div class="col-md-6">
                <label for="confirmEmail">#appText.confirmEmail.label#</label>
                <input type="email" id="confirmEmail" name="confirmEmail" required=""
                    value="#applicant.getAttr("confirmEmail")#"
                    placeholder="#appText.confirmEmail.placeholder#"
                    data-parsley-errors-container="##confirmEmailError"
                    data-parsley-required-message="#appText.confirmEmail.required#">
                <div id="confirmEmailError">
                </div>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-6">
                <label for="phone">#appText.phone.label#</label>
                <input type="text" id="phone" name="phone" required=""
                    value="#applicant.getAttr("phone")#"
                    placeholder="#appText.phone.placeholder#"
                    data-parsley-pattern="^[\d\+\-\.\(\)\/\s]*$"
                    data-parsley-pattern-message="#appText.phone.pattern#"
                    data-parsley-errors-container="##phoneError"
                    data-parsley-required-message="#appText.phone.required#">
                <div id="phoneError">
                </div>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-6">
                <label for="address">#appText.address.label#</label>
                <input type="text" id="address" name="address" required=""
                    value="#applicant.getAddress()#"
                    placeholder="#appText.address.placeholder#"
                    data-parsley-errors-container="##addressError"
                    data-parsley-required-message="#appText.address.required#">
                <div id="addressError">
                </div>
            </div>
        </fieldset>
        <fieldset class="row">
            <div class="col-md-5">
                <label for="city">#appText.city.label#</label>
                <input type="text" id="city" name="city" required=""
                    value="#applicant.getCity()#"
                    placeholder="#appText.city.placeholder#"
                    data-parsley-errors-container="##cityError"
                    data-parsley-required-message="#appText.city.required#">
                <div id="cityError">
                </div>
            </div>
            <div class="col-md-3">
                <label for="state">#appText.state.label#</label>
                <select id="state" name="state" required=""
                    class="chosen-select"
                    data-placeholder="#appText.state.placeholder#"
                    data-parsley-errors-container="##stateError"
                    data-parsley-required-message="#appText.state.required#">
                    <option value=""></option>
                    <option value="UT" #(applicant.getState() eq "UT")?'selected':''#>Utah</option>
                    <cfloop array="#rc.stateList#" index="state">
                        <cfif state.abbr eq "UT">
                            <cfcontinue />
                        </cfif>
                        <option value="#state.abbr#" #(applicant.getState() eq state.abbr)?'selected':''#>
                            #state.name#
                        </option>
                    </cfloop>
                </select>
                <div id="stateError">
                </div>
            </div>
            <div class="col-md-4">
                <label for="zipCode">#appText.zipCode.label#</label>
                <input type="text" id="zipCode" name="zipCode" required=""
                    value="#applicant.getZipCode()#"
                    maxlength="10"
                    placeholder="#appText.zipCode.placeholder#"
                    data-parsley-errors-container="##zipCodeError"
                    data-parsley-required-message="#appText.zipCode.required#">
                <div id="zipCodeError">
                </div>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <label for="jobAttractive">
                    #appText.jobAttractive.label#
                </label>
                <div id="jobAttractiveError"></div>
            </div>
            <div class="col-md-4">
                <select id="jobAttractive" name="jobAttractive" required=""
                    class="chosen-select"
                    data-placeholder="#appText.jobAttractive.placeholder#"
                    data-parsley-errors-container="##jobAttractiveError"
                    data-parsley-required-message="#appText.jobAttractive.required#">
                    <option value=""></option>
                    <cfloop array="#appText.jobAttractive.responses#" index="response">
                        <option value="#response.value#" #(applicant.getAttr("jobAttractive") eq response.value)?'selected':''# >
                            #response.text#
                        </option>
                    </cfloop>
                </select>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.englishFluent.legend#</legend>
                <div id="englishFluentError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.englishFluent.yes#
                    <input type="radio" id="englishFluentYes" name="englishFluent"
                    value="1" #(applicant.getAttr("englishFluent") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##englishFluentError"
                    data-parsley-required-message="#appText.englishFluent.required#">
                </label>
                <label>#appText.englishFluent.no#
                    <input type="radio" id="englishFluentNo" name="englishFluent"
                    value="0" #(applicant.getAttr("englishFluent") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##englishFluentError"
                    data-parsley-required-message="#appText.englishFluent.required#">
                </label>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.bilingual.legend#</legend>
                <div id="bilingualError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.bilingual.yes#
                    <input type="radio" id="bilingualYes" name="bilingual"
                    value="1" #(applicant.getAttr("bilingual") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##bilingualError"
                    data-parsley-required-message="#appText.bilingual.required#">
                </label>
                <label>#appText.bilingual.no#
                    <input type="radio" id="bilingualNo" name="bilingual"
                    value="0" #(applicant.getAttr("bilingual") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##bilingualError"
                    data-parsley-required-message="#appText.bilingual.required#">
                </label>
            </div>
        </fieldset>
        <fieldset class="row otherLanguages hidden" >
            <div class="col-md-8">
                <label for="otherLanguages">
                    #appText.otherLanguages.label#
                </label>
                <div id="otherLanguagesError"></div>
            </div>
            <div class="col-md-4">
                <input type="text" id="otherLanguages" name="otherLanguages"
                    value="#applicant.getAttr("otherLanguages")#"
                    placeholder="#appText.otherLanguages.placeholder#"
                    data-parsley-errors-container="##otherLanguagesError"
                    data-parsley-required-message="#appText.otherLanguages.required#">
                </input>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <label for="counties">
                    #appText.counties.label#
                </label>
                <div id="countiesError"></div>
            </div>
            <div class="col-md-4">
                <select id="counties" name="counties" required=""
                    class="chosen-select" multiple
                    data-placeholder="#appText.counties.placeholder#"
                    data-parsley-errors-container="##countiesError"
                    data-parsley-required-message="#appText.counties.required#">
                    <option value=""></option>
                    <cfloop array="#appText.counties.responses#" index="response">
                        <option value="#response.value#" #ListContains(applicant.getAttr("counties"),response.value)?'selected':''#>
                            #response.text#
                        </option>
                    </cfloop>
                </select>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.license.legend#</legend>
                <div id="licenseError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.license.yes#
                    <input type="radio" id="licenseYes" name="license"
                    value="1" #(applicant.getAttr("license") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##licenseError"
                    data-parsley-required-message="#appText.license.required#">
                </label>
                <label>#appText.license.no#
                    <input type="radio" id="licenseNo" name="license"
                    value="0" #(applicant.getAttr("license") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##licenseError"
                    data-parsley-required-message="#appText.license.required#">
                </label>
            </div>

        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.drivingRecord.legend#</legend>
                <div id="drivingRecordError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.drivingRecord.yes#
                    <input type="radio" id="drivingRecordYes" name="drivingRecord"
                    value="1" #(applicant.getAttr("drivingRecord") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##drivingRecordError"
                    data-parsley-required-message="#appText.drivingRecord.required#">
                </label>
                <label>#appText.drivingRecord.no#
                    <input type="radio" id="drivingRecordNo" name="drivingRecord"
                    value="0" #(applicant.getAttr("drivingRecord") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##drivingRecordError"
                    data-parsley-required-message="#appText.drivingRecord.required#">
                </label>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.transportation.legend#</legend>
                <div id="transportationError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.transportation.yes#
                    <input type="radio" id="transportationYes" name="transportation"
                    value="1" #(applicant.getAttr("transportation") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##transportationError"
                    data-parsley-required-message="#appText.transportation.required#">
                </label>
                <label>#appText.transportation.no#
                    <input type="radio" id="transportationNo" name="transportation"
                    value="0" #(applicant.getAttr("transportation") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##transportationError"
                    data-parsley-required-message="#appText.transportation.required#">
                </label>
            </div>
        </fieldset>
        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.autoInsurance.legend#</legend>
                <div id="autoInsuranceError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.autoInsurance.yes#
                    <input type="radio" id="autoInsuranceYes" name="autoInsurance"
                    value="1" #(applicant.getAttr("autoInsurance") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##autoInsuranceError"
                    data-parsley-required-message="#appText.autoInsurance.required#">
                </label>
                <label>#appText.autoInsurance.no#
                    <input type="radio" id="autoInsuranceNo" name="autoInsurance"
                    value="0" #(applicant.getAttr("autoInsurance") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##autoInsuranceError"
                    data-parsley-required-message="#appText.autoInsurance.required#">
                </label>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.smartPhone.legend#</legend>
                <div id="smartPhoneError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.smartPhone.yes#
                    <input type="radio" id="smartPhoneYes" name="smartPhone"
                    value="1" #(applicant.getAttr("smartPhone") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##smartPhoneError"
                    data-parsley-required-message="#appText.smartPhone.required#">
                </label>
                <label>#appText.smartPhone.no#
                    <input type="radio" id="smartPhoneNo" name="smartPhone"
                    value="0" #(applicant.getAttr("smartPhone") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##smartPhoneError"
                    data-parsley-required-message="#appText.smartPhone.required#">
                </label>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.partOrFull.legend#</legend>
                <div id="partOrFullError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.partOrFull.partTime#
                    <input type="radio" id="partTime" name="partOrFull"
                    value="Part Time" #(applicant.getAttr("partOrFull") eq "Part Time")?'checked':''# required=""
                    data-parsley-errors-container="##partOrFullError"
                    data-parsley-required-message="#appText.partOrFull.required#">
                </label>
                <label>#appText.partOrFull.fullTime#
                    <input type="radio" id="fullType" name="partOrFull"
                    value="Full Time" #(applicant.getAttr("partOrFull") eq "Full Time")?'checked':''# required=""
                    data-parsley-errors-container="##partOrFullError"
                    data-parsley-required-message="#appText.partOrFull.required#">
                </label>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.priorJanitorial.legend#</legend>
                <div id="priorJanitorialError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.priorJanitorial.yes#
                    <input type="radio" id="priorJanitorialYes" name="priorJanitorial"
                    value="1" #(applicant.getAttr("priorJanitorial") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##priorJanitorialError"
                    data-parsley-required-message="#appText.priorJanitorial.required#">
                </label>
                <label>#appText.priorJanitorial.no#
                    <input type="radio" id="priorJanitorialNo" name="priorJanitorial"
                    value="0" #(applicant.getAttr("priorJanitorial") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##priorJanitorialError"
                    data-parsley-required-message="#appText.priorJanitorial.required#">
                </label>
            </div>
        </fieldset>
        <fieldset class="row hidden priorJanitorialExplain">
            <div class="col-md-8">
                <label for="priorJanitorialExplain">#appText.priorJanitorialExplain.label#</label>
                <div id="priorJanitorialExplainError"></div>
            </div>
            <div class="col-md-4">
                <input type="text" id="priorJanitorialExplain" name="priorJanitorialExplain"
                    value="#applicant.getAttr("priorJanitorialExplain")#"
                    placeholder="#appText.priorJanitorialExplain.placeholder#"
                    data-parsley-errors-container="##priorJanitorialExplainError"
                    data-parsley-required-message="#appText.priorJanitorialExplain.required#">
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.lift.legend#</legend>
                <div id="liftError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.lift.yes#
                    <input type="radio" id="liftYes" name="lift"
                    value="1" #(applicant.getAttr("lift") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##liftError"
                    data-parsley-required-message="#appText.lift.required#">
                </label>
                <label>#appText.lift.no#
                    <input type="radio" id="liftNo" name="lift"
                    value="0" #(applicant.getAttr("lift") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##liftError"
                    data-parsley-required-message="#appText.lift.required#">
                </label>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <legend>#appText.felon.legend#</legend>
                <div id="felonError"></div>
            </div>
            <div class="col-md-4">
                <label>#appText.felon.yes#
                    <input type="radio" id="felonYes" name="felon"
                    value="1" #(applicant.getAttr("felon") eq 1)?'checked':''# required=""
                    data-parsley-errors-container="##felonError"
                    data-parsley-required-message="#appText.felon.required#">
                </label>
                <label>#appText.felon.no#
                    <input type="radio" id="felonNo" name="felon"
                    value="0" #(applicant.getAttr("felon") eq 0)?'checked':''# required=""
                    data-parsley-errors-container="##felonError"
                    data-parsley-required-message="#appText.felon.required#">
                </label>
            </div>
        </fieldset>

        <fieldset class="row">
            <div class="col-md-8">
                <label for="startDate">#appText.startDate.label#</label>
                <div id="startDateError"></div>
            </div>
            <div class="col-md-4">
                <input type="text" id="startDate" name="startDate"
                    value="#dateFormat(applicant.getAttr("startDate"),"MM/DD/YYYY")#"
                    placeholder="#appText.startDate.placeholder#"
                    class="startDatePicker"
                    required=""
                    data-parsley-errors-container="##startDateError"
                    data-parsley-required-message="#appText.startDate.required#">
            </div>
        </fieldset>
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
            $("#hdyh").on("change",function(){
                if(this.value === "Other"){
                    $("fieldset.hdyhOther").removeClass("hidden");
                    $("#hdyhOther").attr("required", "");
                }
                else{
                    $("fieldset.hdyhOther").addClass("hidden");
                    $("#hdyhOther").removeAttr("required");
                }
                $("#hdyhOther").trigger("input");

            });
            $("input[type=radio][name=priorJanitorial]").on("change",function(){
                if(this.value === "1"){
                    $("fieldset.priorJanitorialExplain").removeClass("hidden");
                    $("#priorJanitorialExplain").attr("required", "");
                }
                else{
                    $("fieldset.priorJanitorialExplain").addClass("hidden");
                    $("#priorJanitorialExplain").removeAttr("required");
                }
                $("#hdyhOther").trigger("input");

            });
            $("input[type=radio][name=bilingual], input[type=radio][name=englishFluent]").on("change",function(){
                otherLanguage();
            });
            $(".chosen-select").chosen({
                width: "100%",
                disable_search_threshold: 10
            }).on('change', function(){
                //Send envent to parsley;
                $(this).trigger("input");
            });
            $(".startDatePicker").datepicker({
                minDate:0,
                showOn: "button",
                buttonText: "Calendar"
            })
            .next('button').button({
                icons: {
                    primary: "ui-icon-calendar"
                }, text:false
            })
            .on('change', function(){
                //Send envent to parsley;
                $(this).trigger("input");
            });
            updateFields();
        });

        function updateFields(){
            $("#hdyh").trigger("change");
            $("input[type=radio][name=priorJanitorial]").trigger("change");
            $("input[type=radio][name=bilingual]").trigger("change");
        }

        function otherLanguage(){
            var display =  $("input[type=radio][name=bilingual]:checked").val() == 1;
            display = display || $("input[type=radio][name=englishFluent]:checked").val() == 0;
            if(display){
                $("fieldset.otherLanguages").removeClass("hidden");
                $("#otherLanguages").attr("required", "");
            }
            else{
                $("fieldset.otherLanguages").addClass("hidden");
                $("#otherLanguages").removeAttr("required");
            }
            $("#hdyhOther").trigger("input");
        }
    </script>
</cfsavecontent>