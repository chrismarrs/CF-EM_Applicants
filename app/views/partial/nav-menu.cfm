<cfset user = session.user />
<cfoutput>
    <cfif user.isLoggedIn()>
        <nav class="navbar navbar-default">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">#user.getUserName()#<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#buildURL(":user.changePassword")#">Change Password</a>
                        </li>
                        <cfif user.hasPermission("sysAdmin")>
                            <li><a href="#buildURL(":admin.franchise")#">Change Franchise</a></li>
                        </cfif>
                    </ul>
                </li>
                <!--- Report Menu --->
                <cfif user.hasPermission("report")>
                    <li class="dropdown">
                        <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            Reports <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#buildURL("report:applicants")#">Applicant Report</a>
                            <li>
                                <a href="#buildURL("report:emails")#">Email Report</a>
                        </ul>
                    </li>
                </cfif>
                <cfif user.hasPermission("admin")>
                    <li class="dropdown">
                        <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                            Positions <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#buildURL(":position.new")#">Create</a>
                            <li>
                                <a href="#buildURL(":position.manage")#">Manage</a>
                        </ul>
                    </li>
                </cfif>
                <cfif user.hasPermission("admin")>
                    <li class="dropdown">
                        <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">System Admin <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#buildURL(":admin.editUsers")#">Edit Users</a>
                            <li>
                                <a href="#buildURL(":admin.createUser")#">Create New User</a>
                        </ul>
                    </li>
                </cfif>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#buildURL(":user.logout")#">Logout</a>
                </li>
            </ul>
        </nav>
    </cfif>
</cfoutput>