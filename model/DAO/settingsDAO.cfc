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
		<cfargument name="setting_name" type="any" required="false" />
		<cfargument name="setting_value" type="any" required="false" />
		
		<cfset var qry="" />
				
		<cfquery name="qry" datasource="#variables.dsn#" result="result">
			INSERT INTO mitrah_em_settings
			(
				setting_name,setting_value
			)
			values
			(
				<cfqueryparam value='#arguments.setting_name#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.setting_value#' cfsqltype='cf_sql_varchar'>
			)			
		</cfquery>
		
		<cfreturn evaluate(#variables.key_generated#)>		
	</cffunction>
	
	
	<cffunction name="read" returntype="query">
		<cfargument name="setting_id" type="any" required="false" />
		<cfargument name="setting_name" type="any" required="false" />
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			SELECT *
			FROM mitrah_em_settings
			where 1=1 
			
			<cfif structKeyExists(arguments,"setting_id")>
				AND setting_id = <cfqueryparam value='#arguments.setting_id#' cfsqltype='cf_sql_varchar'>
			</cfif>
			<cfif structKeyExists(arguments,"setting_name")>
				AND setting_name = <cfqueryparam value='#arguments.setting_name#' cfsqltype='cf_sql_varchar'>
			</cfif>
			
		</cfquery>
		<cfreturn qry />
		
	</cffunction>
			
	<cffunction name="update" returntype="void">
		<cfargument name="setting_id" type="any" required="false" />
		<cfargument name="setting_name" type="any" required="false" />
		<cfargument name="setting_value" type="any" required="false" /> 
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			UPDATE mitrah_em_settings
			SET 
				setting_value = <cfqueryparam value='#arguments.setting_value#' cfsqltype='cf_sql_varchar'>
			WHERE setting_name = <cfqueryparam value='#arguments.setting_name#' cfsqltype='cf_sql_varchar'>
		</cfquery>
		
		<cfreturn />
	</cffunction>
	
</cfcomponent>
