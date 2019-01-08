component {

	public string function default( event, rc, prc, args={} ){
		return args.data ?: "";
	}

	public string function adminDatatable( event, rc, prc, args={} ){
		var data  = args.data ?: "";

		return abbreviate( args.data, 120 );
	}
}