/**
 * Object to store system logs
 *
 * @versioned      false
 * @nodatemodified true
 * @nolabel        true
 */
component {
	property name="category" type="string" dbtype="varchar" maxlength=50 indexes="category" required=true;
	property name="appender" type="string" dbtype="varchar" maxlength=50 indexes="appender" required=true;
	property name="severity" type="string" dbtype="varchar" maxlength=10 indexes="severity" required=true enum="dbloggerSeverity";

	property name="message"    type="string"    dbtype="longtext";
	property name="extra_info" type="extrainfo" dbtype="longtext";
}