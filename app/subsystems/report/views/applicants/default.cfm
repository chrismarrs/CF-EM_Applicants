<cfoutput>
    <form action="#buildURL(".web")#" method="post" data-parsley-validate="">
        <fieldset>
            <legend class="text-center">
                Date Applicant Submitted.
            </legend>
            <div class="row twoColCenter">
                <div class="col-md-6">
                    <label for="endDate">
                        Start
                    </label>
                </div>
                <div class="col-md-6">
                    <input class="datepicker" type="text" placeholder="Start Date..." name="startDate" value="">
                </div>
            </div>
        </fieldset>
        <div class="row twoColCenter">
            <div class="col-md-6">
                <label for="endDate">
                    End
                </label>
            </div>
            <div class="col-md-6">
                <input class="datepicker" type="text" placeholder="End Date..." name="endDate" value="">
            </div>
        </div>
        <div class="row twoColCenter">
            <div class="col-md-6">
                <label for="lastName">
                    Last Name
                </label>
            </div>
            <div class="col-md-6">
                <input type="text" id="lastName" name="lastName" value="" placeholder="Last Name...">
            </div>
        </div>
        <div class="row twoColCenter">
            <div class="col-md-6">
                <label for="city">
                    City
                </label>
            </div>
            <div class="col-md-6">
                <input type="text" id="city" name="city" value="" placeholder="City...">
            </div>
        </div>
        <div class="row twoColCenter">
            <div class="col-md-6">
                <label for="position">Position</label>
            </div>
            <div class="col-md-6">
                <select id="position" name="position">
                    <option value="">All</option>
                    <cfloop array="#rc.positions#" index="position">
                        <option value="#position.id#">#position.name#</option>
                    </cfloop>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 text-center">
                <input type="submit" value="Run Report">
            </div>
        </div>
    </form>
</cfoutput>
<cfsavecontent variable="rc.pageJS">
    <script>
        $(function(){
            $(".datepicker")
            .datepicker()
            .on("change", function(e){
               $(this).trigger("input");
            });
        });
    </script>
</cfsavecontent>