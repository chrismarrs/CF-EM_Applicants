<cfoutput>
    <article id="landing-page" class="container-fluid">
        <section class="text-center">
            <header>
                Thank you for your interest in a career at Enviro-Master!
                <br>
                What position are you looking for?
            </header>
            <cfif rc.positions.len()>
                <select id="position" data-placeholder="Available Positions">
                    <option value=""></option>
                    <cfloop array="#rc.positions#" index="position">
                        <option value="#position.id#">#position.name#</option>
                    </cfloop>
                </select>
            </cfif>
        </section>
        <cfif rc.positions.len()>
            <cfloop array="#rc.positions#" index="position">
                <section class="position" id="p#position.id#" style="display:none;">
                    <header>
                        #position.name#
                    </header>
                    <div>
                        #position.descHTML#
                    </div>
                    <p class="text-center">
                        <a class="btn btn-default" href="#buildURL(".postApplicantType")#?pid=#encodeForURL(position.id)#">Apply Now</a>
                    </p>
                </section>
            </cfloop>
        <cfelse>
            <section>
                <p>
                    Thank you for your interest, but we are not hiring at this time.  Please check back again soon.
                </p>
            </section>
        </cfif>
    </article>
</cfoutput>
<cfsavecontent variable = "rc.pageJS">
    <script>
        $(function(){
            $("#position")
            .change(updateDisplay)
            .chosen({
                disable_search_threshold: 10
            })
            updateDisplay();
        });
        function updateDisplay(){
            var positionId = $("#position").val();
            $(".position").hide();
            $("#p" + positionId).show();
        }
    </script>
</cfsavecontent>