<!---

This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
				

--->
<style>
	.developer{
	font-weight:bolder;
	float:right;
	margin-right:163px;
	}
</style>
<cfoutput>
	<cfsavecontent variable="htmlhead">
		<script type="text/javascript" src="#application.configBean.getContext()#/plugins/#rc.pluginconfig.getdirectory()#/includes/assets/js/jquery.tablesorter.js"></script>
	
		<link rel="stylesheet" href="#application.configBean.getContext()#/plugins/#rc.pluginconfig.getdirectory()#/includes/assets/css/style.css">
		<link rel="stylesheet" href="#application.configBean.getContext()#/plugins/#rc.pluginconfig.getdirectory()#/includes/assets/css/tableSorter.css"><script>
			
			$(document).ready(function(){
				setupTablesorter();	
				$('##deleteButton').css('color','white');
				
			});
			
			function confirmDelete(id){
			   	$('.deleteId').val(id);
				$('##modal').modal('show');
			}
			
			function deleteRecord(){
				var id = $('.deleteId').val();
				window.location = '#buildurl("#getSection()#.delete")#&id='+id;
			}
			
			  function setupTablesorter() {                  
	             $('table.tablesorter').each(function (i, e) {                        
	           		 var myHeaders = {}                        
	             	$(this).find('th.nosort').each(function (i, e) {                            
	            		 myHeaders[$(this).index()] = { sorter: false };                        
	            	 });                                        
	             	$(this).tablesorter({ headers: myHeaders });                   
				 });                    
	         }
		</script>
		<style type="text/css">
			.nav.myNav > li > a{color:##fff!important;}
			.nav.myNav > li.active > a{font-weight:bold;}
		</style>
	</cfsavecontent>
	<cfhtmlhead text="#htmlhead#" />
</cfoutput>

<cfsilent>
	<cfsavecontent variable="local.errors">
		<cfif StructKeyExists(rc, 'errors') and IsArray(rc.errors) and ArrayLen(rc.errors)>
			<div class="alert alert-error">
				<button type="button" class="close" data-dismiss="alert"><i class="icon-remove-sign"></i></button>
				<h2>Alert!</h2>
				<h3>Please note the following message<cfif ArrayLen(rc.errors) gt 1>s</cfif>:</h3>
				<ul>
					<cfloop from="1" to="#ArrayLen(rc.errors)#" index="local.e">
						<li>
							<cfif IsSimpleValue(rc.errors[local.e])>
								<cfoutput>#rc.errors[local.e]#</cfoutput>
							<cfelse>
								<cfdump var="#rc.errors[local.e]#" />
							</cfif>
						</li>
					</cfloop>
				</ul>
			</div><!--- /.alert --->
		</cfif>
	</cfsavecontent>
	<cfscript>
		param name="rc.compactDisplay" default="false";
		body = local.errors & body;
	</cfscript>
</cfsilent>
<cfsavecontent variable="local.newBody">
	<cfset navBarTittle=structnew()>

	<cfset val=StructInsert(navBarTittle, "Settings", "admin:Settings")>
	<cfset val=StructInsert(navBarTittle, "Locations", "admin:Locations")>
	<cfset val=StructInsert(navBarTittle, "Tags", "admin:tag")>
	<cfset val=StructInsert(navBarTittle, "Categories", "admin:category")>
	<cfset val=StructInsert(navBarTittle, "Organizers", "admin:organizers")>
	<cfset val=StructInsert(navBarTittle, "Events", "admin:events")>
	
	<cfoutput>
		<div class="container-eManager">

			<!--- PRIMARY NAV --->
			<div class="row-fluid">
				<div class="navbar navbar-eManager">
					<div class="navbar-inner">
					  <ul class="nav myNav">
					  	<li <cfif rc.action contains 'admin:main'>class="active"</cfif>> <a class="plugin-brand" href="#buildURL('admin:main')#">Home</a></li>
					  	<cfloop collection=#navBarTittle# item="title">
						  	<li <cfif rc.action contains '#navBarTittle[title]#'>class="active"</cfif>> <a class="plugin-brand" href="#buildURL(navBarTittle[title])#">#title#</a></li>
						</cfloop>	
                       </ul><!--- /.nav --->

					</div><!--- /.navbar-inner --->
				</div><!--- /.navbar --->
			</div><!--- /.row --->
			<br class="clear">	
			<script type="text/javascript">
				function userMessage(message, type){
					$('##status').html('<div class="alert alert-'+type+' alert-message"><p></p><b>'+message+'</b><a class="close" data-dismiss="alert">x</a></div>');
					window.setTimeout(function() {
				 		$(".alert-message").alert('close'); },
				 	8000);
				};
			</script>
			<div id="status"></div>
			<cfif isDefined("rc.msg") AND rc.msg neq ''>
				<script>
					userMessage(message="#listlast(rc.msg, ':::')#", type="#listfirst(rc.msg,':::')#");
				</script>
			</cfif>
			
			<!--- MAIN CONTENT AREA --->
			<div class="row-fluid">

					<!--- BODY --->
					<div class="span12">
						#body#
					</div>
			
			</div><!--- /.row --->
		</div><!--- /.container-eManager --->
	</cfoutput>
</cfsavecontent>

<cfoutput>
	#application.pluginManager.renderAdminTemplate(
		body=local.newBody
		,pageTitle=rc.pc.getName()
		,compactDisplay=rc.compactDisplay
	)#
</cfoutput>

<div id="modal" class="modal hide fade ">
	<div class="modal-header">
		<h3><strong>Confirmation</strong>
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button></h3>
	</div>
	<div class="modal-body">
		<p>Are you sure want to delete this data ?</p>
		<input name="deleteId" type="hidden" value="" class="deleteId">
	</div>
	<div class="modal-footer">
		<button class="btn btn-danger" onclick="deleteRecord()" id="deleteButton">Yes</button>
		<button class="btn" data-dismiss="modal" aria-hidden="true">No</button>
	</div>
	
</div>
<div>
	<a href="http://www.mitrahsoft.com" class="developer" target="_blank">Mitrah Soft</a>
</div>
