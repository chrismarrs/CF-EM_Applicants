component accessors="true" {

    property beanFactory;

    function create(userName){
        local.user = beanFactory.getBean("userBean");
        user.setId(createUUID());
        user.setUserName(userName);
        user.setPassword(user.getId());
        queryExecute("INSERT INTO user
            (id, `userName`, `passwordHash`)
            VALUES (:userId, :userName, :passwordHash)",
            {
                userId: user.getId(),
                userName: user.getUserName(),
                passwordHash: user.getPasswordHash()
            }
        );
        return user;
    }

    function getAllUsers(franchiseeId, includeDeleted = false){
        local.userIds = [];
        local.params = [];
        local.where = "where true";
        if(arguments.keyExists("franchiseeId")){
            where &= " and franchisee_id = ?";
            params.append({
                cfsqlType: "int",
                value: franchiseeId
            });
        }
        if(!includeDeleted){
            where &= " and isDeleted = 0";
        }
        local.qUserIds = queryExecute("
            select id
            from user
            #where#
            order by userName
        ",
            params
        );
        for(local.rUser in qUserIds){
            arrayAppend(userIds, rUser.id);
        }
        return readUsers(userIds);
    }

    function readUsers(userIds){
        local.users = [];
        local.qUser = queryExecute("Select
            id, franchisee_Id as franchiseeId,
            userName, firstName, lastName,
            passwordHash, lastPasswordUpdate, isDeleted
            from user
            where id in (:userId)
            order by userName",
            {
                userId: {
                    cfsqlType = "cf_sql_char",
                    maxLength = 65,
                    list="true",
                    value=arrayToList(userIds)
                }
            }
        );
        local.permissions = getPermissionsForUsers(userIds);
        for(local.rUser in qUser){
            local.user = populateUser(rUser);
            user.setPermissions(permissions[rUser.id]);
            arrayAppend(users, user);
        }
        return users;

    }

    function read(userName){
        local.qUser = queryExecute("Select
            id, franchisee_Id as franchiseeId,
            userName, firstName, lastName,
            passwordHash, lastPasswordUpdate, isDeleted
            from user
            where userName = :userName",
            {
                userName: {
                    cfsqlType = "cf_sql_varchar",
                    value=userName
                }
            }
            );
        local.user = beanFactory.getBean("userBean");
        for(local.rUser in qUser){
            user = populateUser(rUser);
            user.setPermissions(getPermissionsForUser(rUser.id));
        }
        return user;
    }

    function readByUserId(userId){
        local.users = readUsers([userId]);
        if(arrayLen(users)){
            return users[1];
        }
        return beanFactory.getBean("userBean");
    }

    private function populateUser(userData){
        return beanFactory.getBean("userBean",{
            id: userData.id,
            franchiseeId: userData.franchiseeId,
            userName: userData.userName,
            firstName: userData.firstName,
            lastName: userData.lastName,
            passwordHash: userData.passwordHash,
            passwordUpdate: userData.lastPasswordUpdate,
            isDeleted: userData.isDeleted
        });
    }

    function update(user){
        local.rUpdateUser = queryExecute("
            update user
            set firstName = :firstName,
            franchisee_Id = :franchiseeId,
            lastName = :lastName,
            passwordHash = :passwordHash,
            lastPasswordUpdate = :lastPasswordUpdate,
            isDeleted = :isDeleted
            where id = :userId
        ",
        {
            userId: {
                cfsqlType:"cf_sql_varchar",
                value: user.getId()
            },
            franchiseeId: {
                cfsqlType: "int",
                value: user.franchiseeId,
                null: len(user.franchiseeId) == 0 || user.franchiseeId == 0
            },
            firstName: {
                cfsqlType:"cf_sql_varchar",
                value: user.getFirstName()
            },
            lastName:{
                cfsqlType:"cf_sql_varchar",
                value: user.getLastName()
            },
            passwordHash:{
                cfsqlType:"cf_sql_char",
                maxLength:60,
                value: user.getPasswordHash()
            },
            lastPasswordUpdate:{
                cfsqlType:"cf_sql_timestamp",
                value: user.getLastPasswordUpdate()
            },
            isDeleted:{
                cfsqlType:"cf_sql_tinyInt",
                value: user.getIsDeleted()
            }
        });
        updatePermissions(user);
    }

    private function updatePermissions(user){
        local.userIdParam = {
            cfsqlType = "cf_sql_char",
            maxLength = "36",
            value = user.getId()
        };
        queryExecute("update user_permissions
            set enabled = 0
            where user_id = :userId
        ", {
            userId:userIdParam
        });
        if(!arrayLen(user.getPermissions())){
            return;
        }
        queryExecute("insert into user_permissions
        (user_id, permission_id, enabled)
        (select :userId, id, 1
        from permissions
        where `key` in (:permissions) )
        on duplicate key update enabled = values(enabled)", {
            userId: userIdParam,
            permissions: {
                cfsqlType: "cf_sql_varchar",
                list: true,
                value= arrayToList(user.getPermissions())
            }
        });
    }

    function delete(user){
        throw("not yet implemented");
    }

    private function getPermissionsForUser(userId){
        return getPermissionsForUsers([userId])[userId];
    }

    private function getPermissionsForUsers(arrUserIds = []){
        local.permissions = {};
        for(local.id in arrUserIds){
            permissions[id] = [];
        }
        if(!arrayLen(arrUserIds)){
            return permissions;
        }
        local.qPermissions = queryExecute("SELECT
            up.user_id userId, p.key
            FROM permissions p
            join user_permissions up
                on p.id = up.permission_id
            where up.user_id in (:userIds)
            and enabled",
            {
                userIds: {
                    cfsqlType = "cf_sql_char",
                    list = true,
                    value = arrayToList(arrUserIds)
                }
            }
        );
        for(local.rPermission in qPermissions){
            arrayAppend(permissions[rPermission.userid],rPermission.key);
        }
        return permissions;
    }

}