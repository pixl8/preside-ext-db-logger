component {

	public void function configure( required struct config ) {
		var conf     = arguments.config;
		var settings = conf.settings ?: {};

		_configureEnums( settings );
		_configureLogAppender( conf );
	}

	private void function _configureEnums( settings ) {
		settings.enum.dbloggerSeverity = [ "FATAL", "ERROR", "WARN", "INFO", "DEBUG" ]
	}

	private void function _configureLogAppender( conf ) {
		conf.logbox.appenders.presideDbLogAppender = {
			  class      = 'app.extensions.preside-ext-db-logger.logging.appenders.PresideDbLogAppender'
			, properties = { async=true }
		};
	}
}
