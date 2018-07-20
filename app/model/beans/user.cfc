component accessors="true" {

    property securityService;
    property userService;

    property id;
    property franchiseeId;
    property userName;
    property firstName;
    property lastName;
    property passwordHash;
    property lastPasswordUpdate;
    property isDeleted;
    property permissions;

    function init( id = 0, franchiseeId = 0,
        userName = "anonymous",
        firstName = "", lastName = "",
        passwordHash = "", lastPasswordUpdate = now(),
        isDeleted = 0, permissions = []){
        variables.id = id;
        variables.franchiseeId = franchiseeId;
        variables.userName = userName;
        variables.firstName = firstName;
        variables.lastName = lastName;
        variables.passwordHash = passwordHash;
        variables.lastPasswordUpdate = lastPasswordUpdate;
        variables.isDeleted = isDeleted;
        variables.permissions = permissions;
    }

    function givePermission(permissionKey){
        if(!isLoggedIn())
            return false;
        return arrayAppend(permissions, permissionKey);
    }

    function revokePermission(permissionKey){
        return arrayDelete(permissions, permissionKey);
    }

    function hasPermission(permissionKey){
        return permissions.contains(permissionKey);
    }

    function setPermission(permissionKey, hasPermission = true){
        if(hasPermission)
            givePermission(permissionKey);
        else
            revokePermission(permissionKey);
    }

    function isLoggedIn(){
        return userName != "anonymous";
    }

    function validatePassword(password){
        return securityService.checkPassword(password,passwordHash);
    }

    function setPassword(password){
        passwordHash = securityService.hashPassword(password);
        lastPasswordUpdate = Now();
    }

    function save(){
        userService.update(this);
    }

}