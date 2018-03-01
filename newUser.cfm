<cf_HeaderFooter>
<!---Validate user--->
<cfif structKeyExists(form, 'newUserSubmit')>
	<cfset errorMessages = application.userService.validateUser(form.userFirstName,form.userLastName,form.userLogin,form.userPassword,form.userPasswordConfirm) />
	<cfif ArrayIsEmpty(errorMessages)>
		<cfset application.userService.addUser(form.userFirstName,form.userLastName,form.userLogin,form.userPassword) />
		<cfset userIsInserted = true />
	</cfif>
</cfif>

<cfif isDefined('userIsInserted')>
	<p>Новый пользователь зарегистрирован!</p>
<cfelse>
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
</cfif>
</cf_HeaderFooter>