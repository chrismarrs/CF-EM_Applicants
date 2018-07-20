<cfoutput>
    <cfif len(rc.createUser.message)>
        <p style="color:red">
            #rc.createUser.message#
        </p>
    </cfif>
    <form action="#buildURL(":admin.newUser")#" method="post">
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <lable for="userName">
                    User Name
                </lable>
            </div>
            <div class="col-md-6">
                <input type="text" name="userName" id="userName" value="#rc.createUser.userName#">
            </div>
        </fieldset>
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <lable for="firstName">
                    First Name
                </lable>
            </div>
            <div class="col-md-6">
                <input type="text" name="firstName" id="firstName" value="#rc.createUser.firstName#">
            </div>
        </fieldset>
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
            </div>
            <div class="col-md-6">
            </div>
        </fieldset>
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <lable for="lastName">
                    Last Name
                </lable>
            </div>
            <div class="col-md-6">
                <input type="text" name="lastName" id="lastname" value="#rc.createUser.lastName#">
            </div>
        </fieldset>
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <lable for="password">
                    Password
                </lable>
            </div>
            <div class="col-md-6">
                <input type="password" name="password" id="password">
            </div>
        </fieldset>
        <fieldset class="row twoColCenter">
            <div class="col-md-6">
                <lable for="confirm">
                    Confirm password
                </lable>
            </div>
            <div class="col-md-6">
                <input type="password" name="confirm" id="confirm">
            </div>
        </fieldset>
        <fieldset class="row">
            <div class="col-md-12 text-center">
                <input type="submit" value="Update">
            </div>
        </fieldset>
    </form>
</cfoutput>