<cfif structKeyExists(form, 'newUserSubmit')>
	<cfset errorMessages = ArrayNew(1) />
	<!---Validate brief description--->
	<cfif form.userFirstName EQ ''>
		<cfset arrayAppend(errorMessages,'Пожалуйста, введите ваше имя') />
	</cfif>
	<!---Validate lastName--->
	<cfif form.userLastName EQ ''>
		<cfset arrayAppend(errorMessages,'Пожалуйста, введите вашу фамилию') />
	</cfif>
	<!---Validate login--->
	<cfif form.userLogin EQ ''>
		<cfset arrayAppend(errorMessages,'Пожалуйста, введите ваш логин для входа в систему') />
	</cfif>
	<!---Validate Password--->
	<cfif form.userPassword EQ '' >
		<cfset arrayAppend(errorMessages,'Пожалуйста, введите желаемый пароль')/>
	</cfif>
	<!---Validate Password confirmation--->
	<cfif form.userPasswordConfirm EQ '' >
		<cfset arrayAppend(errorMessages,'Пожалуйста, повторите пароль')/>
	</cfif>
	<!---validate password and password confirmation Match --->
	<cfif form.userPassword NEQ form.userPasswordConfirm >
		<cfset arrayAppend(errorMessages,'Пароли не совпадают, попробуйте ввести ещё раз')/>
	</cfif>
	<cfif ArrayIsEmpty(errorMessages)>
		<cfset form.id = CreateUUID()>
		<cfset passwordHash = Hash(form.userPassword, "SHA-512" )>
		<cfquery>
			INSERT INTO Users
			(id, loginname, firstname, lastname, password)
			VALUES
			(
				"#form.id#",
				"#form.userLogin#",
				"#form.userFirstName#",
				"#form.userLastName#",
				"#passwordHash#"
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
	<label>Имя:</label> <cfinput type="text" name="userFirstName" id="userFirstName" required="true" message="Пожалуйста, введите ваше имя" /><br>
	<label>Фамилия:</label> <cfinput type="text" name="userLastName" id="userLastName" required="true" message="Пожалуйста, введите вашу фамилию" /><br>
	<label>Логин:</label> <cfinput type="text" name="userLogin" id="userLogin" required="true" message="Пожалуйста, введите логин" /><br>
	<label>Пароль:</label> <cfinput type="password" name="userPassword" id="userPassword" required="true" message="Пожалуйста, введите желаемый пароль" validateAt="onSubmit" /><br>
	<label>Подтвердите пароль:</label> <cfinput type="password" name="userPasswordConfirm" id="userPasswordConfirm" required="true" message="Пожалуйста, повторите пароль" validateAt="onSubmit" /><br>
	<input type="submit" name="newUserSubmit" id="newUserSubmit" value="Сохранить" />
</cfform>