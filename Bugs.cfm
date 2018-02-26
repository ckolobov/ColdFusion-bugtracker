<cfset status = ['Новая','Открытая','Решенная','Закрытая']>
<cfset priority = ['Очень срочно','Срочно','Несрочно','Совсем несрочно']>
<cfset severity = ['Авария','Критичная','Не критичная','Запрос на изменение']>

<cfif isDefined('url.BugID')>
	<cf_HeaderFooter title="Bug №#url.BugID#">
	<cfquery name="getBugByID">
		SELECT Bugs.date, Bugs.description_brief, Bugs.description_full, Bugs.status, Bugs.priority, Bugs.severity, Users.firstname, Users.lastname
		FROM Bugs INNER JOIN Users ON Bugs.user = Users.id
		WHERE Bugs.id = #url.BugID#
	</cfquery>
	
<cfelse>
	<cf_HeaderFooter title="All bugs">
<!---	<cfquery name="getAllBugs">
		SELECT Bugs.id, Bugs.date, Bugs.description_brief, Bugs.status, Bugs.priority, Bugs.severity, Users.firstname, Users.lastname
		FROM Bugs INNER JOIN Users ON Bugs.user = Users.id
		ORDER BY date DESC
	</cfquery>--->
	<cfquery name="getAllBugs">
		SELECT Bugs.id, Bugs.date, Bugs.description_brief, Bugs.status AS bugStatus, Bugs.priority AS bugPriority, Bugs.severity AS bugSeverity
		FROM Bugs
		ORDER BY date DESC
	</cfquery>
	<cfif getAllBugs.recordCount EQ 0>
		<p>There are no recorded bugs at this time</p>
	<cfelse>
		<table border="1">
			<tr><td>id</td><td>Дата</td><td>Статус</td><td>Приоритет</td><td>Критичность</td><td>Краткое описание</td><td>Подробная информация</td></tr>
			<cfoutput query="getAllBugs">
				<tr>
					<td>#id#</td>
					<td>#date#</td>
					<td>#status[bugStatus]#</td>
					<td>#priority[bugPriority]#</td>
					<td>#severity[bugSeverity]#</td>
					<td>#description_brief#</td>
					<td><a href="?BugID=#id#">Подробнее</a></td>
				</tr>
			</cfoutput>
		</table>
	</cfif>
	</cf_HeaderFooter>
</cfif>