<!---Form processing script starts here--->
<cfif structKeyExists(form, 'editBugSubmit') AND isDefined('url.edit') AND url.edit EQ true>
	<cfset errorMessages = application.bugService.validateBugEdit(form.bugEditStatus, form.bugEditPriority, form.bugEditSeverity, form.bugEditComment) />
	<cfif ArrayIsEmpty(errorMessages)>
		<cfset application.bugService.updateBug(form.bugEditStatus, form.bugEditPriority, form.bugEditSeverity, #url.BugID#) />
		<cfset application.bugHistoryService.addBugHistory(#url.BugID#, singleBug.bugStatus, LSParseNumber(form.bugEditStatus), form.bugEditComment, session.stLoggedInUser.userID) />
		<cfset bugIsEdited = true />
	</cfif>
</cfif>
<cfif isDefined('bugIsEdited')>
	<p>Изменения внесены!</p>
	<cfoutput >
		<p><a href="?bugID=#url.BugID#">Обновить историю</a></p>
	</cfoutput>
<cfelse>
	<cfset editStatus = application.bugHistoryService.getEditStatus(#singleBug.bugStatus#, status) />
	<cfform action="?bugID=#url.BugID#&edit=true">
		<label for="bugEditStatus">Статус:</label>
		<cfselect name="bugEditStatus" id="bugEditStatus">
			<cfoutput>
				<option value="#singleBug.bugStatus#">#status[singleBug.bugStatus]#</option>
				<cfloop collection="#editStatus#" item="key">
					<option value="#key#">#editStatus[key]#</option>
				</cfloop>
			</cfoutput>
		</cfselect>
		<br>
		<label for="bugEditPriority">Приоритет:</label>
		<cfselect name="bugEditPriority" id="bugEditPriority">
			<option value="0">Не выбран</option>
			<cfoutput>
				<cfloop from="1" to="#arrayLen(priority)#" index="i">
					<option value="#i#">#priority[i]#</option>
				</cfloop>
			</cfoutput>
		</cfselect>
		<br>
		<label for="bugEditSeverity">Критичность:</label>
		<cfselect name="bugEditSeverity" id="bugEditSeverity">
			<option value="0">Не выбрана</option>
			<cfoutput>
				<cfloop from="1" to="#arrayLen(severity)#" index="i">
					<option value="#i#">#severity[i]#</option>
				</cfloop>
			</cfoutput>
		</cfselect>
		<br>
		<label for="bugEditComment">Комментарий: </label>
		<textarea name="bugEditComment" id="bugEditComment"></textarea>
		<br>
		<input type="submit" name="editBugSubmit" id="editBugSubmit" value="Сохранить" />
	</cfform>
</cfif>
<cfset bugHistory = application.bugHistoryService.getHistoryByBugID(#url.BugID#) />
<table border="1">
	<cfoutput query="bugHistory">
	<tr>
		<td>#date#</td>
		<td>#firstname# #lastname#</td>
		<td>#action[bugAction]#</td>
		<td>#comment#</td>
	</tr>
	</cfoutput>
</table>