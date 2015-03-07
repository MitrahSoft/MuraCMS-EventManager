<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->
<h1>Events</h1><hr>
<cfoutput>

<div class="row-fluid">
	<div class="btn-group pull-left" id="nav-module-specific">
		<a href="#buildurl('events.addEdit')#" class="btn"  rel="bootTip" title="Add new Event">
			<i class="icon-plus-sign"></i> Add Event
		</a>
	</div>

	<div class="span3 pull-right">
		<form id="filterByTitle" class="form-inline" method="post" action="#buildurl('events.default')#" novalidate="novalidate">
			<div id="filters" class="module well">
				<h3>Status</h3>
				<select name="status" class="select">
					<option value="">All</option>
					<option value="completed" <cfif isDefined('rc.status') AND rc.status EQ "completed">selected = "selected" </cfif>>Completed</option>
					<option value="upcoming" <cfif isDefined('rc.status') AND rc.status EQ "upcoming">selected = "selected" </cfif>>Upcoming</option>
				</select>
			</div>
			<input class="btn" type="submit" value="Filter" name="filterList">
		</form>
	</div>
</div>
</cfoutput>	

		<table class="table table-striped table-bordered table-condensed tablesorter mura-table-grid">
			<thead>
				<tr>
					<th>Name</th>
					<th>Location</th>
					<th>Organizer</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th>Recurring Type</th>
					<!---<th>Web Site</th>--->
					<th class="nosort">Actions</th>
				</tr>
			</thead>
			<tbody class="nest">
				<cfif rc.qlist.recordCount gt 0>
					<cfoutput query="rc.qlist" group="event_id">
						<tr>
							<td>#event_name#</td>
							<td>#location_name#</td>
							<td>#organizer_name#</td>
							<td>#dateFormat(event_startDate,"mm/dd/yyyy")# #timeFormat(event_startTime,"hh:mm tt")#</td>
							<td>#dateFormat(event_endDate,"mm/dd/yyyy")# #timeFormat(event_endTime,"hh:mm tt")#</td>
							<td>#recurringType#</td>
							<!---<td>#event_website#</td>--->
							<td class="actions">
								<ul>
									<li class="edit"><a rel="boottip" title="Edit Event" href="#buildurl('events.addEdit')#&event_id=#event_id#"><i class="icon-pencil"></i></a></li>
									<li class="delete"><a rel="boottip" title="Delete Event"  href="javascript:void(0);" onclick="javascript:confirmDelete(#event_id#)"><i class="icon-remove-sign"></i></a></li>
								</ul>
							</td>
						</tr>
					</cfoutput>
				<cfelse>
					<tr><td colspan="7"> There are no items in this section.</td></tr>
				</cfif>
			</tbody>
		</table>
