component {

	this.name = 'Enviro-Master-Applicants' & Hash(getBaseTemplatePath());
    this.isProduction = true;
    this.vn = "1.0.2";
    this.sessionManagement = true;
    this.enableRobustException = true;
    this.secureJSONPrefix = "";
    this.secureJSON = false;
    this.datasource = "em_applicants";
	this.applicationTimeout = createTimeSpan(7,0,0,0);
	this.sessionTimeout = createTimeSpan(0,1,0,0);
	this.serialization.preservecaseforstructkey = true;
	this.invokeImplicitAccessor = true;

	this.rootDir = getDirectoryFromPath(getCurrentTemplatePath());
	this.javasettings = {
		loadPaths = [
			this.rootDir & "../lib/bCrypt"
		]
	};

    this.mappings[ '/framework' ] = expandPath( '../lib/framework' );
    this.mappings[ '/app' ] = expandPath( '../app' );
    this.mappings[ '/model' ] = expandPath( '../app/model' );
	this.mappings[ '/lang'] = expandPath( '../app/lang' );

    function _get_framework_one() {
        if ( !structKeyExists( request, '_framework_one' ) ) {
			request._framework_one = new EMApplication({
				base = "/app",
				// true for dev only set to false for production
				reloadApplicationOnEveryRequest = !this.isProduction,
				maxNumContextsPreserved = 1,
				reload = 'reload',
				password = 'true',
                home = 'default',
				generateSES = true,
				SESOmitIndex = true,
				unhandledPaths = "/assets",
                diLocations = [
                    "/app/model",
                    "/app/subsystems"
                ]
			});
        }
        return request._framework_one;
    }

    // delegation of lifecycle methods to FW/1:
    function onApplicationStart() {
        return _get_framework_one().onApplicationStart();
    }
    function onError( exception, event ) {
        return _get_framework_one().onError( exception, event );
    }
    function onRequest( targetPath ) {
        return _get_framework_one().onRequest( targetPath );
    }
    function onRequestEnd() {
        return _get_framework_one().onRequestEnd();
    }
    function onRequestStart( targetPath ) {
        return _get_framework_one().onRequestStart( targetPath );
    }
    function onSessionStart() {
        return _get_framework_one().onSessionStart();
    }
}