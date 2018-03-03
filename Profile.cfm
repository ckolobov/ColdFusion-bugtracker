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
		<h1 class="page-heading">Ваш профиль</h1>
		<cfform class="form">
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
				<div class="form__group">
					<label class="label form__label" for="userFirstName">Имя:</label>
					<cfinput class="input form__input" name="userFirstName" id="userFirstName" value="#userToUpdate.firstname#" required="true" message="Пожалуйста, введите имя" validateAt="onSubmit" />
				</div>
				<!---Last name text field--->
				<div class="form__group">
					<label class="label form__label" for="userLastName">Фамилия:</label>
					<cfinput class="input form__input" name="userLastName" id="userLastName" value="#userToUpdate.lastname#" required="true" message="Пожалуйста, введите фамилию" validateAt="onSubmit" />
				</div>
				<!---Login text field--->
				<div class="form__group">
					<label class="label form__label" for="userEmail">Логин:</label>
					<cfinput class="input form__input" name="userLogin" id="userEmail" value="#userToUpdate.loginname#" required="true" message="Пожалуйста, введите логин" validateAt="onSubmit" />
				</div>
				<!---Password text field--->
				<div class="form__group">
					<label class="label form__label" for="userPassword">Пароль:</label>
					<cfinput class="input form__input" type="password" name="userPassword" value="#userToUpdate.password#" id="userPassword" required="true" message="Пожалуйста, введите пароль" validateAt="onSubmit" />
				</div>
				<!---Confirm password text field--->
				<div class="form__group">
					<label class="label form__label" for="userPasswordConfirm">Повторите пароль:</label>
					<cfinput class="input form__input" type="password" name="userPasswordConfirm" value="#userToUpdate.password#" id="userPasswordConfirm" required="true" message="Пожалуйста, повторите пароль" validateAt="onSubmit" />
				</div>
				<!---User id hidden field--->
				<cfinput name="userID" value="#userToUpdate.id#" type="hidden" />
				<!---Submit button--->
				<input class="btn-submit form__btn-submit" type="submit" name="editUserSubmit" id="editUserSubmit" value="Обновить" />
		</cfform>
</cf_HeaderFooter>