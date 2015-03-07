<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->

<h1>Organizers</h1><hr>
<cfoutput>
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildurl('organizers.addedit')#" class="btn"  rel="bootTip" title="Add new Organizer">
			<i class="icon-plus icon-white"></i> Add Organizer
		</a>
	</div>
</cfoutput>	
<table class="table table-striped table-condensed table-bordered mura-table-grid tablesorter">
	<thead>
		<tr>
			<th>Name</th>
			<th>phone</th>
			<th>email</th>
			<th>website</th>
			<th class="actions nosort">Actions</th>
		</tr>
	</thead>
	<tbody>
		<cfif rc.qlist.recordcount>
			<cfoutput query="rc.qlist">
				<tr>
					<td>#organizer_name#</td>
					<td>#organizer_phone#</td>
					<td>#organizer_email#</td>
					<td>#organizer_website#</td>
					<td class="actions">
						<ul>
							<li class="edit"><a rel="bootTip" title="Edit Organizer" href="#buildurl('organizers.addEdit')#&ID=#organizer_id#"><i class="icon-pencil"></i></a></li>
							<li class="delete"><a rel="bootTip" title="Delete Organizer"  href="javascript:void(0);" onclick="javascript:confirmDelete(#organizer_ID#)" ><i class="icon-remove-sign"></i></a></li>
						</ul>
					</td>
				</tr>
			</cfoutput>
		<cfelse>
			<tr><td colspan="5"> There are no items in this section.</td></tr>
		</cfif>
	</tbody>
</table>
