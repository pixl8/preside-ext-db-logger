# Preside DB Logger extension

The DB Logger extension allows developers to send logbox logs to their databases, using a preside object based database table. The aim here is to eventually supply filterable admin views into these logs (but right now this is super alpha so simply puts logs into the database).

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

## Roadmap

We'd love to:

* Create a System -> Logs page to display centralized logging
* Create viewlets/helpers to allow you to display pre-filtered logs directly in your custom admin pages
* Create [Admin Dashboard]() widgets for individual log views (e.g. "Latest events")


## Contributing

Contribution in all forms is very welcome. Use Github to create pull requests for tests, logic, features and documentation. Or, get in touch over at Preside's slack team and we'll be happy to help and chat: [https://presidecms-slack.herokuapp.com/](https://presidecms-slack.herokuapp.com/).
