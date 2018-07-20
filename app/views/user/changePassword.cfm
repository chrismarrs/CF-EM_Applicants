<cfoutput>
    <form id="userUpdate" action="#buildURL(".postUpdate")#" method="post">
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <label for="password">Current Password</label>
            </div>
            <div class="col-md-6">
                <input type="password" value="" name="password" id="password">
            </div>
        </fieldset>
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <label for="password">New Password</label>
            </div>
            <div class="col-md-6">
                <input type="password" value="" name="newPassword" id="newPassword">
            </div>
        </fieldset>
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <label for="confirm">Confirm New Password</label>
            </div>
            <div class="col-md-6">
                <input type="password" value="" name="confirmPassword" id="confirmPassword">
            </div>
        </fieldset>

        <cfif StructKeyExists(rc, "updateMessage")>
            <div class="row">
                <div class="col-md-12 text-center" style="color:red">
                    <cfif StructKeyExists(rc.updateMessage, "message")>
                        <p>#rc.updateMessage.message#</p>
                    </cfif>
                </div>
            </div>
        </cfif>
        <fieldset class="row">
            <div class="col-md-12 text-center">
                <input type="submit" value="Update">
            </div>
        </fieldset>
    </form>
</cfoutput>