<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->

<cfoutput>
	<cfif val(rc.ID)>
		<legend>Edit Organizer</legend>
	<cfelse>
		<legend>Add Organizer</legend>
	</cfif>
	
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildURL('admin:organizers')#" class="btn"><i class="icon-circle-arrow-left"></i> Back to organizers</a>
	 </div>
	 <p>(*Required)</p>
	<form name="organizer" class="fieldset-wrap" novalidate="novalidate"  action="#buildurl('organizers.save')#" method="post" onsubmit="return validate(this);">
		<fieldset>
			
			<input type="hidden" id="ID" name="ID"  value="#rc.qData.organizer_id#">
			
			<div class="control-group">
				<label class="control-label" for="organizer_name">Name*</label>
				<div class="controls">
					<input type="text" id="OrganizerName" name="OrganizerName" class="span12" placeholder="Enter Name" required="true" message="Name is required"  value="#rc.qData.organizer_name#">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="organizer_phone">Phone</label>
				<div class="controls">
					<input type="text" id="OrganizerPhone" name="OrganizerPhone" class="span12" validate ="phone" message="Enter Valid Phone Number" placeholder="Enter Phone"  value="#rc.qData.organizer_phone#">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="organizer_email">Email</label>
				<div class="controls">
					<input type="text" id="OrganizerEmail" name="OrganizerEmail" placeholder="Enter Email" validate ="email" message="Enter Valid Email"  class="span12 " value="#rc.qData.organizer_email#">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="organizer_website">Website*</label>
				<div class="controls">
					<input type="text" id="OrganizerWebsite" name="OrganizerWebsite" required="true" validate="regex" data-regex="^(https?|ftp|file)://.+$" message="Enter Valid URL" placeholder="Enter Website" class="span12" value="#rc.qData.organizer_website#">
				</div>
			</div>
		
			<div class="form-actions">
				<button class="btn btn-primary" type="submit"name="AddEdit"><i class="icon-check"></i>Save changes</button>
			</div>
			
		</fieldset>
	</form>
</cfoutput>
