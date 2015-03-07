<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_event_term_relationship (	
	id INT identity(1,1) NOT NULL,	
	term_id INT DEFAULT NULL,	
	event_id INT DEFAULT NULL,	
	PRIMARY KEY (id)	
	) 
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_locations (
	location_id INT identity(1,1) NOT NULL,
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
	organizer_id INT identity(1,1) NOT NULL,
	organizer_name VARCHAR(100) DEFAULT NULL,
	organizer_phone VARCHAR(100) DEFAULT NULL,
	organizer_email VARCHAR(100) DEFAULT NULL,
	organizer_website VARCHAR(100) DEFAULT NULL,
	organizer_siteId VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY (organizer_id)
	) 
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_settings (
	setting_id INT identity(1,1) NOT NULL,
	setting_name VARCHAR(100) DEFAULT NULL,
	setting_value VARCHAR(100) DEFAULT NULL,
	PRIMARY KEY (setting_id)
	) 
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	CREATE TABLE mitrah_em_term (
	term_id INT identity(1,1) NOT NULL,
	term_type VARCHAR(100) DEFAULT NULL,
	term_name VARCHAR(100) DEFAULT NULL,
	term_bg_color VARCHAR(100) DEFAULT NULL,
	term_slug VARCHAR(100) DEFAULT NULL,
	term_siteId VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY (term_id)
	)
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#">
	INSERT  INTO mitrah_em_settings(setting_name,setting_value) VALUES ('enableGoogleMaps','Yes'),('eventsPerPage','10'),('enableSearchBar','Yes'),('ShowSomeLove','Yes')
</cfquery>

<cfquery datasource="#variables.configBean.getDatasource()#"  >
	CREATE TABLE [dbo].[mitrah_em_events](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[location_id] [int] NULL,
	[organizer_id] [int] NULL,
	[event_name] [varchar](100) NULL,
	[event_desc] [text] NULL,
	[event_excerpt] [text] NULL,
	[event_startDate] [date] NULL,
	[event_endDate] [date] NULL,
	[event_startTime] [time](7) NULL,
	[event_endTime] [time](7) NULL,
	[event_website] [varchar](100) NULL,
	[event_category] [int] NULL,
	[event_allDay] [varchar](10) NULL,
	[event_siteId] [varchar](20) NULL,
	[recurringType] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

SET ANSI_PADDING OFF;

	ALTER TABLE [dbo].[mitrah_em_events]  WITH CHECK ADD  CONSTRAINT [FK_mitrah_em_events_mitrah_em_events] FOREIGN KEY([event_id])
	REFERENCES [dbo].[mitrah_em_events] ([event_id]);
	
	ALTER TABLE [dbo].[mitrah_em_events] CHECK CONSTRAINT [FK_mitrah_em_events_mitrah_em_events];
	
	ALTER TABLE [dbo].[mitrah_em_events]  WITH CHECK ADD  CONSTRAINT [FK_mitrah_em_events_mitrah_em_organizers] FOREIGN KEY([organizer_id])
	REFERENCES [dbo].[mitrah_em_organizers] ([organizer_id]);
	
	ALTER TABLE [dbo].[mitrah_em_events] CHECK CONSTRAINT [FK_mitrah_em_events_mitrah_em_organizers];

</cfquery>