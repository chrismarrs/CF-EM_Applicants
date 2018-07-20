<cfoutput>
    <cfset i = 0 />
    <div id="admin-edit-users">
        <cfloop array="#rc.users#" index="user">
            <cfif user.getId() eq session.user.getId()>
                <cfcontinue />
            </cfif>
            <cfset i++ />
            <section id="#i#" class="userInfo">
                <header>
                    #user.getFirstName()# #user.getLastName()# (#user.getUserName()#)
                </header>
                <form style="display:none;" action="#buildURL(".updateUser")#" method="post">
                    <input type="hidden" name="id" value="#user.getId()#">
                    <fieldset>
                        <legend>Name</legend>
                        <label class="setWidth" for="firstName#i#">First Name: </label>
                        <input type="text" value="#user.getFirstName()#" id="firstName#i#" name="firstName">
                        <br>
                        <label class="setWidth" for="lastName#i#">Last Name: </label>
                        <input type="text" value="#user.getLastName()#" id="lastName#i#" name="lastName">
                    </fieldset>
                    <cfif session.user.hasPermission("sysAdmin")>
                        <fieldset>
                            <legend>Franchise</legend>
                            <select name="franchiseeId">
                                <option value="">None</option>
                                <cfloop array="#rc.franchises#" index="franchise">
                                    <option #(user.getFranchiseeId() eq franchise.id)?'selected="selected"':''# value="#franchise.id#">#franchise.name#</option>
                                </cfloop>
                            </select>
                        </fieldset>
                    </cfif>
                    <fieldset>
                        <legend>Permissions:</legend>
                        <label>Reports: <input type="checkBox" name="isReportUser" #user.hasPermission("report")?"checked":""#></label>
                        <label>Admin: <input type="checkBox" name="isAdmin" #user.hasPermission("admin")?"checked":""#></label>
                        <cfif session.user.hasPermission("sysAdmin")>
                            <label>System Admin: <input type="checkBox" name="isSysAdmin" #user.hasPermission("sysAdmin")?"checked":""#></label>
                        </cfif>
                    </fieldset>
                    <fieldset>
                        <legend>Password</legend>
                        <label class="setWidth" for="password#i#">New: </label>
                        <input type="password" id="password#i#" name="password">
                        <br>
                        <label class="setWidth" for="confirm#i#">Confirm: </label>
                        <input type="password" id="confirm#i#" name="confirm">
                    </fieldset>
                    <fieldset class="submit">
                        <legend>&nbsp</legend>
                        <input type="submit" value="Update">
                    </fieldset>
                </form>
            </section>
        </cfloop>
    </div>
</cfoutput>
<cfsavecontent variable="rc.pageJS">
    <script>
        $(function(){
            $("section").each(function(i, s){
                $("header", s).on("click", function(e){
                    console.log(this);
                    $("form", s).toggle();
                });
            });
        });
    </script>
</cfsavecontent>