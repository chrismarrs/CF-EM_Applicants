<cfoutput>
    <form id="login" action="#buildURL(".loginAction")#" method="post">
        <fieldset class="row">
            <div class="col-md-6">
                <label for="userName">User Name:</label>
            </div>
            <div class="col-md-6">
                <input name="userName" id="userName" type="text" value="#structKeyExists(rc,"failedLogin")?rc.failedLogin.userName:""#" >
            </div>
            <div class="col-md-2"></div>
        </fieldset>
        <fieldset class="row">
            <div class="col-md-6">
                <label for="password">Password:</label>
            </div>
            <div class="col-md-6">
                 <input name="password" id="password" type="password" >
            </div>
        </fieldset>
        <fieldset class="row">
            <div class="col-md-12 text-center">
                <cfif structKeyExists(rc, "failedLogin")>
                    <p class="text-center" style="color:red">#rc.failedLogin.message#</p>
                </cfif>
                <p class="text-center">
                    <input id="btnLogin" name="btnLogin" type="submit" value="Login">
                </p>
            </div>
        </fieldset>
    </form>
</cfoutput>