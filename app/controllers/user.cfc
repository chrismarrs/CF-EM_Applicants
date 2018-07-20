component accessors="true" {

    property userService;

    function init( fw ) {
        variables.fw = fw;
    }

    function before(rc){
        rc.user = session.user;
    }

    function default(rc){
        if(!rc.user.isLoggedin()){
            fw.redirect("user.login");
        }
    }

    function loginAction(rc) {
        rc.failedLogin = {
            message = "Invalid user name or password",
            userName = rc.userName
        };
        if(!structKeyExists(rc, "userName")
            || !structKeyExists(rc, "password")
            || !len(rc.userName)
            || !len(rc.password)){
            fw.redirect(":user.login", "failedLogin");
        }
        var user = userService.read(rc.userName);
        if(user.getId() != 0){
            if(user.validatePassword(rc.password)){
                session.user = user;
                fw.redirect(":user");
            }
        }
        fw.redirect(":user.login", "failedLogin");
    }

    function logout(){
        session.user = fw.getBeanFactory().getBean("userBean");
        sessionInvalidate();
        fw.redirect(":");
    }

    function postUpdate(rc){
        var user = rc.user;
        if(!user.isLoggedin()){
            fw.redirect("user.login");
        }

        rc.updateMessage = {};
        //Update password
        param name="rc.password" default="";
        param name="rc.newPassword" default="";
        param name="rc.confirmPassword" default="";
        if(user.validatePassword(rc.password)){
            if(!len(rc.newPassword)){
                rc.updateMessage.Message = "No new password entered.";
            }
            else if(rc.newPassword != rc.confirmPassword){
                rc.updateMessage.Message = "New password and confirmation password do not match.";
            }
            else{
                rc.updateMessage.Message = "Update successful";
                user.setPassword(rc.newPassword);
                user.save();
            }
        }
        else{
            rc.updateMessage.Message = "Invalid Password";
        }
        fw.redirect(".changePassword", "updateMessage");
    }
}