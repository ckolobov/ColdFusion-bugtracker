<cf_HeaderFooter title="All users">
<cfquery name="getAllUsers">
	SELECT firstname, lastname
	FROM Users
	ORDER BY lastname
</cfquery>
<cfif getAllUsers.recordCount EQ 0>
	<p>There are no users at this time</p>
<cfelse>
	<cfoutput query="getAllUsers">
		#lastname# #firstname#<br>
	</cfoutput>
</cfif>
</cf_HeaderFooter>