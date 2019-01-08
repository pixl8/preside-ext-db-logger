<cffunction name="dbLogTable" access="public" returntype="string" output="false">
	<cfargument name="category" type="string" required="false" default="" />
	<cfargument name="args"     type="struct" required="false" default="#StructNew()#" />

	<cfscript>
		if ( Len( Trim( category ) ) ) {
			getController().getRequestContext().setValue( name="logCategory", value=category, private=true );

			arguments.args.gridFields = arguments.args.gridFields ?: [ "severity", "datecreated", "category", "message" ];
			arguments.args.gridFields.delete( "category" );
		}

		return objectDataTable( argumentCollection=arguments, objectName="db_logger_log" );
	</cfscript>
</cffunction>