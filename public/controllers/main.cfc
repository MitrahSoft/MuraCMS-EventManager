/*

This file is part of muraFW1
(c) Stephen J. Withington, Jr. | www.stephenwithington.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

		Document:	/public/controllers/main.cfc
		Author:		Steve Withington | www.stephenwithington.com
		Modified:	2011.02.04

*/
component persistent="false" accessors="true" output="false" extends="controller" {

	/* ********************************* PAGES ******************************************* */
		function datafeed (rc){
			rc.start=#dateformat(dateAdd("s", rc.start, createDateTime(1970, 1, 1, 0, 0, 0)),'yyyy-mm-dd')#;
			rc.end=#dateformat(dateAdd("s", rc.end, createDateTime(1970, 1, 1, 0, 0, 0)),'yyyy-mm-dd')#;
			rc.qList= Application.eventsDAO.read(start="#rc.start#",end="#rc.end#",datafeed=1);
			rc.sample_date = dateAdd("d",7,rc.start );
		}
		
		function list(rc){
           param name="rc.pageNo" default="1";
           param name="rc.searchTerm" default="";
           param name="rc.searchDate" default="";
           param name="rc.categories" default="";
           param name="rc.tags" default="";
           
           local.qEventsPerPage = Application.settingsDAO.read(setting_name="eventsperpage");
          
           if(val(local.qEventsPerPage.setting_value))
          		rc.eventsPerPage = local.qEventsPerPage.setting_value;
           else
           		rc.eventsPerPage = 5;

           rc.qList= Application.eventsDAO.read(searchTerm=rc.searchTerm,searchDate=rc.searchDate,categories=rc.categories,tags=rc.tags,eventsperpage=rc.eventsperpage,pageNo=rc.pageNo);
           rc.qCount= Application.eventsDAO.read(searchTerm=rc.searchTerm,searchDate=rc.searchDate,categories=rc.categories,tags=rc.tags);
           rc.qShowLove = Application.settingsDAO.read(setting_name="ShowSomeLove");
          
       	}
		
		function details(rc){
			rc.qList= Application.eventsDAO.read(rc.event_id);
			rc.qGMap = Application.settingsDAO.read(setting_name="enableGoogleMaps");
			rc.qShowLove = Application.settingsDAO.read(setting_name="ShowSomeLove");
		}
		
		function iCalExport(rc){
			param name="rc.event_id" default="" ;
			rc.myEvents = Application.eventsDAO.iCalGetAll(rc.event_id);
		}
		
		function default(rc){
			rc.qShowLove = Application.settingsDAO.read(setting_name="ShowSomeLove");
		}
}