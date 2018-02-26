<cfset status = ['Новая','Открытая','Решенная','Закрытая']>
<cfset priority = ['Очень срочно','Срочно','Несрочно','Совсем несрочно']>
<cfset severity = ['Авария','Критичная','Не критичная','Запрос на изменение']>

<cf_HeaderFooter title="New bug">
<cfif structKeyExists(form, 'newBugSubmit')>
	<cfset errorMessages = ArrayNew(1) />
	<!---Validate brief description--->
	<cfif form.descriptionBrief EQ ''>
		<cfset arrayAppend(errorMessages,'Пожалуйста, введите краткое описание') />
	</cfif>
	<!---Validate status--->
	<cfif form.bugStatus EQ 0>
		<cfset arrayAppend(errorMessages,'Пожалуйста, выберите статус ошибки') />
	</cfif>
	<!---Validate priority--->
	<cfif form.bugPriority EQ 0>
		<cfset arrayAppend(errorMessages,'Пожалуйста, выберите приоритет ошибки')/>
	</cfif>
	<!---Validate severity--->
	<cfif form.bugSeverity EQ 0>
		<cfset arrayAppend(errorMessages,'Пожалуйста, выберите критичность ошибки')/>
	</cfif>
	<cfif ArrayIsEmpty(errorMessages)>
		<cfset form.user = CreateUUID()>
		<cfset form.date = Now()>
		<cfquery>
			INSERT INTO Bugs
			(date, description_brief, description_full, user, status, priority, severity)
			VALUES
			(
				#form.date#,
				"#form.descriptionBrief#",
				"#form.descriptionFull#",
				"#form.user#",
				"#form.bugStatus#",
				"#form.bugPriority#",
				"#form.bugSeverity#"
			)
		</cfquery>
	</cfif>
</cfif>

<cfif isDefined('errorMessages') AND NOT ArrayIsEmpty(errorMessages)>
	<cfoutput >
		<cfloop array="#errorMessages#" index="message">
			<p class="errorMessage">#message#</p>
		</cfloop>
	</cfoutput>
</cfif>

<cfform>
	<label for="descriptionBrief">Краткое описание:</label><cfinput type="text" name="descriptionBrief" id="descriptionBrief" required="true" message="Пожалуйста, добавьте краткое описание" /></dd>
	<br>
	<label for="bugStatus">Статус:</label>
	<cfselect name="bugStatus" id="bugStatus">
		<option value="0">Не выбран</option>
		<cfoutput>
			<cfloop from="1" to="#arrayLen(status)#" index="i">
				<option value="#i#">#status[i]#</option>
			</cfloop>
		</cfoutput>
	</cfselect>
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
</cf_HeaderFooter>