component accessors="true" {

    property userService;
    property franchiseService;

    function init(fw){
        variables.fw = fw;
    }

    function before(rc){
        var isAdmin = session.user.hasPermission("admin") || session.user.hasPermission("sysAdmin");
        if(!isAdmin){
            fw.redirect("");
        }
    }

    function default(rc){
    }

    function editusers(rc){
        rc.users = userService.getAllUsers(session.user.getFranchiseeId());
        rc.franchises = franchiseService.getAll();
    }

    function updateUser(rc){
        rc.updateMessage = {};
        local.user = userService.readByUserId(rc.id);
        if(user.getId() == 0){
            rc.updateUser.message = "Failed to find user for updating";
            fw.redirect("editUsers", "updateMessage");
        }
        user.setFirstName(rc.firstName);
        user.setLastName(rc.lastName);

        //user.setFranchiseeId(rc.franchiseeId);

        user.setPermission("admin", structKeyExists(rc,"isAdmin"));
        user.setPermission("report", structKeyExists(rc,"isReportUser"));
        user.setPermission("sysAdmin", rc.keyExists("isSysAdmin"));

        if(len(rc.password) && len(rc.confirm)
            && rc.password == rc.confirm){
            user.setPassword(rc.password);
        }
        user.save();
        fw.redirect(".editUsers");
    }

    function createUser(rc){
        if(!structKeyExists(rc, "createUser"))
            rc.createUser = {
                message: "",
                userName: "",
                firstName: "",
                lastName: ""
            };
    }

    function newUser(rc){
        local.user = userService.read(rc.userName);
        rc.createUser = {
            userName: rc.userName,
            firstName: rc.firstName,
            lastName: rc.lastName
        };
        if(user.getId() != 0 ){
            //User alredy exists
            rc.createUser.message = "User: " & rc.userName & " already exists.";
            fw.redirect(".createUser", "createUser");
        }
        if(!len(rc.password)){
            // non matching passwords
            rc.createUser.message = "Passwords is required.";
            fw.redirect(".createUser", "createUser");
        }
        if(rc.password != rc.confirm){
            // non matching passwords
            rc.createUser.message = "Passwords did not match";
            fw.redirect(".createUser", "createUser");
        }
        local.user = userService.create(rc.userName);
        user.setFirstName(rc.firstName);
        user.setLastName(rc.lastName);
        user.setPassword(rc.password);
        user.setFranchiseeId(session.user.getFranchiseeId());
        user.save();
        fw.redirect(".editUsers");
    }

    function franchise(rc){
        rc.franchises = franchiseService.getAll();
    }

    function changeFranchise(rc){
        if(!session.user.hasPermission("sysAdmin")){
            fw.redirect("admin");
        }
        session.user.setFranchiseeId(rc.franchiseeId);
        session.user.save();
        fw.redirect(".franchise");
    }
}