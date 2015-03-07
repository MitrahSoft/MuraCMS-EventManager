<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>

<cfoutput>
	<div>
		<h3>#rc.qList.event_name#</h3>
		<span class="s_e_date">Event tag(s)</span>:
		<cfif len(rc.qList.tag)>
			<cfloop query="rc.qList">
				<a href="#buildURL( 'public:main.list')#&tags=#rc.qList.tag_slug#">#rc.qList.tag#</a><cfif rc.qList.recordCount neq  rc.qList.currentRow>,</cfif>
			</cfloop>
		<cfelse>
			No tag Found.
		</cfif>
		<cfif rc.qList.event_startDate eq rc.qList.event_endDate>
			<p class="event_date">#dateFormat(rc.qList.event_startDate,'mmmm d')# <cfif len(rc.qList.event_startTime) or  len(rc.qList.event_endTime)> @ </cfif> #timeFormat(rc.qList.event_startTime,'hh:mm tt')# <cfif len(rc.qList.event_startTime) and  len(rc.qList.event_endTime)> - </cfif>  #timeFormat(rc.qList.event_endTime,'hh:mm tt')# </p>
		<cfelseif len(rc.qList.event_startDate) and len(rc.qList.event_endDate)>
			<p class="event_date">#dateFormat(rc.qList.event_startDate,'mmmm d')# - #dateFormat(rc.qList.event_endDate,'d')# </p>
		<cfelse>
			<p class="event_date">#dateFormat(rc.qList.event_startDate,'mmmm d')#</p>
		</cfif>
		<p>Download event <a href="#buildURL('public:main.iCalExport')#&event_id=#event_id#">iCal</a></p>
		<p>#rc.qList.event_excerpt#</p>
		<p>#rc.qList.event_desc#</p>
		
		<div class="bottom-box">
			<div class="details">
				<h4>Details</h4>
				<span class="s_e_date">Start:</span><br />
					#dateFormat(rc.qList.event_startDate,'mmmm d,yyyy')#  <cfif len(rc.qList.event_startTime)> @ #timeFormat(rc.qList.event_startTime,'hh:mm tt')# </cfif><br /><br />
				<span class="s_e_date">End</span><br />
					#dateFormat(rc.qList.event_endDate,'mmmm d,yyyy')# <cfif  len(rc.qList.event_endTime)> @ #timeFormat(rc.qList.event_endTime,'hh:mm tt')#</cfif><br /><br />
				<span class="s_e_date">Event Category(ies)</span> <br/>
					<cfif len(rc.qList.category)>
						<a href="#buildURL( 'public:main.list')#&categories=#rc.qList.category_slug#">#rc.qList.category#</a>
					<cfelse>
						No category Found.	
					</cfif>	
			</div>
			<div class="venue">
				<h4>Venue</h4>
				<p>#rc.qList.location_name#</p>
				<address>#rc.qList.location_address# <cfif len(rc.qList.location_postal_code)>-#rc.qList.location_postal_code#</cfif> </address>
				<p>#rc.qList.location_city#</p>
				<p>#rc.qList.location_state#</p>
				<p>#rc.qList.location_country#</p>
			</div>
			<cfif rc.qGMap.setting_value>
				<div class="map">
					<h4>Map</h4>
					<div id="map_canvas" class="" style="height:200px;width:200px;"></div>
				</div>
			</cfif>
			
		</div>
	</div>
	<cfif rc.qShowLove.setting_value EQ "YES">
		<div style="clear:both;"></div>
		<p class="developer">This event calendar plugin developed by <a href="http://www.mitrahsoft.com">MitrahSoft</a></p>
	</cfif>
</cfoutput>
<cfif rc.qGMap.setting_value>
	<script>
		var geocoder;
		var lat="<cfoutput>#rc.qList.location_lat#</cfoutput>";
		var lng="<cfoutput>#rc.qList.location_lng#</cfoutput>";
	          var map;
	          function initialize() {
	            geocoder = new google.maps.Geocoder();
	            var latlng = new google.maps.LatLng(lat, lng);
	            var myOptions = {
	              zoom: 8,
	              center: latlng,
	              mapTypeId: google.maps.MapTypeId.ROADMAP
	            }
	            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
				codeAddress()
	          }
		function codeAddress() {
						var location = new google.maps.LatLng(lat, lng);
						marker = new google.maps.Marker({
							map: map,
							position: location
						});
					map.setCenter(marker.getPosition());
				}
		google.maps.event.addDomListener(window, 'load', initialize);
	</script>
</cfif>