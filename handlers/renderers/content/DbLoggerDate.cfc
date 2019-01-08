component {

	public boolean function default( event, rc, prc, args={} ){
		return runEvent(
			  event          = "renderers.content.datetime.default"
			, private        = true
			, prePostExempt  = true
			, eventArguments = { args=args }
		);
	}

	public string function adminDatatable( event, rc, prc, args={} ){
		var logDate = args.data ?: "";

		if ( IsDate( logDate ) ) {
			return '<span class="light-grey">' & DateFormat( logDate, "d mmm 'yy") & '</span> <code>' & TimeFormat( logDate, "HH:mm:ss" ) & "</code>";
		}

		return args.data ?: "";
	}

}