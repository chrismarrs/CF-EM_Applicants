component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        securityService = new app.model.services.security();
    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){
        describe("Validating user passwords", function(){
            given("A password of password", function(){
                beforeEach(function(){
                    variables.hash = securityService.hashPassword("password");
                });
                given("The correct password", function(){
                    it("Passes", function(){
                        expect( securityService.checkPassword("password", hash) ).toBeTrue();
                    });
                });
            });
            given("incorrect caseing", function(){
                it("It fails", function(){
                    expect( securityService.checkPassword("Password", hash) ).toBeFalse();
                });
            });
            given("incorrect 0 length password", function(){
                it("It fails", function(){
                    expect( securityService.checkPassword("", hash) ).toBeFalse();
                });
            });
            given("incorrect 0 length hash", function(){
                it("It fails", function(){
                    expect( function(){
                        securityService.checkPassword("password", "");
                    }).toThrow();
                });
            });
        });
    }

}