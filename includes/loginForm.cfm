<!---Form processing begins here--->
<cfif structkeyExists(form,'submitLogin')>
	<!---Create an instance of the authentication service component--->
	<cfset authenticationService = createobject("component",'components.authenticationService') />
	<!---server side data validation--->
	<cfset errorMessages = authenticationService.validateUser(form.userLogin,form.userPassword) />
	<cfif ArrayisEmpty(errorMessages)>
		<!---proceed to the login procedure--->
		<cfset isUserLoggedIn = authenticationService.doLogin(form.userLogin,form.userPassword) />
	</cfif>
</cfif>
<!---Form processing end here--->
<cfform id="frmConnexion" preservedata="true">
    <cfif structKeyExists(variables,'errorMessages') AND NOT ArrayIsEmpty(errorMessages)>
    	<cfoutput>
    		<cfloop array="#errorMessages#" item="message">
    			<p class="errorMessage">#message#</p>
    		</cfloop>
    	</cfoutput>
    </cfif>
    <cfif structKeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
    	<p class="errorMessage">Пользователь не найдет, попробуйте ещё раз!</p>
    </cfif>
    <cfif structKeyExists(session,'stLoggedInUser')>
    	<!---Refresh page--->
	    <script>        
	        window.location.reload(true);
	    </script>
    <cfelse>
	    	<label for="fld_userEmail">E-mail address</label>
	        <cfinput type="text" name="userLogin" id="userLogin" required="true" validateAt="onSubmit" message="Пожалуйста, введите логин" />
			<label for="fld_userPassword">Password</label>
	        <cfinput type="password" name="userPassword" id="userPassword" required="true" validateAt="onSubmit" message="Пожалуйста, введите пароль" />
	    <cfinput type="submit" name="submitLogin" id="submitLogin" value="Login" /><a href="/FirstProject/newUser.cfm">Зарегистрироваться</a>
    </cfif>
</cfform>
