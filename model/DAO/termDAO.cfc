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
		<cfargument name="term_type" type="any" required="false" />
		<cfargument name="term_name" type="any" required="false" />
		<cfargument name="term_bg_color" type="any" default="" required="false" />
		<cfargument name="term_slug" type="any" required="false" />
		
		<cfset var qry="" />
				
		<cfquery name="qry" datasource="#variables.dsn#" result="result">
			INSERT INTO mitrah_em_term
			(
				term_type,term_name,term_bg_color,term_slug,term_siteId
			)
			values
			(
				<cfqueryparam value='#arguments.term_type#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.term_name#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.term_bg_color#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#arguments.term_slug#' cfsqltype='cf_sql_varchar'>,
				<cfqueryparam value='#session.siteid#' cfsqltype='cf_sql_varchar' >
			)			
		</cfquery>
		
		<cfreturn evaluate(#variables.key_generated#)>		
	</cffunction>
	
	
	<cffunction name="read" returntype="query">
		<cfargument name="term_id" type="any" required="false" />
		<cfargument name="term_type" type="any" required="false" />
		
		<cfset var qry="" />
		
		
		<cfquery name="qry" datasource="#variables.dsn#">
			SELECT *
			FROM mitrah_em_term
			WHERE term_siteId=<cfqueryparam value="#session.siteid#" cfsqltype="cf_sql_varchar" >
			
			<cfif structKeyExists(arguments,"term_type")>
				AND term_type = <cfqueryparam value='#arguments.term_type#' cfsqltype='cf_sql_varchar'>
			</cfif>
			
			<cfif structKeyExists(arguments,"term_id")>
				AND term_id = <cfqueryparam value='#arguments.term_id#' cfsqltype='cf_sql_varchar'>
			</cfif>
			
		</cfquery>
		
		<cfreturn qry />
	</cffunction>
			
	<cffunction name="update" returntype="void">
		<cfargument name="term_id" type="any" required="false" />
		<cfargument name="term_type" type="any" required="false" />
		<cfargument name="term_name" type="any" required="false" />
		<cfargument name="term_bg_color" default="" type="any" required="false" />
		<cfargument name="term_slug" type="any" required="false" /> 
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			UPDATE mitrah_em_term
			SET term_type = <cfqueryparam value='#arguments.term_type#' cfsqltype='cf_sql_varchar'>, 
				term_name = <cfqueryparam value='#arguments.term_name#' cfsqltype='cf_sql_varchar'>, 
				term_bg_color = <cfqueryparam value='#arguments.term_bg_color#' cfsqltype='cf_sql_varchar'>, 
				term_slug = <cfqueryparam value='#arguments.term_slug#' cfsqltype='cf_sql_varchar'>
			WHERE term_id = <cfqueryparam value='#arguments.term_id#' cfsqltype='cf_sql_integer' >
		</cfquery>
		
		<cfreturn />
	</cffunction>
	
	
	<cffunction name="delete" returntype="void">
		<cfargument name="term_id" type="any" required="false" />
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			DELETE FROM mitrah_em_term
			WHERE term_id = <cfqueryparam value='#arguments.term_id#' cfsqltype='cf_sql_integer' >
		</cfquery>

		<cfreturn />
	</cffunction>
	
</cfcomponent>
