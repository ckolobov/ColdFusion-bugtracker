<cfparam name="attributes.title" default="Welcome!" >
<cfif thistag.executionMode EQ 'start'>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><cfoutput>#attributes.title# - Bugtracker prototype</cfoutput></title>
</head>
<body>
	<header>
		<!---Display a welcome message--->
    	<p><cfoutput>Welcome #session.stLoggedInUser.userFirstName# #session.stLoggedInUser.userLastName#!</cfoutput></p>
    	<p><!---<a href="/FirstProject/profile.cfm">My Profile</a>---><a href="?logout">Logout</a></p>
	</header>
	<nav><a href="Bugs.cfm">Все ошибки</a><a href="newBug.cfm">Добавить ошибку</a></nav>
<cfelse>
	<footer>
		<p class="copyright">&copy; Copyright 2018</p>
	</footer>
</body>
</html>
</cfif>