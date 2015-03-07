<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->
<h1>Locations</h1><hr>
<cfoutput>
<div class="btn-group" id="nav-module-specific">
	<a href="#buildurl('locations.addEdit')#" class="btn"  rel="bootTip" title="Add new Location">
		<i class="icon-plus-sign"></i> Add Location
	</a>
</div>
</cfoutput>	
<table class="table table-striped table-condensed table-bordered mura-table-grid tablesorter">
	<thead>
		<tr>
			<th>Name</th>
			<th>Address</th>
			<th>City</th>
			<th>State</th>
			<th>Country</th>
			<th>Postal code</th>
			<th class="actions nosort">Actions</th>
		</tr>
	</thead>
	<tbody>
		<cfif rc.qlist.recordCount>
			<cfoutput query="rc.qlist">
				<tr>
					<td>#location_name#</td>
					<td>#location_address#</td>
					<td>#location_city#</td>
					<td>#location_state#</td>
					<td>#location_country#</td>
					<td>#location_postal_code#</td>
					<td class="actions">
						<ul>
							<li class="edit"><a rel="bootTip" title="Edit Location" href="#buildurl('locations.addEdit')#&location_id=#location_id#"><i class="icon-pencil"></i></a></li>
							<li class="delete"><a  rel="bootTip" title="Delete Location"  href="javascript:void(0);" onclick="javascript:confirmDelete(#location_id#)" ><i class="icon-remove-sign"></i></a></li>
						</ul>
					</td>
				</tr>
			</cfoutput>
		<cfelse>
			<tr><td colspan="7"> There are no items in this section.</td></tr>
		</cfif>
	</tbody>
</table>
