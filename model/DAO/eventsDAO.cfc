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
		<cfargument name="locationID" type="any" required="false" default=""/>
		<cfargument name="organizerID" type="any" required="false" default=""/>
		<cfargument name="Name" type="any" required="false" default=""/>
		<cfargument name="Desc" type="any" required="false" default=""/>
		<cfargument name="Excerpt" type="any" required="false" default=""/>
		<cfargument name="StartDate" type="any" required="false" default=""/>
		<cfargument name="EndDate" type="any" required="false" default=""/>
		<cfargument name="StartTime" type="any" required="false" default=""/>
		<cfargument name="EndTime" type="any" required="false" default=""/>
		<cfargument name="Website" type="any" required="false" default=""/>
		<cfargument name="event_category" type="any" required="false" />
		<cfargument name="event_allDay" type="any" required="false" default=""/>
		<cfargument name="recurringType" type="any" required="false" default="none"/>
		
		<cfset var qry="" />
				
		<cfquery name="qry" datasource="#variables.dsn#" result="result">
			INSERT INTO mitrah_em_events
			(
				location_id,organizer_id,event_name,event_desc,event_excerpt,event_startDate,event_endDate,event_startTime,event_endTime,event_website,event_category,event_allDay,event_siteId,recurringType
			)
			values
			(
			<cfqueryparam value='#arguments.locationID#' cfsqltype='cf_sql_varchar'>,
			<cfqueryparam value='#arguments.organizerID#' cfsqltype='cf_sql_varchar'>,
			<cfqueryparam value='#arguments.Name#' cfsqltype='cf_sql_varchar'>,
			<cfqueryparam value='#arguments.Desc#' cfsqltype='cf_sql_varchar'>,
			<cfqueryparam value='#arguments.Excerpt#' cfsqltype='cf_sql_varchar'>,
			<cfqueryparam value='#arguments.StartDate#' cfsqltype='cf_sql_date'>,
			<cfqueryparam value='#arguments.EndDate#' cfsqltype='cf_sql_date'>,
			<cfqueryparam value='#arguments.StartTime#' cfsqltype='cf_sql_time'>,
			<cfqueryparam value='#arguments.EndTime#' cfsqltype='cf_sql_time'>,
			<cfqueryparam value='#arguments.Website#' cfsqltype='cf_sql_varchar'>,
			<cfqueryparam value='#arguments.event_category#' cfsqltype='cf_sql_integer' >,
			<cfqueryparam value='#arguments.event_allDay#' cfsqltype='cf_sql_varchar' >,
			<cfqueryparam value='#session.siteid#' cfsqltype='cf_sql_varchar' >,
			<cfqueryparam value='#arguments.recurringType#' cfsqltype='cf_sql_varchar' >
			)			
		</cfquery>

		<cfreturn evaluate(#variables.key_generated#)>	
	</cffunction>
	
	
	<cffunction name="read" returntype="Query" >
		<cfargument name="event_id" type="any" required="false" />
		<cfargument name="searchDate" type="any" required="false" default=""/>
		<cfargument name="searchTerm" type="any" required="false" default=""/>
		<cfargument name="status" type="any" required="false" />
		<cfargument name="start" type="any" required="false" />
		<cfargument name="end" type="any" required="false" />
		<cfargument name="locationId" type="any" required="false" />
		<cfargument name="organizerID" type="any" required="false" />
		<cfargument name="tags" type="any" required="false" />
		<cfargument name="categories" type="any" required="false" />
		<cfargument name="pageNo" type="any" required="false" />
		<cfargument name="eventsperpage" type="any" required="false" default="0"/>
		<cfargument name="datafeed" type="any" required="false" default="0"/>
		
		<cfset var qry="" />
		
		<cfif variables.dbType EQ 'mysql'>
			<cfif structKeyExists(arguments,"pageNo") and structKeyExists(arguments,"eventsPerPage")> 
		     	<cfset  range_from=(arguments.pageNo-1)*arguments.eventsPerPage>
			  </cfif>
		      
		       <cfquery name="qry" datasource="#variables.dsn#">
			   	   SELECT e.*,l.*,o.organizer_name,o.organizer_email,ct.term_name AS category,ct.term_slug AS category_slug,ct.term_bg_color AS category_bg_color,
					 t.term_name AS tag,t.term_id AS tagId ,t.term_slug AS tag_slug
					 FROM mitrah_em_events AS e
					 INNER JOIN mitrah_em_organizers AS o ON e.organizer_id = o.organizer_id
					 INNER JOIN mitrah_em_locations AS l ON e.location_id = l.location_id
					 INNER JOIN mitrah_em_term AS ct ON ct.term_id = e.event_category
					 LEFT JOIN mitrah_em_event_term_relationship AS etr ON e.event_id = etr.event_id
					 LEFT JOIN mitrah_em_term AS t	ON etr.term_id = t.term_id
		            WHERE  event_siteId = <cfqueryparam value="#session.siteid#" cfsqltype="cf_sql_varchar" >
		           
		           <cfif structKeyExists(arguments,"locationId")>
		                   AND e.location_id = <cfqueryparam value='#arguments.locationId#' cfsqltype='cf_sql_varchar'>
		           </cfif>
		           
		           <cfif structKeyExists(arguments,"organizerID")>
		                   AND e.organizer_id = <cfqueryparam value='#arguments.organizerID#' cfsqltype='cf_sql_varchar'>
		           </cfif>
		           <cfif structKeyExists(arguments,"event_id")>
		                   AND e.event_id = <cfqueryparam value='#arguments.event_id#' cfsqltype='cf_sql_varchar'>
		           </cfif>
		           <cfif structKeyExists(arguments,"searchTerm") and len(arguments.searchTerm)>
		                   AND e.event_name like <cfqueryparam value='%#arguments.searchTerm#%' cfsqltype='cf_sql_varchar'>
		           </cfif>
		           <cfif structKeyExists(arguments,"searchDate") and len(arguments.searchDate) and isDate(arguments.searchDate)>
		                   AND e.event_startDate >= <cfqueryparam value='#arguments.searchDate#' cfsqltype='cf_sql_date' >
		           </cfif>
		           
		           <cfif structKeyExists(arguments,"start")  and  structKeyExists(arguments,"end") AND val(arguments.datafeed)>
		                 AND (e.event_startDate BETWEEN '#arguments.start#' AND '#arguments.end#')
						 OR e.recurringType != <cfqueryparam value='none' cfsqltype="cf_sql_varchar"  >
		           </cfif>
		           
		           <cfif structKeyExists(arguments,"status") and status EQ 'Completed'>
		                   AND e.event_startDate < <cfqueryparam value='#now()#' cfsqltype='cf_sql_date' >
		           <cfelseif structKeyExists(arguments,"status") and status EQ 'upcoming'>
		                   AND e.event_startDate >= <cfqueryparam value='#now()#' cfsqltype='cf_sql_date' >
		           </cfif>
		           
		           <cfif structKeyExists(arguments,"tags") and len(arguments.tags)>
		                   AND t.term_slug = <cfqueryparam value='#arguments.tags#' cfsqltype="cf_sql_varchar"  >
				   </cfif>
				   <cfif structKeyExists(arguments,"categories") and len(arguments.categories) >	      
						    AND  ct.term_slug = <cfqueryparam value='#arguments.categories#' cfsqltype="cf_sql_varchar"  >
		           </cfif>
		           
		           <cfif not structKeyExists(arguments,"event_id")>
		           		Group by e.event_id
				   </cfif>	   
		           ORDER BY e.event_startDate ASC
				   
		           <cfif structKeyExists(variables,"range_from") and structKeyExists(arguments,"eventsPerPage")>
		                   LIMIT #variables.range_from#, #arguments.eventsPerPage#
		           </cfif>
		               
		       </cfquery>
		<cfelseif variables.dbType EQ 'mssql'>
			<cfquery name="qry" datasource="#variables.dsn#">
			
				SELECT  <cfif val(arguments.eventsperpage)>top #arguments.eventsperpage# </cfif> * FROM 
	               (
	                   SELECT  ROW_NUMBER() OVER (ORDER BY event_id) AS num,temp.*
	                   FROM (
		                        SELECT  distinct e.event_id, e.recurringType, e.organizer_id,e.event_category,e.event_name,e.event_startDate,e.event_endDate,e.event_startTime,e.event_endTime, CAST(e.event_excerpt AS varchar(max)) as event_excerpt,CAST(e.event_desc AS varchar(max)) as event_desc, 
		                        event_website,event_allDay,l.*,o.organizer_name,o.organizer_email,ct.term_name AS category,ct.term_slug AS category_slug,ct.term_bg_color AS category_bg_color
			                     <cfif structKeyExists(arguments,'event_id')>
			                   		,t.term_name AS tag,t.term_id AS tagId ,t.term_slug AS tag_slug
								 </cfif>	
			                   FROM mitrah_em_events e
			                   INNER JOIN mitrah_em_term AS ct ON ct.term_id = e.event_category
							   LEFT JOIN mitrah_em_event_term_relationship AS etr ON e.event_id = etr.event_id
							   LEFT JOIN mitrah_em_term AS t	ON etr.term_id = t.term_id
							   INNER JOIN mitrah_em_organizers AS o ON e.organizer_id = o.organizer_id 
							   INNER JOIN mitrah_em_locations AS l ON e.location_id = l.location_id 
							   
							   WHERE  event_siteId = <cfqueryparam value="#session.siteid#" cfsqltype="cf_sql_varchar" >
							      
								<cfif structKeyExists(arguments,"event_id")>
					                   AND e.event_id = <cfqueryparam value='#arguments.event_id#' cfsqltype='cf_sql_varchar'>
					           </cfif>
					           
					           <cfif structKeyExists(arguments,"locationId")>
					                   AND e.location_id = <cfqueryparam value='#arguments.locationId#' cfsqltype='cf_sql_varchar'>
					           </cfif>
					           
					           <cfif structKeyExists(arguments,"organizerID")>
					                   AND e.organizer_id = <cfqueryparam value='#arguments.organizerID#' cfsqltype='cf_sql_varchar'>
					           </cfif>
							   <cfif structKeyExists(arguments,"searchTerm") and len(arguments.searchTerm)>
					                   AND e.event_name like <cfqueryparam value='%#arguments.searchTerm#%' cfsqltype='cf_sql_varchar'>
					           </cfif>
					           <cfif structKeyExists(arguments,"searchDate") and len(arguments.searchDate) and isDate(arguments.searchDate)>
					                   AND e.event_startDate >= <cfqueryparam value='#arguments.searchDate#' cfsqltype='cf_sql_date' >
					           </cfif>
					           
					           <cfif structKeyExists(arguments,"start")  and  structKeyExists(arguments,"end")>
					                 AND (e.event_startDate BETWEEN '#arguments.start#' AND '#arguments.end#')
									 OR e.recurringType != <cfqueryparam value='none' cfsqltype="cf_sql_varchar">
					           </cfif>
					           
					           <cfif structKeyExists(arguments,"status") and status EQ 'Completed'>
					                   AND e.event_startDate < <cfqueryparam value='#now()#' cfsqltype='cf_sql_date' >
					           <cfelseif structKeyExists(arguments,"status") and status EQ 'upcoming'>
					                   AND e.event_startDate >= <cfqueryparam value='#now()#' cfsqltype='cf_sql_date' >
					           </cfif>
					           
					           <cfif structKeyExists(arguments,"tags") and len(arguments.tags)>
					                   AND t.term_slug = <cfqueryparam value='#arguments.tags#' cfsqltype="cf_sql_varchar"  >
							   </cfif>
							   <cfif structKeyExists(arguments,"categories") and len(arguments.categories) >	      
									    AND  ct.term_slug = <cfqueryparam value='#arguments.categories#' cfsqltype="cf_sql_varchar"  >
					           </cfif>
	                   )AS temp
	               ) AS a
	              <cfif val(arguments.eventsperpage)>
	           		 WHERE num > (#(arguments.pageNo-1)*arguments.eventsperpage#) ORDER BY num
				  </cfif>	
				  
			</cfquery>
		</cfif>
		
		<cfreturn qry> 	
	</cffunction>
   
   
			
	<cffunction name="update" returntype="void">
		<cfargument name="locationID" type="any" required="false" default=""/>
		<cfargument name="organizerID" type="any" required="false" default=""/>
		<cfargument name="Name" type="any" required="false" default=""/>
		<cfargument name="Desc" type="any" required="false" default=""/>
		<cfargument name="Excerpt" type="any" required="false" default=""/>
		<cfargument name="StartDate" type="any" required="false" default=""/>
		<cfargument name="EndDate" type="any" required="false" default=""/>
		<cfargument name="StartTime" type="any" required="false" default=""/>
		<cfargument name="EndTime" type="any" required="false" default=""/>
		<cfargument name="Website" type="any" required="false" default=""/>
		<cfargument name="event_id" type="any" required="false" />
		<cfargument name="event_category" type="any" required="false" />
		<cfargument name="event_allDay" type="any" required="false" default=""/>
		<cfargument name="recurringType" type="any" required="false" default="none"/>
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			UPDATE mitrah_em_events
			SET location_id = <cfqueryparam value='#arguments.locationID#' cfsqltype='cf_sql_integer'>,
				organizer_id = <cfqueryparam value='#arguments.organizerID#' cfsqltype='cf_sql_integer'>,
				event_name = <cfqueryparam value='#arguments.Name#' cfsqltype='cf_sql_varchar'>, 
				event_desc = <cfqueryparam value='#arguments.Desc#' cfsqltype='cf_sql_varchar'>,
				event_excerpt = <cfqueryparam value='#arguments.Excerpt#' cfsqltype='cf_sql_varchar'>,
				event_startDate = <cfqueryparam value='#arguments.StartDate#' cfsqltype='cf_sql_date'>,
				event_endDate = <cfqueryparam value='#arguments.EndDate#' cfsqltype='cf_sql_date'>,
				event_startTime = <cfqueryparam value='#arguments.StartTime#' cfsqltype='cf_sql_time'>, 
				event_endTime = <cfqueryparam value='#arguments.EndTime#' cfsqltype='cf_sql_time'>, 
				event_website = <cfqueryparam value='#arguments.Website#' cfsqltype='cf_sql_varchar'>,
				event_category = <cfqueryparam value='#arguments.event_category#' cfsqltype='cf_sql_varchar'>,
				event_allDay = <cfqueryparam value='#arguments.event_allDay#' cfsqltype='cf_sql_varchar' >,
				recurringType = <cfqueryparam value='#arguments.recurringType#' cfsqltype='cf_sql_varchar' >
				
				
			WHERE event_id = <cfqueryparam value='#arguments.event_id#' cfsqltype='cf_sql_integer'>

		</cfquery>
		<cfreturn />
	</cffunction>
	
	
	<cffunction name="delete" returntype="void">
		<cfargument name="event_id" type="any" required="false" />
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			DELETE FROM mitrah_em_events
			WHERE event_id = <cfqueryparam value='#arguments.event_id#' cfsqltype='cf_sql_varchar'>
		</cfquery>

		<cfreturn />
	</cffunction>
	
	<cffunction name="iCalGetAll" returntype="query">
		<cfargument name="event_id" type="any" default="" required="false" />
	   <cfset var qry="" />
      
       <cfquery name="qry" datasource="#variables.dsn#">
           SELECT e.event_id,e.event_name as summary, e.event_desc as description, e.event_startdate as startdate, e.event_enddate as enddate, e.event_starttime as starttime, e.event_endtime as endtime,
		   o.organizer_name as organizerName, o.organizer_email as organizerEmail, ct.term_name AS category,
		   l.location_name as locationName, l.location_address as locationAddress, l.location_city as locationCity, l.location_state as locationState, l.location_country as locationCountry
		   
		   FROM mitrah_em_events AS e INNER JOIN mitrah_em_organizers AS o ON e.organizer_id=o.organizer_id
           INNER JOIN mitrah_em_locations AS l ON e.location_id = l.location_id
           INNER JOIN mitrah_em_term AS ct ON ct.term_id = e.event_category
           
           WHERE  event_siteId = <cfqueryparam value="#session.siteid#" cfsqltype="cf_sql_varchar" >
		   
		   <cfif structKeyExists(arguments,"event_id") and  len(arguments.event_id) gt 0>
                AND e.event_id in (<cfqueryparam value='#arguments.event_id#' cfsqltype='cf_sql_varchar' list="true" >)
           </cfif>   
       </cfquery>
       
       <cfreturn qry />
   </cffunction>
   
	<cffunction name="createEventTerm" returntype="any">
		<cfargument name="event_id" type="any" required="false" default=""/>
		<cfargument name="term_id" type="any" required="false" default=""/>
		
		<cfquery name="qry" datasource="#variables.dsn#" result="result">
			INSERT INTO mitrah_em_event_term_relationship
			(
				term_id,event_id
			)
			values
			(
			<cfqueryparam value="#arguments.term_id#" cfsqltype='cf_sql_varchar'>,
			<cfqueryparam value="#arguments.event_id#" cfsqltype='cf_sql_integer'>)
		</cfquery>
	
		<cfreturn evaluate(#variables.key_generated#)>
	</cffunction>
	
	<cffunction name="deleteEventTerm" returntype="void">
		<cfargument name="event_id" type="any" required="false" />
		
		<cfset var qry="" />
		
		<cfquery name="qry" datasource="#variables.dsn#">
			DELETE FROM mitrah_em_event_term_relationship
			WHERE event_id = <cfqueryparam value='#arguments.event_id#' cfsqltype='cf_sql_varchar'>
		</cfquery>

		<cfreturn />
	</cffunction>
	
</cfcomponent>
