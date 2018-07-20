component accessors="true" {

    property positionService;

    function init( fw) {
        variables.fw = fw;
    }

    function before(rc){
        if(!session.user.hasPermission("admin")){
            fw.redirect("");
        }
    }

    function default( rc ) {
        fw.redirect(".manage");
    }

    function new(rc){
        rc.position =  positionService.create(CreateUUID());
        rc.position.name = "New Position";
        rc.position.descHTML = "Please fill out the description to be displayed on the application page.";
        rc.isNew = true;
        fw.setview(".edit");
    }

    function create(rc){
        var newposition = positionService.create(CreateUUID());
        newPosition.franchiseeId = session.user.getFranchiseeId();
        newPosition.name = rc.name;
        newPosition.descHTML = rc.descHTML;
        newPosition.enabled = 0;
        newPosition.deleted = 0;
        positionService.update(newPosition);
        fw.redirect(".manage");
    }

    function edit(rc){
        rc.position = positionService.read(rc.id);
    }

    function postEdit(rc){
        var position = positionService.read(rc.id);
        position.franchiseeId = session.user.getFranchiseeId();
        position.name = rc.name;
        position.descHTML = rc.descHTML;
        position.enabled = rc.enabled;
        position.deleted = rc.deleted;
        positionService.update(position);
        fw.redirect(".manage");
    }

    function manage(rc){
        //Update to get users franchise
        rc.positions = positionService.getForFranchisee(session.user.getFranchiseeId());
        rc.positions.each(function(p){
            p.URL = positionService.getPositionURL(p);
        });
        rc.canViewDebug = session.user.hasPermission("admin");
    }

    function enable(rc){
        var position = positionService.read(rc.positionId);
        position.enabled = rc.setEnabled;
        positionService.update(position);
        fw.renderData()
        .data({
            "positionId": rc.positionId
        })
        .type(rc.returnFormat);
    }

}
