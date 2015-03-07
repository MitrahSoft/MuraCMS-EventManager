<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->
<cfcomponent output="false">

	<cffunction name="init" access="public">
		<cfargument name="dsn" hint="data source name" default="">
		<cfargument name="muradbType" hint="database type" default="">
		
		<cfset variables.dsn = arguments.dsn>
		<cfset variables.dbType = arguments.muradbType>
		<cfif variables.dbType EQ 'mysql'>
			<cfset variables.key_generated = 'result.GENERATED_KEY'>
		<cfelseif variables.dbType EQ 'mssql'>
			<cfset variables.key_generated = 'result.identitycol'>
		</cfif>
		
		<cfreturn this />
	</cffunction>
	
	
	<cffunction name="create" returntype="any">
		<cfargument name="OrganizerName" type="any" required="false" />
		<cfargument name="OrganizerPhone" type="any" required="false" />
		<cfargument name="OrganizerEmail" type="any" required="false" />
		<cfargument name="OrganizerWebsite" type="any" required="false" />
		
		<cfset var qry="" />
				
		<cfquery name="qry" datasource="#variables.dsn#" result="result">
			INSERT INTO mitrah_em_organizers
			(
				organizer_name,organizer_phone,organizer_email,organizer_website,organizer_siteId
			)
			values
			(
				<cfqueryparam value='#arguments.OrganizerName#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.OrganizerPhone#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.OrganizerEmail#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.OrganizerWebsite#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#session.siteid#' cfsqltype='cf_sql_varchar' >
			)			
		</cfquery>
		
		<cfreturn evaluate(#variables.key_generated#)>		
	</cffunction>
	
	
	<cffunction name="read" returntype="query">
		<cfargument name="id" type="any" required="false" />
		
		<cfset var qry="" />
		
		
		<cfquery name="qry" datasource="#variables.dsn#">
			SELECT *
			FROM mitrah_em_organizers
			WHERE organizer_siteId=<cfqueryparam value='#session.siteid#' cfsqltype='cf_sql_varchar' > 
			
			<cfif structKeyExists(arguments,"id")>
				AND organizer_id = <cfqueryparam value='#arguments.id#' cfsqltype='cf_sql_varchar' >
			</cfif>
			
		</cfquery>
		
		<cfreturn qry />
	</cffunction>
			
	<cffunction name="update" returntype="void">
		<cfargument name="id" type="any" required="false" />
		<cfargument name="OrganizerName" type="any" required="false" />
		<cfargument name="OrganizerPhone" type="any" required="false" />
		<cfargument name="OrganizerEmail" type="any" required="false" />
		<cfargument name="OrganizerWebsite" type="any" required="false" />
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			
			UPDATE mitrah_em_organizers
			SET organizer_name = <cfqueryparam value='#arguments.OrganizerName#' cfsqltype='cf_sql_varchar'>, 
				organizer_phone = <cfqueryparam value='#arguments.OrganizerPhone#' cfsqltype='cf_sql_varchar'>, 
				organizer_email = <cfqueryparam value='#arguments.OrganizerEmail#' cfsqltype='cf_sql_varchar'>,
				organizer_website = <cfqueryparam value='#arguments.OrganizerWebsite#' cfsqltype='cf_sql_varchar'>
			WHERE organizer_id = <cfqueryparam value='#arguments.id#' cfsqltype='cf_sql_integer' >
		</cfquery>
		
		<cfreturn />
	</cffunction>
	
	
	<cffunction name="delete" returntype="void">
		<cfargument name="organizer_id" type="any" required="false" />
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			DELETE FROM mitrah_em_organizers
			WHERE organizer_id = <cfqueryparam value='#arguments.organizer_id#' cfsqltype='cf_sql_varchar'>
		</cfquery>

		<cfreturn />
	</cffunction>
	
</cfcomponent>
