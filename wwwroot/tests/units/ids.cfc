component extends="testbox.system.BaseSpec"{

    // executes before all suites
    function beforeAll(){
        utilService = new app.model.services.uuidUtility();
    }

    // executes after all suites
    function afterAll(){}

    // All suites go in here
    function run( testResults, testBox ){
        describe("Converting a UUIDto base64", function(){
            given("A UUID", function(){
                it("Should be the same when coded and uncoded", function(){
                    var uuids = getUUUIDsToTest();
                    uuids.each(function(uuid){
                        var coded = utilService.toBase64(uuid);
                        var uncoded = utilService.fromBase64(coded);
                        expect( uncoded ).toBe(uuid);
                    });
                });
            });
        });
    }

    private function getUUUIDsToTest(){
        var uuids = [
            "00000000-0000-0000-0000000000000000",
            "FFFFFFFF-FFFF-FFFF-FFFFFFFFFFFFFFFF",
            "4132E4D5-F5C0-2E26-91E654015A620A91",
        	"4132E4D6-FDE3-6691-9264555C329FC3C1",
        	"4132E4D7-00E4-6875-B62474FC4FAFC2E9",
        	"4132E4D8-00A0-F339-6FA31584BCDC6565",
        	"4132E4D9-A33C-C3EC-D34F6FEF2614FE76",
        	"4132E4DA-D628-592F-CDC653DB8B8A4394",
        	"4132E4DB-92A7-EE1A-7353105099269378",
        	"4132E4DC-C982-00FE-00495221D5FA6D21",
        	"4132E4DD-C6B5-5EED-DF3FB6CA95332501",
        	"4132E4DE-C0E6-A760-BC078C89EE1B0FC6"
        ];
        return uuids;
    }

}