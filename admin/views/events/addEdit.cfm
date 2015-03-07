<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->

<cfoutput>
	<cfif val(rc.event_id)>
		<h1>Edit Event</h1>
	<cfelse>
		<h1>Add Event</h1>
	</cfif>
	
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildURL('admin:events')#" class="btn"><i class="icon-circle-arrow-left"></i> Back to Events</a>
 	</div>
	<p>(*Required)</p>
	<div class="tabbable tabs-left">
		<ul class="nav nav-tabs tabs initActiveTab">
			<li class="active"><a data-toggle="tab" id="tabDetails" href="##"><span>Details</span></a></li>
			<li><a data-toggle="tab" id="tabLocation" href="##"><span>Location</span></a></li>
			<li><a data-toggle="tab" id="tabOrganizer" href="##"><span>Organizer</span></a></li>
		</ul>
		<div class="tab-content row-fluid">
			<form class="" novalidate="novalidate" name="form1" action="#buildurl('events.save')#" method="post" onsubmit="return validate(this);">
			<input type="hidden" id="event_id" name="event_id"  value="#rc.qData.event_id#">
				<div class="fieldset">
					<div id="Location" style="display:none;">
						<div class="control-group">
							<div class="controls">
								<label class="checkbox" for="addNewLocation">Add New Location
								<input type="checkbox" name="addNewLocation" id="addNewLocation" value="1"></label>
							</div>
						</div>
						<div id="showLocations">
							<div class="control-group">
								<label class="control-label" for="location_id">Location*</label>
								<div class="controls">
									
									<select name="locationID" class="select2" id="locationID" style="width:300px" required="true" message="Location is required"> 
										<option  value="">-- Select location--</option>
										<cfloop query="rc.qLocation">
											<option  value="#rc.qLocation.location_id#"<cfif rc.qLocation.location_id eq rc.qData.location_id>selected="selected"</cfif>>#rc.qLocation.location_name#</option>
										</cfloop>
									</select>
								</div>
							</div>
						</div>
						<div  id="LocationDetails" class="span12" style="display:none; margin-left:0px;">
							<div <cfif val(rc.qGMap.setting_value)>class="span7"</cfif>>
								<input name="location_lat" id="location_lat" type="hidden" value="" />
								<input name="location_lng" id="location_lng" type="hidden" value="" />
								<div class="control-group">
									<label class="control-label" for="location_name">Name*</label>
									<div class="controls">
										<input type="text" id="location_name" name="location_name" placeholder="Enter Location Name" message="Location Name is required" class="required_location span6" value="">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="location_address">Address*</label>
									<div class="controls">
										<input type="text" id="location_address" name="location_address" placeholder="Enter Location Address" class="required_location span6" message="Location Address is required" value="">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="location_city">City*</label>
									<div class="controls">
										<input type="text" id="location_city" name="location_city" placeholder="Enter Location City" class="required_location span6" message="Location City is required" value="">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="location_state">State*</label>
									<div class="controls">
										<input type="text" id="location_state" name="location_state" placeholder="Enter Location State" class="required_location span6" message="Location State is required" value="">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="location_country">Country*</label>
									<div class="controls">
										<select name="location_country" class="select2" id="location_country" style="width:300px" message="Location Country is required">
											<option value="">Select Country</option>
											<cfloop from="1" to="#arraylen(application.countries)#" index="i">
												<cfset application.countries[i] = trim(#application.countries[i]#)>
												<option value="#application.countries[i]#" >#application.countries[i]#</option>
											</cfloop>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Postal code</label>
									<div class="controls">
										<input type="text" id="location_postal_code" class="span6" name="location_postal_code" placeholder="Enter Location Postal Code"  value="">
									</div>
								</div>
							</div>
							<div class="" id="map_holder" style="display:none;">
								<div id="map_canvas" class="" style="height:300px;width:300px;"></div>
							</div>
						</div>
					</div>
					
					<div id="Organizer" style="display:none;">
						<div class="control-group">
							<div class="controls">
								<label class="checkbox" for="addNewOrganizer">Add New Organizer
								<input type="checkbox" name="addNewOrganizer" id="addNewOrganizer" value="1"></label>
							</div>
						</div>
						<div id="showOrganizers">
							<div class="control-group">
								<label class="control-label" for="organizer_id">Organizer*</label>
								<div class="controls">
									<select name="organizerID" class="select2" id="organizerID" style="width:300px" required="true" message="Organizer is required">
										<option  value="">-- Select organizer--</option>
										<cfloop query="rc.qOrganizers">
											<option  value="#rc.qOrganizers.organizer_id#"<cfif rc.qOrganizers.organizer_id eq rc.qData.organizer_id>selected="selected"</cfif>>#rc.qOrganizers.organizer_name#</option>
										</cfloop>
									</select>
								</div>
							</div>
						</div>
						<div id="organizerDetails" class="span12" style="display:none;">
							<div class="span5">
								<div class="control-group">
									<label class="control-label" for="organizer_name">Organizer Name</label>
									<div class="controls">
										<input type="text" id="OrganizerName" class="span" name="OrganizerName" placeholder="Enter Organizer Name"  <!---required="true"---> message="Organizer Name is required"  value="">
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="organizer_phone">Organizer Phone</label>
									<div class="controls">
										<input type="text" id="OrganizerPhone" class="span" name="OrganizerPhone" validate ="phone" message="Enter Valid Phone Number" placeholder="Enter Organizer Phone"  value="">
									</div>
								</div>
							</div>
							<div class="span6">
								<div class="control-group">
									<label class="control-label" for="organizer_email">Organizer Email</label>
									<div class="controls">
										<input type="text" id="OrganizerEmail" class="span" name="OrganizerEmail" placeholder="Enter Organizer Email" validate ="email" message="Enter Valid Email" value="">
									</div>
								</div>
								
								<div class="control-group">
									<label class="control-label" for="organizer_website">Organizer Website</label>
									<div class="controls">
										<input type="text" id="OrganizerWebsite" class="span" name="OrganizerWebsite"  validate="regex" data-regex="^(https?|ftp|file)://.+$" message="Enter Valid URL" placeholder="Enter Organizer Website"  value="">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="addDetails">
						<div class="control-group">
							<label class="control-label" for="event_name">Name*</label>
							<div class="controls">
								<input type="text" id="Name" name="Name" placeholder="Enter Name" class="span12" required="true" message="Name is required" value="#rc.qData.event_name#">
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="event_desc">Description</label>
							<div class="controls">
								<textarea cols="80" id="Desc" name="Desc" rows="10">#rc.qData.event_desc#</textarea>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="event_excerpt">Excerpt</label>
							<div class="controls">
								<textarea cols="80" id="Excerpt" name="Excerpt" rows="10">#rc.qData.event_excerpt#</textarea>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="term_id">Tags</label>
							<div class="controls">
								<select style="display:none;" id="tags">
									<cfloop query="rc.qTags">
										<option value="#term_id#"<cfif listContains(rc.tagIdList,term_id)>selected="selected"</cfif>>#term_name#</option>
									</cfloop>
								</select>
								<select multiple name="term_id" id="term_id" style="width:300px" class="appendTags select2"></select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="term_id">Category*</label>
							<div class="controls">
								<select name="event_category" class="select2" id="event_category" style="width:300px" required="true" message="Category is required">
									<option value=""></option>
									<cfloop query="rc.qCategory">
										<option value="#term_id#" <cfif rc.qData.event_category eq term_id>selected="selected"</cfif>>#term_name#</option>
									</cfloop>
								</select>
							</div>
						</div>


						<div class="control-group">
							<label class="control-label" for="event_startDate">Start Date*</label>
							<div class="controls">
								<input type="text" id="StartDate" name="StartDate" placeholder="Enter Start Date" class="datepicker span3" required="true" message="Start Date is required" value="#dateformat(rc.qData.event_startDate,"mm/dd/yyyy")#">
								
								<select name="startHour" class="select2" id="startHour" style="width:4.8em;">
									<cfloop from="1" to="12" index="h">
										<option value="#h#"<cfif rc.sTime eq h>selected="selected"</cfif>>#h#</option>
									</cfloop>
								</select>
								
								<select name="startMinute" class="select2" id="startMinute" style="width:4.8em">
									<cfloop from="0" to="59" index="m">
										<option value="#m#"<cfif rc.sMins eq m>selected="selected"</cfif>>#iif(len(m) eq 1,de('0#m#'),de('#m#'))#</option>
									</cfloop>
								</select>
								
								<select name="startDayPart" class="select2" id="startDayPart" style="width:4.8em">
									<option value="1">AM</option>
									<option value="2"<cfif rc.sdayPart eq 2>selected="selected"</cfif>>PM</option>
								</select>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="event_endDate">End Date*</label>
							<div class="controls">
								<input type="text" id="EndDate" name="EndDate" placeholder="Enter End Date" class="datepicker span3" required="true" message="End Date is required" value="#dateformat(rc.qData.event_endDate,"mm/dd/yyyy")#">
								<select name="Endhour" class="select2" id="Endhour" style="width:4.8em">
									<cfloop from="1" to="12" index="h">
										<option value="#h#"<cfif rc.eTime eq h>selected="selected"</cfif>>#h#</option>
									</cfloop>
								</select>
								
								<select name="EndMinute" class="select2" id="EndMinute" style="width:4.8em">
									<cfloop from="0" to="59" index="m">
										<option value="#m#"<cfif rc.eMins eq m>selected="selected"</cfif>>#iif(len(m) eq 1,de('0#m#'),de('#m#'))#</option>
									</cfloop>
								</select>
								
								<select name="EndDayPart" class="select2" id="EndDayPart" style="width:4.8em">
									<option value="1">AM</option>
									<option value="2"<cfif rc.edayPart eq 2>selected="selected"</cfif>>PM</option>
								</select>
								
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for="event_website">Website</label>
							<div class="controls">
								<input type="text" id="Website" name="Website" class="span12"  validate="regex" data-regex="^(https?|ftp|file)://.+$" message="Enter Valid URL" placeholder="Enter Website" value="#rc.qData.event_website#">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="event_excerpt">All day event </label>
							<div class="controls">
								<input type="checkbox" name="event_allDay" id="event_allDay" value="true" <cfif rc.qData.event_allDay eq "true"> checked=checked</cfif>>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="recurringEvent">Recurring event </label>
							<div class="controls">
								<input type="checkbox" name="recurringEvent" id="recurringEvent" value="1" <cfif val(rc.event_id) AND rc.qData.recurringType NEQ "none"> checked=checked</cfif>>
							</div>
						</div>
						<div class="control-group" <cfif rc.qData.recurringType EQ "" OR rc.qData.recurringType EQ "none">style="display:none;"</cfif> id="recurringSelect">
							<label class="control-label" for="recurringType">Recurring Type*</label>
							<div class="controls">
								<select name="recurringType" class="select2" id="recurringType" style="width:300px" message="Recurring Type is required">
									<option value="Weekly" <cfif rc.qData.recurringType eq 'Weekly'>selected="selected"</cfif>>Weekly</option>
									<option value="Monthly" <cfif rc.qData.recurringType eq 'Monthly'>selected="selected"</cfif>>Monthly</option>
									<option value="Yearly" <cfif rc.qData.recurringType eq 'Yearly'>selected="selected"</cfif>>Yearly</option>
								</select>
							</div>
						</div>
					</div>
					<div class="form-actions">
						<button class="btn btn-primary" type="submit"name="AddEdit"><i class="icon-check"></i>Save changes</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</cfoutput>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
<link href="http://ivaynberg.github.io/select2/select2-3.4.3/select2.css?ts=2013-09-17T19%3A01%3A19-07%3A00" rel="stylesheet"/>
<script src="http://ivaynberg.github.io/select2/select2-3.4.3/select2.js?ts=2013-09-17T19%3A01%3A19-07%3A00"></script>
<script>
	
	$(function(){  
	    var opts = $("#tags").html(), opts2 = "<option></option>" + opts;
	    $("select.appendTags").each(function(){
	        var e = $(this);
	        e.html(e.hasClass("placeholder") ? opts2 : opts);
	    });
		
		$(".select2").select2();
	});

	
	CKEDITOR.replace( 'Desc', {
           extraPlugins: 'magicline,media,justify,gmap,templates,muratag,showblocks,find',
		   height: '400px',        
           allowedContent: true                
   } );
   CKEDITOR.replace( 'Excerpt', {
           extraPlugins: 'magicline,media,justify,gmap,templates,muratag,showblocks,find',        
           allowedContent: true                
   } );
   
   $('#tabOrganizer').click(function(){
   		$('#Organizer').show();
		$('#Location').hide();
		$('#addDetails').hide();
   });
	
	$('#tabLocation').click(function(){
   		$('#Organizer').hide();
		$('#Location').show();
		$('#addDetails').hide();
   });
   
   $('#tabDetails').on ("click",function(){
   		$('#Organizer').hide();
		$('#Location').hide();
		$('#addDetails').show();
   });
   
   $('#recurringEvent').click(function() {
		if ($(this).is(':checked')) {
			$('#recurringSelect').show();
			$("#recurringType")[0].setAttribute("required", "true");
		}
		else {
			$('#recurringSelect').hide();
			$("#recurringType").removeAttr('required');
		}
	});
   
	$('#addNewLocation').click(function() {
		if ($(this).is(':checked')) {
			$("#showLocations").hide();
			$('#LocationDetails').show();
			$("#locationID").removeAttr('required');
			$("#locationID").css("display","none");
			$("#location_name")[0].setAttribute("required", "true");
			$("#location_address")[0].setAttribute("required", "true");
			$("#location_city")[0].setAttribute("required", "true");
			$("#location_state")[0].setAttribute("required", "true");
			$("#location_country")[0].setAttribute("required", "true");
		}
		else {
			$("#showLocations").show();
			$('#LocationDetails').hide();
			$("#locationID").removeAttr("style");
			$("#location_name,#location_address,#location_city,#location_state,#location_country").removeAttr('required');
			$("#locationID")[0].setAttribute("required", "true");
		}
	});
	
	$('#addNewOrganizer').click(function() {
		if ($(this).is(':checked')) {
			$('#showOrganizers').hide();
			$('#organizerDetails').show();
			$("#organizerID").css("display","none");
			$("#organizerID").removeAttr('required');
			$("#OrganizerName")[0].setAttribute("required", "true");
		}
		else {
			$('#showOrganizers').show();
			$('#organizerDetails').hide();
			$("#organizerID")[0].setAttribute("required", "true");
			$("#organizerID").removeAttr("style");
			$("#OrganizerName").removeAttr('required');
			
		}
	});
		
		var geocoder;
		var map;
		var marker;
		var enablemap = '#val(rc.qGMap.setting_value)#';
	
	function initialize() {
		geocoder = new google.maps.Geocoder();
		var latlng = new google.maps.LatLng(-34.397, 150.644);
		var mapOptions = {
			zoom: 8,
			center: latlng,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		}
		map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
		
		if ($('#location_address').val() != "" && $('#location_city').val() != "" && $('#location_country').val() != "" && enablemap) {
			codeAddress();
			$('#map_holder').css('display', 'block');
		}
	}
	
	function toggleBounce() {
		if (marker.getAnimation() != null) {
			marker.setAnimation(null);
		} else {
			marker.setAnimation(google.maps.Animation.BOUNCE);
		}
	}

	function codeAddress() {
		var address="";
		//initialize();
		$.each( $("#location_name, #location_address, #location_city, #location_country"),function(element){
			if($(this).val() !=""){
				if(address != ""){address+=", "}
				address+= $(this).val();
				
			}
		});
		
		geocoder.geocode( { 'address': address}, function(results, status) {//console.log(address);
		
			if (status == google.maps.GeocoderStatus.OK) {
				var location = results[0].geometry.location;
				if(marker){
			        marker.setPosition(location);
				} else {
					marker = new google.maps.Marker({
						map: map,
						draggable:true,
						position: location
					});
				}
				map.setCenter(marker.getPosition());
				document.getElementById("location_lat").value=marker.getPosition().lat();
				document.getElementById("location_lng").value=marker.getPosition().lng();
				google.maps.event.addListener(marker, 'click', toggleBounce);
			
				google.maps.event.addListener(marker, "drag", function(){
					document.getElementById("location_lat").value=marker.getPosition().lat();
					document.getElementById("location_lng").value=marker.getPosition().lng();
			    });
			}
			else if(enablemap){
				userMessage(message="Location Not Found in Map. You can search for a nearest city and drag to the exact location.", type="warning");
			}
		});
	}

	google.maps.event.addDomListener(window, 'load', initialize);
	
	$("#location_name, #location_address, #location_city, #location_country").on('change', function(){
		if ($('#location_address').val() != "" && $('#location_city').val() != "" && $('#location_country').val() != "") {
			codeAddress();
			if(enablemap){
				$('#map_holder').css('display', 'block');
			}
			google.maps.event.trigger(map, 'resize');
		}
		else if(enablemap) {
			$('#map_holder').css('display', 'none');
		}
	});
</script>

