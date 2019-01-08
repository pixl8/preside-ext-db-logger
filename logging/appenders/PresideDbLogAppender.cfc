component accessors=true extends="coldbox.system.logging.AbstractAppender" {

	function init(
		  required string  name
		,          struct  properties = {}
		,          string  layout     = ""
		,          numeric levelMin   = 0
		,          numeric levelMax   = 4
	){
		super.init( argumentCollection=arguments );

		if( !propertyExists( "rotate" ) ){
			setProperty( "rotate", true );
		}
		if( !propertyExists( "rotationDays" ) ){
			setProperty( "rotationDays", 30 );
		}
		if( !propertyExists( "rotationFrequency" ) ){
			setProperty( "rotationFrequency", 5 );
		}

		variables.lastDBRotation = "";

		return this;
	}

	public any function logMessage( required coldbox.system.logging.LogEvent logEvent ){
		var category     = Len( logEvent.getCategory() ) ? logEvent.getCategory() : getProperty( "defaultCategory", "default" );
		var extraInfo    = logEvent.getExtraInfo();
		var dataToInsert = {
			  severity   = severityToString( logEvent.getseverity() )
			, category   = Left( category, 50 )
			, message    = logEvent.getMessage()
			, extra_info = logEvent.getExtraInfoAsString()
		};

		if ( IsStruct( extraInfo ?: "" ) ) {
			dataToInsert.append( extraInfo, false );
		}

		_getLogDao().insertData( data=dataToInsert );

		rotationCheck();

		return this;
	}

	public void function rotationCheck(){
		var shouldRotate = !IsDate( lastDBRotation ) || DateDiff( "n", lastDBRotation, now() ) > getProperty( "rotationFrequency" );

		if ( shouldRotate ) {
			doRotation();

			lastDBRotation = now();
		}
	}

	public any function doRotation(){
		var targetDate 	= DateAdd( "d", "-#getProperty( "rotationDays" )#", Now() );

		_getLogDao().deleteData( filter="datecreated <= :datecreated", filterParams={ datecreated=targetDate } );

		return this;
	}

	private any function _getLogDao() {
		if ( !variables.keyExists( "logDao" ) ) {
			variables.logDao = getColdbox().getWireBox().getInstance( dsl="presidecms:object:db_logger_log" );
		}
		return variables.logDao;
	}
}