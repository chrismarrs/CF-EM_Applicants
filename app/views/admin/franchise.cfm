<cfoutput>
    <form class="centered" action="#buildURL(".changeFranchise")#" method="post">
        <fieldset class="row twoColCenter">
            <legend>Update Franchise</legend>
            <select name="franchiseeId">
                <option value="">None</option>
                <cfloop array="#rc.franchises#" index="franchise">
                    <option #(session.user.getFranchiseeId() eq franchise.id)?'selected="selected"':''# value="#franchise.id#">#franchise.name#</option>
                </cfloop>
            </select>
        </fieldset>
        <fieldset>
            <input type="submit" value="Update" />
        </fieldset>
    </form>
</cfoutput>