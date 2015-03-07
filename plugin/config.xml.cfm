<!---

This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
				

--->
<cfinclude template="../includes/fw1config.cfm" />
<cfoutput><plugin>
	<name>#variables.framework.package#</name>
	<package>#variables.framework.package#</package>
	<directoryFormat>packageOnly</directoryFormat>
	<provider>MitrahSoft</provider>
	<providerURL>http://www.MitrahSoft.com</providerURL>
	<loadPriority>i</loadPriority>
	<version>#variables.framework.packageVersion#</version>
	<category>Application</category>
	<ormcfclocation />
	<customtagpaths />
	<mappings />
	<settings>
	</settings>
	<eventHandlers>
	</eventHandlers>
	<displayobjects location="global">
		<displayobject name="Calendar view" displaymethod="dspMainRenderer" component="includes.displayObjects" persist="false" />
	</displayobjects>	
</plugin></cfoutput>
