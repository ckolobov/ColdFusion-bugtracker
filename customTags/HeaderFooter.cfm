<cfparam name="attributes.title" default="Welcome!" >
<cfif thistag.executionMode EQ 'start'>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title><cfoutput>#attributes.title# - Bugtracker prototype</cfoutput></title>
	    <link rel="stylesheet" href="styles/styles.css">
	</head>
	<body class="body">
		<header class="header">
			<cfif structKeyExists(session,'stLoggedInUser')>
			<!---Display a welcome message and navigation--->
		    	<span class="header__user-name"><cfoutput>#session.stLoggedInUser.userFirstName# #session.stLoggedInUser.userLastName#</cfoutput></span>
		    	<a class="header__button" href="Profile.cfm">Мой профиль</a>
		    	<a class="header__button" href="?logout">Выйти</a>
		    	<nav class="main-navigation header__main-navigation">
		    		<a class="main-navigation__item" href="Bugs.cfm">Все ошибки</a>
		    		<a class="main-navigation__item" href="newBug.cfm">Добавить ошибку</a>
		    		<a class="main-navigation__item" href="Users.cfm">Все пользователи</a>
		    		<a class="main-navigation__item" href="newUser.cfm">Добавить пользователя</a>
		    	</nav>
		    <cfelse>
		    	<p class="sign-in-message header__sign-in-message">Пожалуйста, авторизируйтесь или зарегистрируйтесь в системе!</p>
	    	</cfif>
		</header>
		<main class="content">
<cfelse>
		</main>
		<footer class="footer">
			<p class="copyright">&copy; Copyright 2018</p>
		</footer>
	</body>
</html>
</cfif>