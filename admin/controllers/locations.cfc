/*
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
*/
component persistent="false" accessors="true" output="false" extends="controller" {
		/*
		function init(fw){
			variables.fw = arguments.fw;
			return this;
		}  
		*/
		function save(rc){
			if ( val(location_id) )
				Application.locationsDAO.update(argumentcollection=rc);
			else
				Application.locationsDAO.create(argumentcollection=rc);
			
			rc.msg= "success:::Location saved successfully.";
			variables.fw.redirect(action='locations',preserve="msg");
		}
		
		function delete(rc){
			rc.qEvents = Application.eventsDAO.read(locationId = rc.id);
			if(rc.qEvents.recordcount)
			variables.fw.redirect("locations&msg=warning:::There is some events scheduled for this location. Delete the events before deleting the Location.");
			
			Application.locationsDAO.delete(rc.id);
			
			rc.msg= "error:::Location deleted successfully.";
			variables.fw.redirect(action='locations',preserve="msg");
			
		}
		
		function addEdit (rc){
		param name="rc.location_id" default="";
			rc.qData = Application.locationsDAO.read(location_id=#rc.location_id#);
			rc.qGMap = Application.settingsDAO.read(setting_name="enableGoogleMaps");
			
		}
		
		function default(rc){
			rc.qList= Application.locationsDAO.read();
		}
		
}
