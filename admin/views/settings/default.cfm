<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->

<cfoutput>
	<cfset settingsNames = "">
	<cfloop query="rc.qData" >
		<cfset settingsNames = listappend(settingsNames,'#rc.qData.setting_name#')>
	</cfloop>
	<div>
		<h1>Settings</h1>
		<p>(*Required)</p>
	</div>
	<form name="settings" class="fieldset-wrap" novalidate="novalidate"  action="#buildurl('settings.save')#" method="post" onsubmit="return validate(this);">
		<div class="fieldset">
			
			<input type="hidden" id="setting_id" name="setting_id"  value="#rc.qData.setting_id#">

			
			<div class="control-group">
				<label class="control-label" for="eventsPerPage">Events Per Page*</label>
				<div class="controls">
					<input type="text" id="eventsPerPage" name="eventsPerPage" validate="numeric" placeholder="Enter Number of Events per page" required="true" message="Number of events required" class="number span12" value="#rc.qData.setting_value[listfindnocase(settingsNames,'eventsPerPage')]#">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="enableGoogleMaps">Enable Google Maps</label>
				<div class="controls">
					<input type="checkbox" id="enableGoogleMaps" name="enableGoogleMaps" <cfif rc.qData.setting_value[listfindnocase(settingsNames,'enableGoogleMaps')] EQ "Yes">checked="checked"</cfif>value="Yes">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="enableSearchBar">Enable Search Bar</label>
				<div class="controls">
					<input type="checkbox" id="enableSearchBar" name="enableSearchBar" <cfif rc.qData.setting_value[listfindnocase(settingsNames,'enableSearchBar')] EQ "Yes">checked="checked"</cfif> value="Yes">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="ShowSomeLove">Show Some Love</label>
				<div class="controls">
					<input type="checkbox" id="ShowSomeLove" name="ShowSomeLove" <cfif rc.qData.setting_value[listfindnocase(settingsNames,'ShowSomeLove')] EQ "Yes">checked="checked"</cfif> value="Yes">
				</div>
			</div>
			<div class="form-actions">
				<button class="btn btn-primary" type="submit"name="AddEdit"><i class="icon-check"></i> Save changes</button>
			</div>
		
		</div>
	</form>
</cfoutput>
