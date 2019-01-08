# Preside DB Logger extension

The DB Logger extension allows developers to send logbox logs to their databases, using a preside object based database table. Admin view helpers then allow embedding log viewers in your admin applications.

## Install

```bash
box install preside-ext-db-logger
```

## Configuration and usage

The extension creates a new log appender, `presideDbLogAppender`, that can be used to log to the database.

### Manually using the appender per log category

In core Coldbox/Logbox, you can configure appenders on individual log categories in your application's Config.cfc. To ensure a category uses the Preside DB Log appender, just add `presideDbLogAppender` to your list of appenders for the category. For example:


```js
logbox.categories.smtp = {
	  appenders = 'presideDbLogAppender'
	, levelMin  = 'FATAL'
	, levelMax  = 'DEBUG'
};
```

### Auto mapping the appender to categories

We've added two settings to help you auto map the appender to categories, `settings.dbLogger.excludeCategories` and `settings.dbLogger.includeCategories`. These are either a string list or array of categories to exclude or include. You can use a wildcard, "\*", to indicate all categories. The default configuration is to _exclude_ all categories and include none:

```js
// default EXCLUDE all config
settings.dbLogger.excludeCategories = "*";
settings.dbLogger.includeCategories = "";

// example config to put ALL logs into the appender
settings.dbLogger.excludeCategories = "";
settings.dbLogger.includeCategories = "*";

// example to include ALL except for a specific log category
settings.dbLogger.excludeCategories = [ "myVeryBusyLogCategory" ];
settings.dbLogger.includeCategories = "*";
```

## Log rotation

The log appender defaults to keeping logs for 30 days and checking for log rotation every 5 minutes. To change these defaults, you can set these properties on the appender configuration. For example:

```js
logbox.appenders.presideDbLogAppender.properties.rotate = true;
logbox.appenders.presideDbLogAppender.properties.rotationDays = 1;
logbox.appenders.presideDbLogAppender.properties.rotationFrequency = 60; // minutes
```

## Using additional info in logs

The log system allows you to pass `reference` and `sub_reference` fields through a struct sent as the `extraInfo` argument to any logger calls. These fields can then be filtered in log views. These can be useful for creating pre-filtered log views that are specific slices of your logs. For example:

```js
if ( logger.canInfo() ) {
	logger.info( message="Mail rejected due to sender not authorized", extraInfo={ reference=mailingListId, sub_reference=senderAddress } );
}
```

## Displaying log tables in your admin views

The extension provides a helper method, `dbLogTable()`, that can be used in your handlers and views to render an admin data table of logs. Usage examples:

```html
<!-- render all logs -->
#dbLogTable()#

<!-- render all logs for a particular logbox category -->
#dbLogTable( category="mail" )#

<!-- render all logs for a particular category and reference -->
#dbLogTable( category="mail", reference=mailingListId )#

<!-- render all logs for a particular category, reference and subreference -->
#dbLogTable( category="mail", reference=mailingListId, subReference=listMemberEmail )#
```

## Contributing

Contribution in all forms is very welcome. Use Github to create pull requests for tests, logic, features and documentation. Or, get in touch over at Preside's slack team and we'll be happy to help and chat: [https://presidecms-slack.herokuapp.com/](https://presidecms-slack.herokuapp.com/).
