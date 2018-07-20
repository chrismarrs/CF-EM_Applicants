<cfoutput>
    <form action="#buildURL(".web")#" method="post" data-parsley-validate="">
        <fieldset>
            <legend class="text-center">
                Date Email Sent.
            </legend>
            <div class="row twoColCenter">
                <div class="col-md-6">
                    <label for="endDate">
                        Start
                    </label>
                </div>
                <div class="col-md-6">
                    <input class="datepicker" type="text" placeholder="Start Date..." name="startDate" value="" required>
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
                <input class="datepicker" type="text" placeholder="End Date..." name="endDate" value="" required>
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