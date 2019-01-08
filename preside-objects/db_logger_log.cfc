/**
 * Object to store system logs
 *
 * @versioned                    false
 * @nodatemodified               true
 * @nolabel                      true
 * @datamanagerEnabled           true
 * @datamanagerAllowedOperations read,view,list
 * @datamanagerGridFields        severity,datecreated,category,message
 * @datamanagerDefaultSortOrder  datecreated desc
 */
component {
	property name="datecreated" indexes="datecreated" renderer="dbLoggerDate";
	property name="category" type="string" dbtype="varchar" maxlength=50 indexes="category" required=true;
	property name="severity" type="string" dbtype="varchar" maxlength=10 indexes="severity" required=true enum="dbLoggerSeverity" renderer="dbLoggerSeverity";

	property name="message"    type="string"    dbtype="longtext" renderer="dbLoggerLogMessage";
	property name="extra_info" type="extrainfo" dbtype="longtext";
}