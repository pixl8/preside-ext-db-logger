component {

	property name="enum" inject="coldbox:setting:enum.dbLoggerSeverity";

	public boolean function default( event, rc, prc, args={} ){
		return args.data ?: "";
	}

	public string function adminDatatable( event, rc, prc, args={} ){
		var severity  = args.data ?: "";

		if ( Len( Trim( severity ) ) && enum.find( UCase( severity ) ) ) {
			var i18nBase = "enum.dbLoggerSeverity:#severity#";

			return '<i class="fa fa-fw #translateResource( i18nBase & ".iconClass" )#"></i> <span class="#translateResource( i18nBase & ".colour" )#">#translateResource( i18nBase & ".label" )#</span>';
		}

		return args.data ?: "";
	}

}