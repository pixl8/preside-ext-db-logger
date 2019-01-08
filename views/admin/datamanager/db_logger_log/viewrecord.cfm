<cfscript>
	theLog = prc.record ?: QueryNew( '' );
</cfscript>
<cfoutput>
	<div class="modal-padding-horizontal">
		<h2>
			#renderField( object="db_logger_log", property="severity", data=theLog.severity, context="admin" )#
			#renderField( object="db_logger_log", property="category", data=theLog.category, context="admin" )#
			#renderField( object="db_logger_log", property="datecreated", data=theLog.datecreated, context="admin" )#
		</h2>

		<pre>#Trim( renderField( object="db_logger_log", property="message", data=theLog.message, context="admin" ) )#</pre>

		<cfif Len( Trim( theLog.extra_info ) )>
			<h3>#translateResource( "preside-objects.db_logger_log:field.extra_info.title" )#</h3>
			<pre>#Trim( renderField( object="db_logger_log", property="extra_info", data=theLog.extra_info, context="admin" ) )#</pre>
		</cfif>
	</div>
</cfoutput>