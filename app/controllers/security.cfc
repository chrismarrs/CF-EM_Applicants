component {

    function init( fw ) {
        variables.fw = fw;
        variables.beanFactory = fw.getBeanFactory();
    }

	/** Init the user session values
	*/
    function startSession( rc ) {
        session.user = beanFactory.getBean("userBean");
    }

}
