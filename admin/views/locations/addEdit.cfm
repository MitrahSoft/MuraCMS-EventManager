<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->
<!---<link href="/maps/documentation/javascript/examples/default.css" rel="stylesheet">--->
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
<cfoutput>
	<cfif val(rc.location_id)>
		<legend>Edit Location</legend>
	<cfelse>
		<legend>Add Location</legend>
	</cfif>
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildURL('admin:locations')#" class="btn"><i class="icon-circle-arrow-left"></i> Back to Locations</a>
	 </div>
	 <p>(*Required)</p>
	<form class="fieldset-wrap" novalidate="novalidate" action="#buildurl('locations.save')#" method="post" onsubmit="return validate(this);">
		<input type="hidden" id="location_id" name="location_id"  value="#rc.qData.location_id#">
		<input type="hidden" id="location_lat" name="location_lat" value="#rc.qData.location_lat#">
		<input type="hidden" id="location_lng" name="location_lng" value="#rc.qData.location_lng#">
		<div class="fieldset <cfif rc.qGMap.setting_value>span7</cfif>">
			<div class="control-group">
				<label class="control-label" for="location_name">Name*</label>
				<div class="controls">
					<input type="text" id="location_name" name="location_name" placeholder="Enter Location Name" required="true" message="Name is required" class="span12" value="#rc.qData.location_name#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="location_address">Address*</label>
				<div class="controls">
					<input type="text" id="location_address" name="location_address" placeholder="Enter Location Address" class="span12" required="true" message="Address is required" value="#rc.qData.location_address#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="location_city">City*</label>
				<div class="controls">
					<input type="text" id="location_city" name="location_city" placeholder="Enter Location City" class="span12" required="true" message="City is required" value="#rc.qData.location_city#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="location_state">State*</label>
				<div class="controls">
					<input type="text" id="location_state" name="location_state" placeholder="Enter Location State" class="span12" required="true" message="State is required" value="#rc.qData.location_state#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="location_country">Country*</label>
				<div class="controls">
					<select name="location_country" id="location_country" style="width:300px" required="true" message="Country is required">
						<option value="">---Select Country----</option>
						<cfloop from="1" to="#arraylen(application.countries)#" index="i">
							<cfset country = trim(#application.countries[i]#)>
							<option value="#country#" <cfif rc.qData.location_country EQ country>selected="selected"</cfif> >#country#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">Postal code</label>
				<div class="controls">
					<input type="text" id="location_postal_code" class="span12" name="location_postal_code" placeholder="Enter Location Postal Code"  value="#rc.qData.location_postal_code#">
				</div>
			</div>
			<div class="form-actions">
				<button class="btn btn-primary" type="submit"name="AddEdit"><i class="icon-check"></i>Save changes</button>
			</div>
		</div>
		<div class="" id="map_holder" style="display:none;">
			<div id="map_canvas" class="" style="height:300px;width:300px;"></div>
		</div>
	</form>
</cfoutput>
<link href="http://ivaynberg.github.io/select2/select2-3.4.3/select2.css?ts=2013-09-17T19%3A01%3A19-07%3A00" rel="stylesheet"/>
<script src="http://ivaynberg.github.io/select2/select2-3.4.3/select2.js?ts=2013-09-17T19%3A01%3A19-07%3A00"></script>
<script>
	$(function(){
		$('#location_country').select2();
		  
		var opts = $("#country").html(), opts2 = "<option></option>" + opts;
	    $("select.appendCountry").each(function(){
	        var e = $(this);
	        e.html(e.hasClass("placeholder") ? opts2 : opts);
	    });
		
	});
	
	var geocoder;
	var map;
	var marker;
	var isEditpage = '<cfoutput>#val(rc.location_id)#</cfoutput>';
	var enablemap = '<cfoutput>#val(rc.qGMap.setting_value)#</cfoutput>';
	
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
		
			if (status == google.maps.GeocoderStatus.OK || isEditpage) {
				if(isEditpage != 0){
					var location = new google.maps.LatLng($('#location_lat').val(), $('#location_lng').val());
					isEditpage = 0;
				}
				else{
					var location = results[0].geometry.location;
				}
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