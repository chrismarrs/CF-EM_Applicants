<cfoutput>
    <p class="text-center">
        Please enter your email below to have your email address removed from any further communications.
        <form class="text-center" action="#buildURL(".byEmail")#" method="post">
            <input type="email" name="email">
            <br><br>
            <input type="submit" value="Unsubscribe">
        </form>
    </p>
</cfoutput>