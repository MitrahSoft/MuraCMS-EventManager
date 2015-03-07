<cfoutput>
	<cfset vCal = "">
	<cfset CRLF = "#chr(13)#">
	<cfset vCal = "BEGIN:VCALENDAR" & CRLF>
	<cfset vCal = vCal & "PRODID:-//Microsoft Corporation//Outlook 10.0 MIMEDIR//EN" & CRLF>
	<cfset vCal = vCal & "VERSION:2.0" & CRLF>
	<cfset vCal = vCal & "METHOD:PUBLISH" & CRLF>
</cfoutput>	
	<cfoutput query="rc.myEvents">
		<cfset qTag=Application.eventsDAO.read(rc.myEvents.event_id)>
		<cfset tagList=valueList(qTag.tag)>
		
		<cfset  vCal = vCal & "BEGIN:VEVENT" & CRLF>
		<cfset vCal = vCal & "ORGANIZER:MAILTO:#rc.myEvents.ORGANIZEREMAIL#" & CRLF>
		<cfset vCal = vCal & "DTSTART:" & DateFormat(rc.myEvents.Startdate,"yyyymmdd") & "T" & TimeFormat(rc.myEvents.starttime, "HHmmss") & "Z" & CRLF>
		<cfset vCal = vCal & "DTEND:" & DateFormat(rc.myEvents.enddate,"yyyymmdd") & "T" & TimeFormat(rc.myEvents.endTime, "HHmmss") & "Z" & CRLF>
		<cfset vCal = vCal & "LOCATION:" & "#rc.myEvents.locationName# #rc.myEvents.locationAddress# #rc.myEvents.locationCity# #rc.myEvents.locationState# #rc.myEvents.locationCountry#" & CRLF>
		<cfset vCal = vCal & "TRANSP:OPAQUE"  & CRLF>
		<cfset vCal = vCal & "SEQUENCE:0"  & CRLF>
		<cfset vCal = vCal & "DESCRIPTION:">
		<!---Convert CF_CRLF (13_10) into =0D=0A with CR/LF and indent sequences--->
		<cfif len('rc.myEvents.description')>
			<cfset description = REReplace(rc.myEvents.description,"[#Chr(13)##Chr(10)#]", "=0D=0A=#Chr(13)##Chr(10)#     ", "ALL")>
		<cfelse>
			<cfset description = "Autobot VCalendar Generated">
		</cfif>
		<cfset vCal = vCal & description & CRLF>
		<cfset vCal = vCal & "SUMMARY:" & rc.myEvents.summary & CRLF>
		<cfset vCal = vCal & "CATEGORIES:" & rc.myEvents.category  & CRLF>
		<cfset vCal = vCal & "TAGS:" & tagList  & CRLF>
		<cfset vCal = vCal & "PRIORITY:" & 1 & CRLF>
		<cfset vCal = vCal & "CLASS:PUBLIC" & CRLF>
		<cfset vCal = vCal & "END:VEVENT" & CRLF>
	</cfoutput>
<cfoutput>	
	<cfset vCal = vCal & "END:VCALENDAR">   
<cfsetting enablecfoutputonly="no" />
<cfsetting showdebugoutput="false" />
<cfcontent type="text/calendar" >
<cfsilent>
<cfheader name="Content-Disposition" value="attachment; filename=myiCal.ics">


 
<cfcontent
type="text/plain"
variable="#ToBinary( ToBase64(vCal))#"
/>
 
</cfsilent>

</cfoutput>