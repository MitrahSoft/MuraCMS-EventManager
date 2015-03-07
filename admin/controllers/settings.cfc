/*
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
*/

component persistent="false" accessors="true" output="false" extends="controller" {

		function save(rc){
			param name="rc.enableGoogleMaps" default="No";
			param name="rc.enableSearchBar" default="No";
			param name="rc.ShowSomeLove" default="No";
			
			if(NOT listcontainsnocase(rc.FieldNames,'enableGoogleMaps')){
				rc.FieldNames = listappend(rc.FieldNames,'enableGoogleMaps');
			}
			if(NOT listcontainsnocase(rc.FieldNames,'enableSearchBar')){
				rc.FieldNames = listappend(rc.FieldNames,'enableSearchBar');
			}
			if(NOT listcontainsnocase(rc.FieldNames,'ShowSomeLove')){
				rc.FieldNames = listappend(rc.FieldNames,'ShowSomeLove');
				
			}
			
			if ( val(setting_id) ){
				for(i=1;i<=ListLen(rc.FieldNames);i++){
					Name = ListGetAt(rc.FieldNames,i);
					if(Name NEQ 'SETTING_ID' AND Name NEQ 'ADDEDIT'){
						settingValue = "rc"&".#Name#";
						Application.settingsDAO.update(setting_name = Name,setting_value = evaluate(settingValue));
					}
				 }
			}
			else{
				for(i=1;i<=ListLen(rc.FieldNames);i++){
					Name = ListGetAt(rc.FieldNames,i);
					if(Name NEQ 'SETTING_ID' AND Name NEQ 'ADDEDIT'){
						settingValue = "rc"&".#Name#";
						Application.settingsDAO.create(setting_name = lcase(Name),setting_value=evaluate(settingValue));
					}
				 }
			}			
			
			rc.msg= "success:::Settings saved successfully.";
			
			variables.fw.redirect(action='settings',preserve="msg");		
		}
		
		function default (rc){
			rc.qData= Application.settingsDAO.read();
		}
		
}
