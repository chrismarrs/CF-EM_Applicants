component accessors="true"{
    function init(){
        variables.workLoad = 12;
        variables.bCrypt = createObject("java", "org.mindrot.jbcrypt.BCrypt");
    }

    function hashPassword(password){
        return bCrypt.hashpw(password, bcrypt.gensalt(workLoad));
    }

    function checkPassword(password, passwordHash){
        return bCrypt.checkpw(password, passwordHash);
    }
}