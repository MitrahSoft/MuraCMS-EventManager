<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0 
---->


<h1>Tags</h1>
<cfoutput>
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildurl('tag.addEdit')#" class="btn"  rel="bootTip" title="Add new Tag">
			<i class="icon-plus-sign"></i> Add Tag
		</a>
	</div>
</cfoutput>	
<table class="table table-striped table-bordered table-condensed tablesorter sortable mura-table-grid">
	<thead>
		<tr>
			<th>Name</th>
			<th>Slug</th>
			<th class="action nosort">Actions</th>
		</tr>
	</thead>
	<tbody class="nest">
		<cfif rc.qlist.recordCount gt 0>
			<cfoutput query="rc.qlist">
				<tr>
					<td>#term_name#</td>
					<td>#term_slug#</td>
					<td class="actions">
						<ul>
							<li class="edit"><a  rel="bootTip" title="Edit Tag" href="#buildurl('tag.addEdit')#&term_id=#term_id#"> <i class="icon-pencil"></i></a></li> 
							<li class="delete"><a  rel="bootTip" title="Delete Tag"  href="javascript:void(0);" onclick="javascript:confirmDelete(#term_id#)" ><i class="icon-remove-sign"></i></a></li>
						</ul>
					</td>
				</tr>
			</cfoutput>
		<cfelse>
			<tr><td colspan="3"> There are no items in this section.</td></tr>
		</cfif>		
	</tbody>
</table>


