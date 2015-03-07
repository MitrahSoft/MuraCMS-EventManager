<cfset dbtype =  variables.configBean.getdbtype()>

<cfquery datasource="#variables.configBean.getDatasource()#">
	<cfif dbtype EQ 'mssql'>IF OBJECT_ID('mitrah_em_event_term_relationship', 'U') IS NOT NULL</cfif>
	DROP TABLE <cfif dbtype EQ 'mysql'>IF EXISTS </cfif>mitrah_em_event_term_relationship
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	<cfif dbtype EQ 'mssql'>IF OBJECT_ID('mitrah_em_events', 'U') IS NOT NULL</cfif>
	DROP TABLE <cfif dbtype EQ 'mysql'>IF EXISTS </cfif>mitrah_em_events
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	<cfif dbtype EQ 'mssql'>IF OBJECT_ID('mitrah_em_term', 'U') IS NOT NULL</cfif>
	DROP TABLE <cfif dbtype EQ 'mysql'>IF EXISTS </cfif>mitrah_em_term
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	<cfif dbtype EQ 'mssql'>IF OBJECT_ID('mitrah_em_locations', 'U') IS NOT NULL</cfif>
	DROP TABLE <cfif dbtype EQ 'mysql'>IF EXISTS </cfif>mitrah_em_locations
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	<cfif dbtype EQ 'mssql'>IF OBJECT_ID('mitrah_em_organizers', 'U') IS NOT NULL</cfif>
	DROP TABLE <cfif dbtype EQ 'mysql'>IF EXISTS </cfif>mitrah_em_organizers
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	<cfif dbtype EQ 'mssql'>IF OBJECT_ID('mitrah_em_settings', 'U') IS NOT NULL</cfif>
	DROP TABLE <cfif dbtype EQ 'mysql'>IF EXISTS </cfif>mitrah_em_settings
</cfquery>