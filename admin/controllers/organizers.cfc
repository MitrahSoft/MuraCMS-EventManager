/*
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
*/

component persistent="false" accessors="true" output="false" extends="controller" {
		
		function save(rc){
			
			if ( val(ID) )
				Application.organizersDAO.update(argumentcollection=rc);
			else
				Application.organizersDAO.create(argumentcollection=rc);
			
			rc.msg= "success:::Organizer saved successfully.";
			variables.fw.redirect(action='organizers',preserve="msg");
			
		}
		
		function delete(rc){
			rc.qEvents = Application.eventsDAO.read(organizerID = rc.id);
			if(rc.qEvents.recordcount)
			variables.fw.redirect("organizers&msg=warning:::There is some events scheduled for this Organizer. Delete the events before deleting the Organizer.");
			
			Application.organizersDAO.delete(rc.id);
			
			rc.msg= "error:::Organizer deleted successfully.";
			variables.fw.redirect(action='organizers',preserve="msg");
			
		}
		
		function addEdit (rc){
			param name="rc.ID" default="";
			
			rc.qData = Application.organizersDAO.read(id=#rc.ID#);
		}
		
		function default (rc){
			rc.qList= Application.organizersDAO.read();
		}
}
