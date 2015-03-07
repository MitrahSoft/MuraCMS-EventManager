<cfsilent>
<!---

This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
				

--->
</cfsilent>

<cfoutput>
	
	<div class="head">
		<div class="events">
			<div id="logImg">
				<img src="#application.configBean.getContext()#/plugins/#rc.pluginconfig.getdirectory()#/includes/assets/css/images/MitrahSoft-logo.png" alt="info" />
			</div>
			<div id="tagline">
				The Events Manager is a carefully crafted, extensible plugin that lets you easily share your events.
			</div>
			<div id="eManager">Events Manager</div>
		</div>
		<div id="cal">
			<img src="#application.configBean.getContext()#/plugins/#rc.pluginconfig.getdirectory()#/includes/assets/css/images/calendar-1.png" alt="info" class="imgsize"/>
		</div>
	</div>
	<!---<div style="width:100%; height:290px; padding:25px; background:lightblue;">
	&nbsp;
	</div>--->
	<div id="description">
		<legend>Events Manager</legend>
		<p>Create and manage events with ease.Get professional-level quality and features backed by a team you can trust.</p>


		<legend>Developed By</legend>
		<div class="clearfix">
			<div class="logo">
				<a href="http://www.MitrahSoft.com" target="_blank"><img src="#application.configBean.getContext()#/plugins/#rc.pluginconfig.getdirectory()#/includes/assets/css/images/MitrahSoft-logo.png" alt="info"  width="250" height="24"/></a>
			</div>
			<div id="developerDescription">
				<strong>MitrahSoft</strong> 
				is a team of talented Adobe & Brainbench Certified ColdFusion developers.We provide customized, efficient and affordable IT solutions for your business needs in ColdFusion.The services we provide are competitively priced, and come with the following benefits:   
				<ul>
					<li>World-class and up-to-date CF programming knowledge and experience;</li> 
					<li>Ability to effectively communicate and understand the clients needs in order to produce an effective and concise solution;</li> 
					<li>Consideration of user-friendly interfaces and data entry methods, for those less experienced types of applications.</li>
				</ul>
				<a href="mailto:contactus@mitrahsoft.com">Contact us</a>, we are here to help!
			</div>
		</div>

		<legend>Features</legend>
		<ul>
		   	 <li>Rapidly create events</li>
		     <li>Saved venues & organizers</li>
		     <li>Calendar month view with tooltips</li>
		     <li>List view</li>
		     <li>Event search</li>
		     <li>Google maps</li>
		     <li>Events Taxonomies (Categories & Tags)</li>
		     <li>Completely ajaxified for super smooth browsing</li>
		</ul>
	</div>
	
	
</cfoutput>
