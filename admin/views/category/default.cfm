<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->
<h1>Categories</h1>
<cfoutput>
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildurl('category.addEdit')#" class="btn"  rel="bootTip" title="Add new Category">
			<i class="icon-plus-sign icon-white"></i> Add Category
		</a>
	</div>
</cfoutput>	
<table class="table table-striped table-bordered table-condensed tablesorter mura-table-grid">
	<thead>
		<tr>
			<th>Name</th>
			<th>Background color</th>
			<th>Slug</th>
			<th class="action nosort">Actions</th>
		</tr>
	</thead>
	<tbody >
		<cfif rc.qlist.recordCount gt 0>
			<cfoutput query="rc.qlist">
				<tr>
					<td>#term_name#</td>
					<td>#term_bg_color#</td>
					<td>#term_slug#</td>
		
					<td class="actions">
						<ul>
							<li class="edit"><a  rel="bootTip" title="Edit category" href="#buildurl('category.addEdit')#&term_id=#term_id#"> <i class="icon-pencil"></i></li></a>
							<li class="delete"><a  rel="bootTip" title="Delete category"  href="javascript:void(0);" onclick="javascript:confirmDelete(#term_id#)" ><i class="icon-remove-sign"></i></a></li>							
						</ul>
					</td>
				</tr>
			</cfoutput>
		<cfelse>
			<tr><td colspan="4">  There are no items in this section.</td></tr>
		</cfif>	
	</tbody>
</table>
