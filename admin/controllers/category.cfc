/*
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0*/
component persistent="false" accessors="true" output="false" extends="controller" {
	
		function save(rc){
			if(rc.term_slug == ""){
				rc.term_slug = rc.term_name;
			}
			rc.term_slug = lCase(rereplace(rc.term_slug,'[^A-Za-z0-9-]+','-','all'));
			if ( val(term_id) )
				Application.termDAO.update(argumentcollection=rc);
			else
				Application.termDAO.create(argumentcollection=rc);
				
			rc.msg= "success:::category saved successfully.";
			variables.fw.redirect( action="category",preserve="msg");		
		}
		
		function delete(rc){
			Application.termDAO.delete(rc.id);
			
			rc.msg= "error:::category deleted  successfully.";
			variables.fw.redirect(action="category",preserve="msg");
		}
		
		function addEdit (rc){
			param name="rc.term_id" default="";
			rc.qData = Application.termDAO.read(term_id=#rc.term_id#);
		}
		
		function default (rc){
			rc.qList = Application.termDAO.read(term_type='category');
		}
		
}