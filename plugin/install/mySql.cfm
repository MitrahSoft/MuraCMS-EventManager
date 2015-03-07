<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_event_term_relationship (
	id INT(11) NOT NULL AUTO_INCREMENT,
	term_id INT(11) DEFAULT NULL,
	event_id INT(11) DEFAULT NULL,
	PRIMARY KEY (id)
	) 
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_locations (
	location_id INT(11) NOT NULL AUTO_INCREMENT,
	location_name VARCHAR(100) DEFAULT NULL,
	location_address VARCHAR(500) DEFAULT NULL,
	location_city VARCHAR(100) DEFAULT NULL,
	location_state VARCHAR(100) DEFAULT NULL,
	location_country VARCHAR(100) DEFAULT NULL,
	location_postal_code VARCHAR(10) DEFAULT NULL,
	location_lat VARCHAR(20) DEFAULT NULL,
	location_lng VARCHAR(20) DEFAULT NULL,
	location_siteId VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY (location_id)
	) 
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_organizers (
	organizer_id INT(11) NOT NULL AUTO_INCREMENT,
	organizer_name VARCHAR(100) DEFAULT NULL,
	organizer_phone VARCHAR(100) DEFAULT NULL,
	organizer_email VARCHAR(100) DEFAULT NULL,
	organizer_website VARCHAR(100) DEFAULT NULL,
	organizer_siteId VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY (organizer_id)
	) 
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#" >
	CREATE TABLE mitrah_em_events (
	 event_id INT(11) NOT NULL AUTO_INCREMENT,
	 location_id INT(11) DEFAULT NULL,
	 organizer_id INT(11) DEFAULT NULL,
	 event_name VARCHAR(100) DEFAULT NULL,
	 event_desc TEXT,
	 event_excerpt TEXT,
	 event_startDate DATE DEFAULT NULL,
	 event_endDate DATE DEFAULT NULL,
	 event_startTime TIME DEFAULT NULL,
	 event_endTime TIME DEFAULT NULL,
	 event_website VARCHAR(100) DEFAULT NULL,
	 event_category INT(11) DEFAULT NULL,
	 event_allDay VARCHAR(10) DEFAULT NULL,
	 event_siteId VARCHAR(20) DEFAULT NULL,
	 recurringType VARCHAR(10) DEFAULT NULL,
	 PRIMARY KEY (event_id),
	 KEY FK_mitrah_em_events (location_id),
	 KEY FK_mitrah_em_events_organizer (organizer_id),
	 CONSTRAINT FK_mitrah_em_events FOREIGN KEY (location_id) REFERENCES mitrah_em_locations (location_id),
	 CONSTRAINT FK_mitrah_em_events_organizer FOREIGN KEY (organizer_id) REFERENCES mitrah_em_organizers (organizer_id)
	) 
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_settings (
	setting_id INT(11) NOT NULL AUTO_INCREMENT,
	setting_name VARCHAR(100) DEFAULT NULL,
	setting_value VARCHAR(100) DEFAULT NULL,
	PRIMARY KEY (setting_id)
	) 
</cfquery>


<cfquery datasource="#variables.configBean.getDatasource()#">
	INSERT  INTO mitrah_em_settings(setting_id,setting_name,setting_value) VALUES (1,'enableGoogleMaps','Yes'),(2,'eventsPerPage','10'),(3,'enableSearchBar','Yes'),(4,'ShowSomeLove','Yes')
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_term (
	term_id INT(11) NOT NULL AUTO_INCREMENT,
	term_type VARCHAR(100) DEFAULT NULL,
	term_name VARCHAR(100) DEFAULT NULL,
	term_bg_color VARCHAR(100) DEFAULT NULL,
	term_slug VARCHAR(100) DEFAULT NULL,
	term_siteId VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY (term_id)
	) 
</cfquery>