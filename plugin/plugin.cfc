/*


This file is part of eManager

Copyright 2010-2013 @CFMitrah from @MitrahSoft.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0
				

*/

component persistent="false" accessors="true" output="false" extends="mura.plugin.plugincfc" {

	variables.pluginConfig = "";

	public any function init(any pluginConfig, any configBean="") {

		variables.pluginConfig = arguments.pluginConfig;
        if (isObject(arguments.configBean)){
        	variables.configBean = arguments.configBean;
        }             
                
        return this;
	}
	
	public void function install() {
		// triggered by the pluginManager when the plugin is INSTALLED.
		if(variables.configBean.getdbtype() eq "mssql")
			include "install/mssql.cfm" ;
			
		if(variables.configBean.getdbtype() eq "mysql")
			include "install/mysql.cfm" ;
			
		application.appInitialized = false;
	}

	public void function update() {
		// triggered by the pluginManager when the plugin is UPDATED.
		application.appInitialized = false;
	}
	
	public void function delete() {
		// triggered by the pluginManager when the plugin is DELETED.
			include "uninstall.cfm" ;
			
		application.appInitialized = false;
	}

}


  

