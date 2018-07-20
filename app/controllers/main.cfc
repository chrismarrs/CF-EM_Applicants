component {

    function init( fw ) {
        variables.fw = fw;
    }

    function default( rc ) {
        fw.redirect(fw.getConfig().home);
    }

}
