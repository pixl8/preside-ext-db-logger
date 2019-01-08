component {

	public void function configure( required struct config ) {
		var conf     = arguments.config;
		var settings = conf.settings ?: {};

		_configureEnums( settings );
		_configureLogAppender( conf, settings );
		_registerInterceptors( conf );
	}

	private void function _configureEnums( settings ) {
		settings.enum.dbloggerSeverity = [ "FATAL", "ERROR", "WARN", "INFO", "DEBUG" ]
	}

	private void function _configureLogAppender( conf, settings ) {
		conf.logbox.appenders.presideDbLogAppender = {
			  class      = 'app.extensions.preside-ext-db-logger.logging.appenders.PresideDbLogAppender'
			, properties = { async=true }
		};

		settings.dbLogger = settings.dbLogger ?: {};
		settings.dbLogger.excludeCategories = settings.dbLogger.excludeCategories ?: "*";
		settings.dbLogger.includeCategories = settings.dbLogger.includeCategories ?: "";
	}

	private void function _registerInterceptors( conf ) {
		conf.interceptors.append({ class="app.extensions.preside-ext-db-logger.interceptors.DbLoggerInterceptors", properties={} } );
	}
}
