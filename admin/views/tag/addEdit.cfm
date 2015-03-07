<!---
This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
---->
<cfoutput>
	<cfif val(rc.term_id)>
		<h1>Edit Tag</h1>
	<cfelse>
		<h1>Add Tag</h1>
	</cfif>
	<div class="btn-group" id="nav-module-specific">
		<a href="#buildURL('admin:tag')#" class="btn"><i class="icon-circle-arrow-left"></i> Back to Tags</a>
	 </div>
	 <p>(*Required)</p>
	<form class="fieldset-wrap" novalidate="novalidate" action="#buildurl('tag.save')#"  method="post" name="frmTerm" onsubmit="return validate(this);"> 
		<input type="hidden" id="term_id" name="term_id"  value="#rc.qData.term_id#">
		<input type="hidden" id="term_type" name="term_type"  value="tag">
	
		<div class="fieldset">	
			<div class="control-group">
				<label class="control-label" for="term_name">Name*</label>
				<div class="controls">
					<input type="text" id="term_name" class="span12" name="term_name" placeholder="Enter Tag name" required="true" message="Name is required"  value="#rc.qData.term_name#">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="term_slug">Slug</label>
				<div class="controls">
					<input type="text" id="term_slug"class="span12"  name="term_slug" placeholder="Enter Tag Slug"  value="#rc.qData.term_slug#">
					<p>The &##34; slug &##34; is the URL-friendly version of the name. It is usually all lowercase and contains only letters, numbers, and hyphens.</p>
				</div>
			</div>
			
			<div class="form-actions">
				<button class="btn btn-primary" type="submit"name="AddEdit"><i class="icon-check"></i> Save changes</button>
			</div>
		</div>	
	</form>
		
</cfoutput>
