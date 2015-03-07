<cfsilent>
<!---

This file is part of MuraFW1

Copyright 2010-2013 Stephen J. Withington, Jr.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
<cfif rc.action neq 'public:main.datafeed'>
<cfsavecontent variable="htmlhead"><cfoutput>
<link href="#application.configBean.getContext()#/admin/assets/css/admin.min.css" rel="stylesheet" type="text/css" />
<link href="#application.configBean.getContext()#/plugins/#local.rc.pc.getDirectory()#/includes/assets/css/fullcalendar.css" rel="stylesheet" type="text/css" />
<link href="#application.configBean.getContext()#/plugins/#local.rc.pc.getDirectory()#/includes/assets/css/fullcalendar.print.css" rel="stylesheet" type="text/css"  media='print' />
<link href="#application.configBean.getContext()#/plugins/#local.rc.pc.getDirectory()#/includes/assets/css/style.css" rel="stylesheet" type="text/css" />



<!---<script src="#application.configBean.getContext()#/plugins/#local.rc.pc.getDirectory()#/includes/assets/js/jquery.qtip.min.js" type="text/javascript"></script>--->  
<script src="#application.configBean.getContext()#/plugins/#local.rc.pc.getDirectory()#/includes/assets/js/fullcalendar.min.js" type="text/javascript"></script>
<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery-ui.js" type="text/javascript"></script> 
<script src="#application.configBean.getContext()#/admin/assets/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
		$('##export_button').click(function(){
			
			var event_val = [];
	        $(':checkbox:checked').each(function(i){
	          event_val[i] = $(this).val();
	        });
			
			if (event_val.length > 0) 
				window.location.href = "#buildURL( 'public:main.iCalExport')#&event_id=" + event_val
			else
				window.location.href="#buildURL( 'public:main.iCalExport')#"	
		});
		
		$(".datepicker").datepicker();     
       $('##calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
			weekMode:"liquid",
            editable: false,
            
            events: "/plugins/#local.rc.pc.getDirectory()#/#buildurl('public:main.datafeed')#",
			eventRender: function (event, element) { 
		        $(element).on('click', function () {
                    $(this).siblings('.fc-event').popover('hide');
                });
               
                $popover = element.popover({
                    html: true,
                    title: 'Event details<button type="button" class="close" onclick="$(&quot;.fc-event&quot;).popover(&quot;hide&quot;);">&times;</button> ',
                    placement: 'top',
                    content: event.description,
                    container:'body'
                });

		    },
			viewDestroy: function(view,element) {
			     $('div.fc-event').popover('hide');
			},
			
            loading: function(bool) {
                if (bool) $('##loading').show();
                else $('##loading').hide();
            }
            
        });
		
		
		var custom_buttons = '<span class="fc-button-next ui-corner-left ui-corner-right" style="margin-left:5px;"><input type="hidden" id="date_picker" value=""></span>';
        $('td.fc-header-center span.fc-header-title').parent('td').append(custom_buttons);
      
	  $("##date_picker").datepicker({
   			 changeMonth: true,
			 changeYear: true,
           	 dateFormat: 'dd-mm-yy',
             clickInput: true,
             showOn: 'button',
             buttonImage: '/plugins/#local.rc.pc.getDirectory()#/includes/assets/css/images/calendar.gif',
             buttonImageOnly: true,
			 numberOfMonths: 1,
			 showButtonPanel: true , 
             inline: true,
			 
            onSelect: function(dateText, inst) {
                    var d = $("##date_picker").datepicker("getDate");
           			 $('##calendar').fullCalendar('gotoDate', d);
					
            }
        });
		$('.ui-datepicker-trigger').removeAttr("title");
       
    });
</script> 
<style>
.ui-datepicker-close {display: none;}
.ui-datepicker .ui-datepicker-buttonpane button.ui-datepicker-current{margin-left:75px;}
.ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year {color: ##000000; height: auto;}
.fc-view {position:static !important;}
</style>
</cfoutput>
</cfsavecontent>
<cfhtmlhead text="#htmlhead#" />
    
</cfif>
</cfsilent>
<cfset rc.qShowsearch = Application.settingsDAO.read(setting_name="enableSearchBar")>
<cfoutput>
	<cfif rc.action eq 'public:main.details' >
			<div class="pull-right">
				<a href="#buildURL( 'public:main' )#"><i class='icon-backward'></i> &nbsp;All Events </a>
			</div>
	<cfelse>
		<div class="calander_Searchbox">
			<div class="cal_menu">
				<cfif rc.qShowsearch.setting_value EQ "YES">
					<form name="searchForm" class="myForm searchForm" action="#buildURL('public:main.list')#" method="post" >
						<div class="Event_top">
							<div class="event_Frm">EVENTS FROM</div>
							<div class="Search_box"><input type="text" class="datepicker" name="searchDate" placeholder="#dateFormat(now(),'yyyy-mm-dd')#"></div>
						</div>
						
						<div class="Search_top">
							<div class="search_Frm">SEARCH</div>
							<div class="Search_box"><input type="text" name="searchTerm" placeholder="Search"></div>
						</div>
						
						<div class="find_events">
							<input type="submit" value="FindEvents" name="searchbtn" class="find_button">
						</div>
					</form>
				</cfif>	
				<div class="view_list">
					<div class="view_box">
						<div class="view_as">VIEW AS</div>
						 &nbsp;&nbsp;<a href="#buildURL( 'public:main' )#" ><i class="icon-calendar"></i>&nbsp;calendar</a> <br />
						 &nbsp;&nbsp;<a  href="#buildURL( 'public:main.list' )#"><i class="icon-list"></i>&nbsp;List</a><br />
					</div>
	 			</div>
				<div class="export">
					<a class="btn export_button" id="export_button" ><i class="icon-download-alt"></i>&nbsp;Export Events</a>
				</div>
			</div>	
		</div>	
	</cfif>
	
	<div style="clear:both;">&nbsp;</div>
    #body#
</cfoutput>
