<cfsilent>
<!---

This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
                

    NOTES:

--->
    <cfscript>
        //request.layout = false;
    </cfscript>
</cfsilent>
<cfoutput>
<div id='loading' style='display:none'>loading...</div>
<div id='calendar'></div>
<cfif rc.qShowLove.setting_value EQ "YES">
	<div style="clear:both;"></div>
	<p class="developer">This event calendar plugin developed by <a href="http://www.mitrahsoft.com">MitrahSoft</a></p>
</cfif>
</cfoutput>