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
		<cfargument name="location_name" type="any" required="false" />
		<cfargument name="location_address" type="any" required="false" />
		<cfargument name="location_city" type="any" required="false" />
		<cfargument name="location_state" type="any" required="false" />
		<cfargument name="location_country" type="any" required="false" />
		<cfargument name="location_postal_code" type="any" required="false" />
		<cfargument name="location_lat" type="any" required="false" />
		<cfargument name="location_lng" type="any" required="false" />
		
		<cfset var qry="" />
				
		<cfquery name="qry" datasource="#variables.dsn#" result="result">
			INSERT INTO mitrah_em_locations
			(
				location_name,location_address,location_city,location_state,location_country,location_postal_code,location_lat,location_lng,location_siteId
			)
			values
			(
				<cfqueryparam value='#arguments.location_name#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.location_address#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.location_city#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.location_state#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.location_country#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.location_postal_code#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.location_lat#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.location_lng#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#session.siteid#' cfsqltype='cf_sql_varchar' >
			)			
		</cfquery>
		
		<cfreturn evaluate(#variables.key_generated#)>
	</cffunction>
	
	
	<cffunction name="read" returntype="query">
		<cfargument name="location_id" type="any" required="false" />
		
		<cfset var qry="" />
		
		
		<cfquery name="qry" datasource="#variables.dsn#">
			SELECT *
			FROM mitrah_em_locations
			WHERE location_siteId=<cfqueryparam value='#session.siteid#' cfsqltype='cf_sql_varchar' > 
			
			<cfif structKeyExists(arguments,"location_id")>
				AND location_id = <cfqueryparam value='#arguments.location_id#' cfsqltype='cf_sql_varchar'>
			</cfif>
			
		</cfquery>
		
		<cfreturn qry />
	</cffunction>
			
	<cffunction name="update" returntype="void">
		<cfargument name="location_id" type="any" required="false" />
		<cfargument name="location_name" type="any" required="false" />
		<cfargument name="location_address" type="any" required="false" />
		<cfargument name="location_city" type="any" required="false" />
		<cfargument name="location_state" type="any" required="false" />
		<cfargument name="location_country" type="any" required="false" />
		<cfargument name="location_postal_code" type="any" required="false" />
		<cfargument name="location_lat" type="any" required="false" />
		<cfargument name="location_lng" type="any" required="false" /> 
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			UPDATE mitrah_em_locations
			SET location_name = <cfqueryparam value='#arguments.location_name#' cfsqltype='cf_sql_varchar'>, location_address = <cfqueryparam value='#arguments.location_address#' cfsqltype='cf_sql_varchar'>, location_city = <cfqueryparam value='#arguments.location_city#' cfsqltype='cf_sql_varchar'>, location_state = <cfqueryparam value='#arguments.location_state#' cfsqltype='cf_sql_varchar'>, location_country = <cfqueryparam value='#arguments.location_country#' cfsqltype='cf_sql_varchar'>, location_postal_code = <cfqueryparam value='#arguments.location_postal_code#' cfsqltype='cf_sql_varchar'>, location_lat = <cfqueryparam value='#arguments.location_lat#' cfsqltype='cf_sql_varchar'>, location_lng = <cfqueryparam value='#arguments.location_lng#' cfsqltype='cf_sql_varchar'>
			WHERE location_id = <cfqueryparam value='#arguments.location_id#' cfsqltype='cf_sql_varchar'>
		</cfquery>
		
		<cfreturn />
	</cffunction>
	
	
	<cffunction name="delete" returntype="void">
		<cfargument name="location_id" type="any" required="false" />
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			DELETE FROM mitrah_em_locations
			WHERE location_id = <cfqueryparam value='#arguments.location_id#' cfsqltype='cf_sql_varchar'>
		</cfquery>

		<cfreturn />
	</cffunction>
	
</cfcomponent>
