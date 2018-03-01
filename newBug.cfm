<!---Add bug properties label arrays--->
<cfinclude template="includes/bugConst.cfm">
<!---Form processing script starts here--->
<cfif structKeyExists(form, 'newBugSubmit')>
	<cfset errorMessages = application.bugService.validateBug(form.descriptionBrief, form.bugPriority, form.bugSeverity) />
	<cfif ArrayIsEmpty(errorMessages)>
		<cfset application.bugService.addBug(form.descriptionBrief, form.descriptionFull, session.stLoggedInUser.userID, form.bugPriority, form.bugSeverity) />
		<cfset bugIsInserted = true />
	</cfif>
</cfif>
<cf_HeaderFooter title="New bug">
<cfif isDefined('errorMessages') AND NOT ArrayIsEmpty(errorMessages)>
	<cfoutput >
		<cfloop array="#errorMessages#" index="message">
			<p class="errorMessage">#message#</p>
		</cfloop>
	</cfoutput>
</cfif>
<cfif isDefined('bugIsInserted')>
	<p>Новая ошибка добавлена!</p>
<cfelse>
	<cfform>
		<label for="descriptionBrief">Краткое описание:</label>
		<cfinput type="text" name="descriptionBrief" id="descriptionBrief" required="true" message="Пожалуйста, добавьте краткое описание" />
		<br>
		<label for="bugPriority">Приоритет:</label>
		<cfselect name="bugPriority" id="bugPriority">
			<option value="0">Не выбран</option>
			<cfoutput>
				<cfloop from="1" to="#arrayLen(priority)#" index="i">
					<option value="#i#">#priority[i]#</option>
				</cfloop>
			</cfoutput>
		</cfselect>
		<br>
		<label for="bugSeverity">Критичность:</label>
		<cfselect name="bugSeverity" id="bugSeverity">
			<option value="0">Не выбрана</option>
			<cfoutput>
				<cfloop from="1" to="#arrayLen(severity)#" index="i">
					<option value="#i#">#severity[i]#</option>
				</cfloop>
			</cfoutput>
		</cfselect>
		<br>
		<label for="descriptionFull">Подробное описание: </label>
		<textarea name="descriptionFull" id="descriptionFull"></textarea>
		<br>
		<input type="submit" name="newBugSubmit" id="newBugSubmit" value="Сохранить" />
	</cfform>
</cfif>
</cf_HeaderFooter>