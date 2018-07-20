component{
    this.name = 'TestsFolder' & Hash(getBaseTemplatePath());
    variables.testFolder = getDirectoryFromPath(getCurrentTemplatePath());
	this.mappings['/app'] = variables.testFolder & "../";
	this.mappings['/tests'] = variables.testFolder;
	this.mappings['/testbox'] = variables.testFolder & "../testbox";
	this.mappings['/framework'] = variables.testFolder & "../framework";

    this.applicationTimeout = CreateTimeSpan(0, 0, 0, 1);

	this.javasettings = {
		loadPaths = [
			"/app/lib/bCrypt/"
		]
	};

	function onApplicationStart() {
		application.beanFactory = new framework.ioc([
			"/app/model/"
		]);
		return true;
	}
}