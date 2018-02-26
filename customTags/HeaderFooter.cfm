<cfparam name="attributes.title" default="Bugtracker prototype" >
<cfif thistag.executionMode EQ 'start'>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><cfoutput>#attributes.title#</cfoutput></title>
</head>
<body>
	<header>
	</header>
<cfelse>
	<footer>
		    <p class="copyright">&copy; Copyright 2018</p>
	</footer>
</body>
</html>
</cfif>