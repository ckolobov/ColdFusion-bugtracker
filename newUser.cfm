<cf_HeaderFooter title="Новый пользователь">
<!---Validate user--->
<cfif structKeyExists(form, 'newUserSubmit')>
	<cfset errorMessages = application.userService.validateUser(form.userFirstName,form.userLastName,form.userLogin,form.userPassword,form.userPasswordConfirm) />
	<cfif ArrayIsEmpty(errorMessages)>
		<cfset application.userService.addUser(form.userFirstName,form.userLastName,form.userLogin,form.userPassword) />
		<cfset userIsInserted = true />
	</cfif>
</cfif>

<cfif isDefined('userIsInserted')>
	<div class="success-message">
		<p>Новый пользователь зарегистрирован!</p>
		<cfif NOT structKeyExists(session,'stLoggedInUser')>
			<p><a class="btn success-message__btn" href="Bugs.cfm">Войти</a></p>
		</cfif>
	</div>
<cfelse>
	<h1 class="page-heading">Регистрация нового пользователя</h1>
	<cfform class="form form-new-user">
		<cfif isDefined('errorMessages') AND NOT ArrayIsEmpty(errorMessages)>
			<cfoutput >
				<cfloop array="#errorMessages#" index="message">
					<p class="error-message">#message#</p>
				</cfloop>
			</cfoutput>
		</cfif>
		<div class="form__group">
			<label class="label form__label">Имя:</label>
			<cfinput class="input form__input" type="text" name="userFirstName" id="userFirstName" required="true" message="Пожалуйста, введите ваше имя" />
		</div>
		<div class="form__group">
			<label class="label form__label">Фамилия:</label>
			<cfinput class="input form__input" type="text" name="userLastName" id="userLastName" required="true" message="Пожалуйста, введите вашу фамилию" />
		</div>
		<div class="form__group">
			<label class="label form__label">Логин:</label>
			<cfinput class="input form__input" type="text" name="userLogin" id="userLogin" required="true" message="Пожалуйста, введите логин" />
			</div>
		<div class="form__group">
			<label class="label form__label">Пароль:</label>
			<cfinput class="input form__input" type="password" name="userPassword" id="userPassword" required="true" message="Пожалуйста, введите желаемый пароль" validateAt="onSubmit" />
		</div>
		<div class="form__group">
			<label class="label form__label">Подтвердите пароль:</label>
			<cfinput class="input form__input" type="password" name="userPasswordConfirm" id="userPasswordConfirm" required="true" message="Пожалуйста, повторите пароль" validateAt="onSubmit" />
		</div>
		<input class="form__btn-submit btn-submit" type="submit" name="newUserSubmit" id="newUserSubmit" value="Зарегистрировать" />
	</cfform>
</cfif>
</cf_HeaderFooter>