<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->

<cfoutput>
	<cfif val(rc.term_id)>
		<h1>Edit Category</h1>
	<cfelse>
		<h1>Add Category</h1>
	</cfif>
	
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildURL('admin:category')#" class="btn"><i class="icon-circle-arrow-left"></i> Back to Categories</a>
	 </div>
	 <p>(*Required)</p>
	<form  action="#buildurl('category.save')#" method="post" class="fieldset-wrap" novalidate="novalidate" name="frmCat" onsubmit="return validate(this);">
		<input type="hidden" id="term_id" name="term_id"  value="#rc.qData.term_id#">
		<input type="hidden" id="term_type" name="term_type"  value="category">
		<div class="fieldset">
			<div class="control-group">
				<label class="control-label" for="term_name">Name*</label>
				<div class="controls">
					<input type="text" id="term_name" name="term_name"  class="span12" placeholder="Enter Category name" required="true" message="Name is required" value="#rc.qData.term_name#">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="term_bg_color">Background Color*</label>
				<div class="controls">
					<input type="text" id="term_bg_color" name="term_bg_color"  class="span12" required="true" message="Background colour is required" placeholder="Enter Background colour"  value="#rc.qData.term_bg_color#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="term_slug">Slug</label>
				<div class="controls">
					<input type="text" id="term_slug" name="term_slug"  class="span12" placeholder="Enter Category slug"  value="#rc.qData.term_slug#">
					<p>The &##34; slug &##34; is the URL-friendly version of the name. It is usually all lowercase and contains only letters, numbers, and hyphens.</p>
				</div>
			</div>
			<div class="form-actions">
				<button class="btn btn-primary" type="submit"name="AddEdit"> <i class="icon-check"></i>  Save changes</button>
			</div>
		</div>	
	</form>
	<script>
		$(document).ready(function(){
			$('##term_bg_color').colorpicker({
			format: 'hex'
			});
		});
	
	</script>
</cfoutput>
