component extends="preside.system.base.AdminHandler" {

	public void function viewRecord( event, rc, prc ) {
		var objectName = "db_logger_log";
		var recordId = rc.id ?: "";

		event.initializeDatamanagerPage( objectName, recordId );
		event.noLayout();
	}

// CUSTOMIZATIONS
	private boolean function checkPermission( event, rc, prc, args={} ) {
		var key           = "dbloggerlogs.access";
		var disallowed    = [ "manageContextPerms", "add", "edit", "translate", "viewversions", "delete", "clone" ];
		var hasPermission = !disallowed.findNoCase( args.key ?: "" ) && hasCmsPermission( key );

		if ( !hasPermission && IsTrue( args.throwOnError ?: "" ) ) {
			event.adminAccessDenied();
		}

		return hasPermission;
	}

	private string function buildViewRecordLink( event, rc, prc, args={} ) {
		var recordId    = args.recordId ?: "";
		var qs          = "id=" & recordId;

		if ( Len( Trim( args.queryString ?: "" ) ) ) {
			qs &= "&" & args.queryString;
		}

		return event.buildAdminLink( linkto="datamanager.db_logger_log.viewrecord", queryString=qs );
	}

	private array function getActionsForGridListing( event, rc, prc, args={} ) {
		var records = args.records ?: QueryNew('');
		var actions = [];

		if ( records.recordCount ) {
			var template = renderView( view="/admin/datamanager/db_logger_log/_gridActions", args={
				  viewlink     = event.buildAdminLink( objectName="db_logger_log", recordId="{id}" )
				, viewlogtitle = translateResource( "preside-objects.db_logger_log:view.log.modal.title" )
			} );

			for( var record in records ) {
				actions.append( template.replace( "{id}", record.id, "all" ) );
			}
		}

		return actions;
	}

	private string function getAdditionalQueryStringForBuildAjaxListingLink( event, rc, prc, args={} ) {
		var category     = rc.logCategory     ?: ( prc.logCategory     ?: "" );
		var reference    = rc.logReference    ?: ( prc.logReference    ?: "" );
		var subReference = rc.logSubReference ?: ( prc.logSubReference ?: "" );
		var qs = "";

		if ( Len( Trim( category ) ) ) {
			qs = "category=#category#"
		}
		if ( Len( Trim( reference ) ) ) {
			qs = ListAppend( qs, "reference=#reference#", "&" )
		}
		if ( Len( Trim( subReference ) ) ) {
			qs = ListAppend( qs, "subreference=#subReference#", "&" )
		}

		return qs;
	}

	private void function preFetchRecordsForGridListing( event, rc, prc, args={} ) {
		var category     = rc.category     ?: "";
		var reference    = rc.reference    ?: "";
		var subReference = rc.subReference ?: "";

		args.extraFilters = args.extraFilters ?: [];

		if ( !IsEmpty( category ) ) {
			args.extraFilters.append( { filter={ category=category } } );
		}
		if ( !IsEmpty( reference ) ) {
			args.extraFilters.append( { filter={ reference=reference } } );
		}
		if ( !IsEmpty( subReference ) ) {
			args.extraFilters.append( { filter={ sub_reference=subReference } } );
		}
	}

}