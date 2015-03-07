/*This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0*/
component persistent="false" accessors="true" output="false" extends="controller" {
		/*function init(fw){
			variables.fw = arguments.fw;
			return this;
		}*/
		
		function save(rc){
			param name="rc.event_allDay" default="false";
			param name="rc.recurringEvent" default="none";
			if(!val(rc.recurringEvent)){
				rc.recurringType="none";
			}
			if(isDefined('rc.addNewOrganizer') and rc.addNewOrganizer EQ 1){
				rc.organizerid = Application.organizersDAO.create(argumentcollection=rc);
			}
			if(isDefined('rc.addNewLocation') and rc.addNewLocation EQ 1){
				rc.locationID = Application.locationsDAO.create(argumentcollection=rc);
			}
			if(rc.startDayPart eq 2){
				addHour=12 + startHour;
				StartedTime=CreateTime(addHour,rc.startMinute,0);
			}
			else{
				StartedTime=CreateTime(rc.startHour,rc.startMinute,0);
			}
			
			rc.StartTime=timeFormat(StartedTime,"HH:mm:ss");
			
			if(rc.EndDayPart eq 2){
				addHour=12+Endhour;
				LastTime=CreateTime(addHour,rc.EndMinute,0);
			}
			else{
				LastTime=CreateTime(rc.Endhour,rc.EndMinute,0);	
			}
			
			rc.EndTime=timeFormat(LastTime,"HH:mm:ss");
			 if (val(event_id)){
	              if(listlen(rc.term_id) neq 0){
	                  Application.eventsDAO.deleteEventTerm(event_id="#rc.event_id#");
	                   for(i=1;i<=ListLen(rc.term_id);i++){
	                       termID = ListGetAt(rc.term_id,i);
	                       Application.eventsDAO.createEventTerm(event_id="#rc.event_id#",term_id="#termID#");
	                       }
	                     }
	                  Application.eventsDAO.update(argumentcollection=rc);
	               }
                   else{
                      rc.event_id = Application.eventsDAO.create(argumentcollection=rc);
                      if(listlen(rc.term_id) neq 0){
                          for(i=1;i<=ListLen(rc.term_id);i++){
                              termID = ListGetAt(rc.term_id,i);
                              Application.eventsDAO.createEventTerm(event_id="#rc.event_id#",term_id="#termID#");
                           }
                   		}
                      }
				rc.msg= "success:::Event saved successfully.";
				variables.fw.redirect(action="events",preserve="msg");
			
			//variables.fw.redirect("events",rc.msg);
		}
		
		function delete(rc){
			Application.eventsDAO.delete(rc.id);
			rc.msg= "error:::Event deleted successfully";
			variables.fw.redirect(action="events",preserve="msg");
		}
		
		function addEdit (rc){
			
			param name="rc.event_id" default="";
			param name="rc.sTime" default="";
			param name="rc.sMins" default="";
			param name="rc.eTime" default="";
			param name="rc.eMins" default="";
			param name="rc.sdayPart" default="";
			param name="rc.edayPart" default="";
			
		
			rc.qData = Application.eventsDAO.read(event_id=#rc.event_id#);
			rc.qGMap = Application.settingsDAO.read(setting_name="enableGoogleMaps");
			rc.qTags= Application.termDAO.read(term_type='tag');
			rc.qCategory= Application.termDAO.read(term_type='category');
			if(rc.qData.recordcount){
				rc.getTime=datePart("h",#rc.qData.event_startTime#);
				if(rc.getTime > 12){
					rc.sTime=rc.getTime-12;
					rc.sdayPart=2;
				}
				else{
					rc.sTime=datePart("h",#rc.qData.event_startTime#);
				}
				
				rc.sMins=datePart("n",#rc.qData.event_startTime#);
				
				rc.getEndTime=datePart("h",#rc.qData.event_endTime#);
				if(rc.getEndTime > 12){
					rc.eTime=rc.getEndTime-12;
					rc.edayPart=2;
				}else{
					rc.eTime=datePart("h",#rc.qData.event_endTime#);
				}
				rc.eMins=datePart("n",#rc.qData.event_endTime#);
				
				rc.tagIdList=valueList(rc.qData.tagId);
			}
			else
			 rc.tagIdList="";
			
			rc.qOrganizers = Application.organizersDAO.read();
			rc.qLocation = Application.locationsDAO.read();
			
		}
		
		function default(rc){
			if(isDefined('rc.FILTERLIST')){
				rc.qList= Application.eventsDAO.read(status=#rc.status#);
			}
			else{
				rc.qList= Application.eventsDAO.read();
			}
		}
}
