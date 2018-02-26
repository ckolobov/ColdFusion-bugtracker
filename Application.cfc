<cfcomponent output="false">
	<cfset this.name = 'BugtrackerPrototype' />
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />
	<cfset this.datasource = 'MySQL' />
	<cfset this.customTagPaths = expandPath('customTags') />
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,0,30,0) />
</cfcomponent>