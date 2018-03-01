<cfset users = application.userService.getAllUsers() />
<cf_HeaderFooter title="All users">
<cfif users.recordCount EQ 0>
	<p>There are no users at this time</p>
<cfelse>
	<cfoutput query="users">
		#lastname# #firstname#<br>
	</cfoutput>
</cfif>
</cf_HeaderFooter>