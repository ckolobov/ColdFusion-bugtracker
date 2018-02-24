<cfif isDefined('url.BugID')>
	<cfquery datasourse="MySQL" name="getBugByID">
		
	</cfquery>
<cfelse>
	<cfquery datasourse="MySQL" name="getAllBugs">
		SELECT Bugs.date, Bugs.description_brief, Bugs.status, Bugs.priority, Bugs.severity, Bugs.firstname, Bugs.lastname
		FROM Bugs INNER JOIN Users ON Bugs.user = Users.id
		ORDER BY date DESC
	</cfquery>
	<cfif getAllBugs.recordCount EQ 0>
		<p>There are no recorded bugs at this time</p>
	<cfelse>
		<table>
			<cfoutput query="getAllBugs">
				<tr>
					<td>#date#</td>
					<td>#user#</td>
					<td>#status#</td>
					<td>#priority#</td>
					<td>#severity#</td>
					<td>#description_brief#</td>
				</tr>
			</cfoutput>
		</table>
	</cfif>
</cfif>
