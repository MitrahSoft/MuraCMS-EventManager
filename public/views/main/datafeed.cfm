<cfset request.layout = false>
[<cfoutput query="rc.qList" group="event_id">
	<!--- When recurring --->
	<cfif recurringType EQ 'Yearly' OR recurringType EQ 'Monthly'>
		<cfif recurringType EQ 'Yearly'>
			<!--- Yearly Recurring --->
			<cfset startdate = createDate(year(rc.sample_date),month(event_startdate),day(event_startdate))>
			<cfset enddate = createDate(year(rc.sample_date),month(event_enddate),day(event_enddate))>
		<cfelseif recurringType EQ 'Monthly'>
			<!--- Monthly Recurring --->
			<cfset startdate = createDate(year(rc.sample_date),month(rc.sample_date),day(event_startdate))>
			<cfset enddate = createDate(year(rc.sample_date),month(rc.sample_date),day(event_enddate))>
		</cfif>
	<cfelse>
		<!--- When not recurring --->
		<cfset startdate = event_startdate>
		<cfset enddate = event_enddate>
	</cfif>
	<cfif recurringType EQ 'Weekly'>
		<cfset firstdate = dateAdd("d",DayOfWeek(event_startdate),rc.start)>
		<cfset lastdate = dateAdd("d",DayOfWeek(event_enddate),rc.start)>
		<cfif dateCompare(firstdate,lastdate)>
			<cfset lastdate = dateAdd("d",7,lastdate)>
		</cfif>
		<cfset stratDateList = firstdate>
		<cfset endDateList = lastdate>
		<cfset to = #int(dateDiff('d',rc.start,rc.end)/7)#-1>
		<cfloop from="1" to="#to#" index="i">
			<cfset stratDateList = listAppend(stratDateList,dateAdd('d' ,i*7,firstdate))>
			<cfset endDateList = listAppend(endDateList,dateAdd('d' ,i*7,lastdate))>
		</cfloop>
		<cfset count = 0>
		<cfloop from="1" to="#listLen(stratDateList)#" index="i">
			<cfset startdate = listGetAt(stratDateList,i)>
			<cfset enddate = listGetAt(endDateList,i)>
		</cfloop>
	<cfelse>
		<cfset duration="#dateDiff('d' ,dateAdd('d',-1,startdate),enddate)#">
		<cfset days_value=''>
		<cfif variables.duration gt 1><cfset days_value="(#duration# days from #dateFormat(startdate ,'dd')#-#dateFormat(enddate ,'dd mmm yyyy')#)"></cfif>
		<cfset description="<span style='color:#category_bg_color#;font:bold 9pt arial'>#event_name#" & days_value &" </span> <br> #dateFormat(startdate ,'dd mmmm yyyy')# <br> #location_state#,#location_Country# <br><span><a href='?#variables.framework.action#=public:main.details&event_id=#event_id#'>More Details</a></span> | <span><a href='#buildURL( 'public:main.iCalExport')#&event_id=#event_id#'><img src='/plugins/#local.rc.pc.getDirectory()#/includes/assets/css/images/calendar_butt_icon.gif'></a></span> <br> <span style='color:##888989'>organized by #organizer_name#</span> ">
		<cfif rc.qList.currentRow neq 1>,</cfif>
	</cfif>
</cfoutput>]
