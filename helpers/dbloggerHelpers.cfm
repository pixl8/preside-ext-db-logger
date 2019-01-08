<cffunction name="dbLogTable" access="public" returntype="string" output="false">
	<cfargument name="args"     type="struct" required="false" default="#StructNew()#" />
	<cfargument name="category" type="string" required="false" default="" />
	<cfargument name="reference" type="string" required="false" default="" />
	<cfargument name="subReference" type="string" required="false" default="" />

	<cfscript>
		var prc = getController().getRequestContext().getCollection( private=true );
		if ( Len( Trim( arguments.category ) ) ) {
			prc.logCategory = arguments.category;

			arguments.args.gridFields = arguments.args.gridFields ?: [ "severity", "datecreated", "category", "message" ];
			arguments.args.gridFields.delete( "category" );
		}

		if ( Len( Trim( arguments.reference ) ) ) {
			prc.logReference = arguments.reference;
		}
		if ( Len( Trim( arguments.subReference ) ) ) {
			prc.logSubReference = arguments.subReference;
		}


		return objectDataTable( argumentCollection=arguments, objectName="db_logger_log" );
	</cfscript>
</cffunction>