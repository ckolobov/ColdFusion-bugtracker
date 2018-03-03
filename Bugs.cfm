<cfinclude template="includes/bugConst.cfm">
<cfif isDefined('url.BugID')>
	<cfset singleBug = application.bugService.getBugByID(#url.BugID#) />
	<cf_HeaderFooter title="Bug №#url.BugID#">
		<cfif singleBug.recordCount EQ 0>
			<cfoutput >
				<p>Нет ошибки с номером №#url.BugID#</p>
			</cfoutput>
		<cfelse>
			<cfoutput >
				<h1 class="page-heading">Ошибка №#url.BugID#</h1>
			</cfoutput>
			<cfoutput query="singleBug">
				<div class="bug-information">
					<div class="bug-information__group">
						<span class="bug-information__property">Создатель:</span>
						<span class="bug-information__value">#firstname# #lastname#</span>
					</div><div class="bug-information__group">
						<span class="bug-information__property">Дата создания:</span>
						<span class="bug-information__value">#DateFormat(date, 'yyyy-mm-dd')#</span>
					</div><div class="bug-information__group">
						<span class="bug-information__property">Статус:</span>
						<span class="bug-information__value">#status[bugStatus]#</span>
					</div><div class="bug-information__group">
						<span class="bug-information__property">Приоритет:</span>
						<span class="bug-information__value">#priority[bugPriority]#</span>
					</div><div class="bug-information__group">
						<span class="bug-information__property">Критичность:</span>
						<span class="bug-information__value">#severity[bugSeverity]#</span>
					</div>
					<div class="bug-information__group bug-information__group_wide">
						<span class="bug-information__property">Краткое описание:</span>
						<span class="bug-information__value">#description_brief#</span>
					</div>
					<div class="bug-information__group bug-information__group_wide">
						<span class="bug-information__property">Подробное описание:</span>
						<span class="bug-information__value">#description_full#</span>
					</div>
					<cfif NOT isDefined('url.edit')>
						<a class="btn bug-information__btn" href="?BugID=#url.BugID#&edit=true">Редактировать</a>
					</cfif>
				</div>
			</cfoutput>
			<cfif isDefined('url.edit') AND url.edit EQ true>
				<cfinclude template="includes/bugHistory.cfm" >
			</cfif>
			<cfset bugHistory = application.bugHistoryService.getHistoryByBugID(#url.BugID#) />
			<h2 class="page-sub-heading">История изменений</h2>
			<cfif bugHistory.recordCount EQ 0>
				<cfoutput >
					<p>Изменений нет</p>
				</cfoutput>
			<cfelse>
				<cfset i = 0 />
				<table class="table">
					<tbody class="table__body">
						<tr class="table__row table__row_small-screen-hidden table__row_medium-screen-hidden">
							<th class="table__cell">№</th>
							<th class="table__cell">Дата изменения</th>
							<th class="table__cell">Пользователь</th>
							<th class="table__cell">Изменение статуса</th>
							<th class="table__cell">Комментарий</th>
						</tr>
						<cfoutput query="bugHistory">
						<cfset i = i + 1 />
						<tr class="table__row">
							<td class="table__cell">
								<strong>
									<span class="label table__lable">Изменение №</span>
									#i#
								</strong>
							</td>
							<td class="table__cell">
								<span class="label table__label">Дата создания:</span>
								#DateFormat(date, 'yyyy-mm-dd')#
							</td>
							<td class="table__cell">
								<span class="label table__label">Пользователь:</span>
								#firstname# #lastname#
							</td>
							<td class="table__cell">
								<span class="label table__label">Изменение статуса:</span>
								#action[bugAction]#
							</td>
							<td class="table__cell">
								<span class="label table__label">Комментарий:</span>
								#comment#
							</td>
						</tr>
						</cfoutput>
					</tbody>
				</table>
			</cfif>
		</cfif>
	</cf_HeaderFooter>
<cfelse>
	<cfparam name="url.column" default="2" >
	<cfparam name="url.sort" default="DESC">
	<cfset bugs = application.bugService.getAllBugs(#url.column#, #url.sort#) />
	<cf_HeaderFooter title="All bugs">
		<h1 class="page-heading">Все зарегистрированные ошибки</h1>
		<cfif bugs.recordCount EQ 0>
			<p>На данный момент нет ни одной записи</p>
		<cfelse>
			<table class="table">
				<tbody class="table__body">
					<tr class="table__row">
						<th class="table__cell">
							<span class="large-screen-hidden-text">Сортировка:</span>
							<span class="small-screen-hidden-text medium-screen-hidden-text">id</span>
						</th>
						<th class="table__cell">
							Создатель<br class="small-screen-hidden-text medium-screen-hidden-text">
							<a class="sort-arrow" href="?column=1&sort=ASC" title="Сортировать по возрастанию">&uarr;</a>
							<a class="sort-arrow" href="?column=1&sort=DESC" title="Сортировать по убыванию">&darr;</a>
						</th>
						<th class="table__cell">
							Дата создания<br class="small-screen-hidden-text medium-screen-hidden-text">
							<a class="sort-arrow" href="?column=2&sort=ASC" title="Сортировать по возрастанию">&uarr;</a>
							<a class="sort-arrow" href="?column=2&sort=DESC" title="Сортировать по убыванию">&darr;</a>
						</th>
						<th class="table__cell">
							Статус<br class="small-screen-hidden-text medium-screen-hidden-text">
							<a class="sort-arrow" href="?column=3&sort=ASC" title="Сортировать по возрастанию">&uarr;</a>
							<a class="sort-arrow" href="?column=3&sort=DESC" title="Сортировать по убыванию">&darr;</a>
						</th>
						<th class="table__cell">
							Приоритет<br class="small-screen-hidden-text medium-screen-hidden-text">
							<a class="sort-arrow" href="?column=4&sort=ASC" title="Сортировать по возрастанию">&uarr;</a>
							<a class="sort-arrow" href="?column=4&sort=DESC" title="Сортировать по убыванию">&darr;</a>
						</th>
						<th class="table__cell">
							Критичность<br class="small-screen-hidden-text medium-screen-hidden-text">
							<a class="sort-arrow" href="?column=5&sort=ASC" title="Сортировать по возрастанию">&uarr;</a>
							<a class="sort-arrow" href="?column=5&sort=DESC" title="Сортировать по убыванию">&darr;</a>
						</th>
						<th class="table__cell table__cell_small-screen-hidden table__cell_medium-screen-hidden">Краткое описание</th>
						<th class="table__cell table__cell_small-screen-hidden table__cell_medium-screen-hidden">Подробная информация</th>
					</tr>
					<cfoutput query="bugs">
						<tr class="table__row">
							<td class="table__cell">
								<strong>
									<span class="large-screen-hidden-text">Ошибка №</span>
									#id#
								</strong>
							</td>
							<td class="table__cell">
								<span class="label table__label">Автор:</span>
								#firstname# #lastname#
							</td>
							<td class="table__cell">
								<span class="label table__label">Дата создания:</span>
								#DateFormat(date, 'yyyy-mm-dd')#
							</td>
							<td class="table__cell">
								<span class="label table__label">Статус:</span>
								#status[bugStatus]#
							</td>
							<td class="table__cell">
								<span class="label table__label">Приоритет:</span>
								#priority[bugPriority]#
							</td>
							<td class="table__cell">
								<span class="label table__label">Критичность:</span>
								#severity[bugSeverity]#
							</td>
							<td class="table__cell">
								<span class="label table__label">Краткое описание:</span>
								#description_brief#
							</td>
							<td class="table__cell">
								<a class="btn table__btn" href="?BugID=#id#">Подробнее</a>
							</td>
						</tr>
					</cfoutput>
				</tbody>
			</table>
		</cfif>
	</cf_HeaderFooter>
</cfif>