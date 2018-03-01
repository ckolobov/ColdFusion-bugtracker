<cfparam name="attributes.title" default="Welcome!" >
<cfif thistag.executionMode EQ 'start'>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><cfoutput>#attributes.title# - Bugtracker prototype</cfoutput></title>
</head>
<body>
	<header class="header">
		<cfif structKeyExists(session,'stLoggedInUser')>
		<!---Display a welcome message and navigation--->
    	<p><cfoutput>Добро пожаловать #session.stLoggedInUser.userFirstName# #session.stLoggedInUser.userLastName#!</cfoutput></p>
    	<p><a href="/FirstProject/Profile.cfm">My Profile</a> <a href="?logout">Logout</a></p>
    	<nav><a href="Bugs.cfm">Все ошибки</a> <a href="newBug.cfm">Добавить ошибку</a> <a href="Users.cfm">Все пользователи</a> <a href="newUser.cfm">Добавить пользователя</a></nav>
    	</cfif>
	</header>
	<main class="main">
<cfelse>
	</main>
	<footer class="footer">
		<p class="copyright">&copy; Copyright 2018</p>
	</footer>
</body>
</html>
</cfif>