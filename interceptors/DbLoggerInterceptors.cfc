component extends="coldbox.system.Interceptor" {

// PUBLIC
	public void function configure() {}

	public void function afterConfigurationLoad( event ) {
		_autoConfigureLogging();
	}

// PRIVATE
	private void function _autoConfigureLogging() {
		var settings          = getController().getSettingStructure();
		var logboxConf        = settings.logBoxConfig ?: {};
		var categories        = logboxConf.categories ?: {};
		var rootLogger        = logboxConf.rootLogger ?: {};

		for( var categoryId in categories ) {
			_configureLogCategory( categoryId, categories[ categoryId ] );
		}
		_configureLogCategory( "rootLogger", rootLogger );
	}

	private void function _configureLogCategory( categoryId, category ) {
		var settings          = getController().getSettingStructure();
		var excludeCategories = settings.dbLogger.excludeCategories ?: "";
		var includeCategories = settings.dbLogger.includeCategories ?: "";

		if ( IsSimpleValue( excludeCategories ) ) {
			excludeCategories = [ LCase( excludeCategories ) ];
		}
		if ( IsSimpleValue( includeCategories ) ) {
			includeCategories = [ LCase( includeCategories ) ];
		}

		if ( ArrayLen( excludeCategories ) && excludeCategories.find( "*" ) ) {
			return;
		}

		if ( !includeCategories.len() ) {
			return;
		}

		if ( includeCategories.find( "*" ) || includeCategories.find( LCase( categoryId ) ) ) {
			if ( !excludeCategories.len() || !excludeCategories.find( LCase( categoryId ) ) ) {
				category.appenders = category.appenders ?: "";

				if ( !ListFindNoCase( category.appenders, "presideDbLogAppender" ) ) {
					category.appenders = ListAppend( category.appenders, "presideDbLogAppender" );
				}
			}
		}
	}
}