component extends="framework.one" {

	function setupApplication(){
		application.vn = "1.0.1";
	}

	function setupSession(){
		controller("security.startSession");
	}

	function setupRequest() {
		//work around for start up issues
		if(!session.keyExists("user"))
			controller("security.startSession");
	}

	function setupView(struct rc){
	}

}