<div class="event_box">
	<div class="up_coming"><h3>Upcomming Events</h3></div>
	<cfoutput query="rc.qList">
		<div style="height:auto;">
			<span style="vertical-align:top;"><input type="checkbox" name="event_name_check" value="#event_id#" class="event_name_check"></span><a href="#buildURL( 'public:main.details' )#&event_id=#event_id#"> <strong style="font-size:17px;">#event_name#</strong></a></span>
			
			<cfif event_startDate eq event_endDate>
				<p class="event_date">#dateFormat(event_startDate,'mmmm d')# <cfif len(event_startTime) or  len(event_endTime)> @ </cfif> #timeFormat(event_startTime,'hh:mm tt')# <cfif len(event_startTime) and  len(event_endTime)> - </cfif>  #timeFormat(event_endTime,'hh:mm tt')# </p>
			<cfelseif len(event_startDate) and len(event_endDate)>
				<p class="event_date">#dateFormat(event_startDate,'mmmm d')# - #dateFormat(event_endDate,'d')# </p>
			<cfelse>
				<p class="event_date">#dateFormat(event_startDate,'mmmm d')#</p>
			</cfif>
			
			<!---<div class="event_image">
				<img src="/plugins/#local.rc.pc.getDirectory()#/includes/assets/images/Lighthouse.jpg" style="width:180px; height:120px;">
			</div>--->
			<div class="event_desc">
				#event_excerpt#
			</div>
			<a href="#buildURL( 'public:main.details' )#&event_id=#event_id#">Find out more>></a>
		</div>
		<div style="clear:both;">&nbsp;</div>
	</cfoutput>
</div>
<cfoutput>
<div id="pagenation">
	<cfset search_string = "">
	<cfif len(rc.searchterm) OR len(rc.searchdate)>
		<cfset search_string = "&searchterm=#rc.searchterm#&searchdate=#rc.searchdate#">
	</cfif>
   <cfif ceiling(val(rc.qCount.recordcount)/#rc.eventsPerPage#) gt 1>     
           <cfif rc.pageNo neq 1>
               <cfset prev=rc.pageNo-1>
               <span id="list_previous" class="pull-left"><a href="#buildURL( 'public:main.list')#&pageNo=#prev##search_string#"><i class="icon-backward"> Previous Events</i></a></span>
           </cfif>
           <cfif rc.pageNo neq #ceiling(val(rc.qCount.recordcount)/rc.eventsPerPage)# >
               <cfset next=rc.pageNo+1>
               <span id="list_next" class="pull-right"><a href="#buildURL( 'public:main.list')#&pageNo=#next##search_string#"><li class="icon-forward"> Next Events</li></a></span>
           </cfif>
   </cfif>        
</div>
<cfif rc.qShowLove.setting_value EQ "YES">
	<div style="clear:both;"></div>
	<p class="developer">This event calendar plugin developed by <a href="http://www.mitrahsoft.com">MitrahSoft</a></p>
</cfif>
</cfoutput>