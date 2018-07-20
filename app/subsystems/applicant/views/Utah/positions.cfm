<cfoutput>
    <article id="landing-page" class="container-fluid">
        <section class="text-center">
            <header>
                We're hiring! Click on a job below to start your career with Enviro-Master!
            </header>
        </section>
        <section class="positions">
            <cfif !rc.positions.len()>
                <p>
                    Thank you for your interest, but we are not hiring at this time.  Please check back again soon.
                </p>
            <cfelse>
                <ul>
                    <cfloop array="#rc.positions#" index="position">
                        <li><a class="position" href="#buildURL(".position")#?pid=#encodeForURL(position.id)#">#position.name#</a></li>
                    </cfloop>
                </ul>
            </cfif>
        </section>
    </article>
</cfoutput>
<cfsavecontent variable = "rc.pageJS">
</cfsavecontent>