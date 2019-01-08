component {

	private boolean function checkPermission( event, rc, prc, args={} ) {
		var key           = "dbloggerlogs.access";
		var disallowed    = [ "manageContextPerms", "add", "edit", "translate", "viewversions", "delete", "clone" ];
		var hasPermission = !disallowed.findNoCase( args.key ?: "" ) && hasCmsPermission( key );

		if ( !hasPermission && IsTrue( args.throwOnError ?: "" ) ) {
			event.adminAccessDenied();
		}

		return hasPermission;
	}

}