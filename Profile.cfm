<!---Form processing begins here--->
<cfif structKeyExists(form,'editUserSubmit')>
	<!---Server side form validation--->
	<cfset errorMessages = application.userService.validateUser(form.userFirstName,form.userLastName,form.userLogin,form.userPassword,form.userPasswordConfirm) />
	<!---Continue form processing if the aErrorMessages array is empty--->
	<cfif arrayIsEmpty(errorMessages)>
		<cfset application.userService.updateUser(form.userFirstName,form.userLastName,form.userLogin,form.userPassword,form.userID) />
		<cfset variables.formSubmitComplete = true />
	</cfif>
</cfif>
<!---Form processing ends here--->

<!---Get user to update--->
<cfset userToUpdate = application.userService.getUserByID(session.stLoggedInUser.userID) />
<cf_HeaderFooter title="Профиль">
		<h1>Ваш профиль</h1>
		<cfform>
			<!---Output error messages if any--->
			<cfif structKeyExists(variables,'errorMessages') AND NOT arrayIsEmpty(errorMessages)>
				<cfoutput>
					<cfloop array="#errorMessages#" index="message">
						<p class="errorMessage">#message#</p>
					</cfloop>
				</cfoutput>
			</cfif>
			<!---Output feedback message if form has been successfully submitted--->
			<cfif structKeyExists(variables,'formSubmitComplete') AND variables.formSubmitComplete>
				<p class="feedback">Ваш профиль обновлен!</p>
			</cfif>
				<!---First name text field--->
				<label for="userFirstName">Имя:</label>
				<cfinput name="userFirstName" id="userFirstName" value="#userToUpdate.firstname#" required="true" message="Пожалуйста, введите имя" validateAt="onSubmit" />
				<!---Last name text field--->
				<label for="userLastName">Фамилия:</label>
				<cfinput name="userLastName" id="userLastName" value="#userToUpdate.lastname#" required="true" message="Пожалуйста, введите фамилию" validateAt="onSubmit" />
				<!---E-Mail Address text field--->
				<label for="userEmail">Логин:</label>
				<cfinput name="userLogin" id="userEmail" value="#userToUpdate.loginname#" required="true" message="Пожалуйста, введите логин" validateAt="onSubmit" />
				<!---Password text field--->
				<label for="userPassword">Пароль:</label>
				<cfinput type="password" name="userPassword" value="#userToUpdate.password#" id="userPassword" required="true" message="Пожалуйста, введите пароль" validateAt="onSubmit" />
				<label for="userPasswordConfirm">Повторите пароль:</label>
				<cfinput type="password" name="userPasswordConfirm" value="#userToUpdate.password#" id="userPasswordConfirm" required="true" message="Пожалуйста, повторите пароль" validateAt="onSubmit" />
			<cfinput name="userID" value="#userToUpdate.id#" type="hidden" />
			<!---Submit button--->
			<input type="submit" name="editUserSubmit" id="editUserSubmit" value="Обновить" />
		</cfform>
</cf_HeaderFooter>