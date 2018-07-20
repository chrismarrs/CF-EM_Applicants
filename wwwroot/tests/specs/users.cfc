component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        variables.securityService = new app.model.services.security();
    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){
        describe("User Authentication", function(){
            beforeEach(function(){
                variables.user = new app.model.beans.user();
                variables.user.setSecurityService(securityService);
            });
            given("The user hasn't authenticated", function(){
                it("The user shouldn't be logged in", function(){
                    expect(user.isLoggedIn()).toBeFalse();
                });
                it("The user shouldn't have permission for a page", function(){
                    expect(user.hasPermission("some-page")).toBeFalse();
                });
                it("The user shouldn't be able to gain access", function(){
                    expect(user.givePermission("some-page")).toBeFalse();
                });
            });
            scenario("An user logging in", function(){
                beforeEach(function(){
                    user.setId(1);
                    user.setUserName("TheUseer");
                    user.setPasswordHash(securityService.hashPassword("password"));
                });
                given("The correct password is given", function(){
                    it("Passes", function(){
                        expect( user.validatePassword("password")).toBeTrue();
                    });
                });
                given("An incorrect password is given", function(){
                    it("Passes", function(){
                        expect( user.validatePassword("Password")).toBeFalse();
                    });
                });
            });
            scenario("An authenticated user", function(){
                beforeEach(function(){
                    user.setId(1);
                    user.setUserName("TheUseer");
                    user.setPasswordHash(securityService.hashPassword("password"));
                });
                it("should be able to gain permissions", function(){
                     expect(user.givePermission("some-page")).toBeTrue();
                });
                given("The user has permission to some-page", function(){
                    beforeEach(function(){
                        user.givePermission("some-page");
                    });
                    it("should be able to access some-page", function(){
                        expect(user.hasPermission("some-page")).toBeTrue();
                    });
                    it("should not be able to access another-page", function(){
                        expect(user.hasPermission("another-page")).toBeFalse();
                    });
                });
            });
            scenario("User is changing password", function(){
                beforeEach(function(){
                    user.setId(1);
                    user.setUserName("TheUseer");
                    user.setPasswordHash(securityService.hashPassword("password"));
                });
                given("The user set a new passord of 'newPassword'", function(){
                    beforeEach(function(){
                        user.setPassword("newPassword");
                    });
                    it("should accept the new password", function(){
                        expect(user.validatePassword("newPassword"));
                    });
                    it("shouldn't accept the old password", function(){
                        expect(user.validatePassword("password"));
                    });
                });
            });
        });
    }
}