<cfinclude template="includes/bugConst.cfm">
<cfif isDefined('url.BugID')>
	<cfset singleBug = application.bugService.getBugByID(#url.BugID#) />
	<cf_HeaderFooter title="Bug №#url.BugID#">
	<cfif singleBug.recordCount EQ 0>
		<cfoutput >
			<p>Нет ошибки с номером №#url.BugID#</p>
		</cfoutput>
	<cfelse>
		<table border="1">
			<tr>
				<td>id</td>
				<td>Создатель</td>
				<td>Дата создания</td>
				<td>Статус</td>
				<td>Приоритет</td>
				<td>Критичность</td>
				<td>Краткое описание</td>
				<td>Подробное описание</td></tr>
			<cfoutput query="singleBug">
				<tr>
					<td>#url.BugID#</td>
					<td>#firstname# #lastname#</td>
					<td>#DateFormat(date, 'yyyy-mm-dd')#</td>
					<td>#status[bugStatus]#</td>
					<td>#priority[bugPriority]#</td>
					<td>#severity[bugSeverity]#</td>
					<td>#description_brief#</td>
					<td>#description_full#</td>
				</tr>
			</cfoutput>
		</table>
		<cfinclude template="includes/bugHistory.cfm" >
	</cfif>
<cfelse>
	<cfparam name="url.column" default="2" >
	<cfparam name="url.sort" default="DESC">
	<cfset bugs = application.bugService.getAllBugs(#url.column#, #url.sort#) />
	<cf_HeaderFooter title="All bugs">
	<cfif bugs.recordCount EQ 0>
		<p>На данный момент нет ни одной записи</p>
	<cfelse>
		<table border="1">
			<tr>
				<td>id</td>
				<td>Создатель <a href="?column=1&sort=ASC">&uarr;</a> <a href="?column=1&sort=DESC">&darr;</a></td>
				<td>Дата создания <a href="?column=2&sort=ASC">&uarr;</a> <a href="?column=2&sort=DESC">&darr;</a></td>
				<td>Статус <a href="?column=3&sort=ASC">&uarr;</a> <a href="?column=3&sort=DESC">&darr;</a></td>
				<td>Приоритет <a href="?column=4&sort=ASC">&uarr;</a> <a href="?column=4&sort=DESC">&darr;</a></td>
				<td>Критичность <a href="?column=5&sort=ASC">&uarr;</a> <a href="?column=5&sort=DESC">&darr;</a></td>
				<td>Краткое описание</td>
				<td>Подробная информация</td></tr>
			<cfoutput query="bugs">
				<tr>
					<td>#id#</td>
					<td>#firstname# #lastname#</td>
					<td>#DateFormat(date, 'yyyy-mm-dd')#</td>
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