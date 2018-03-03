<cfset users = application.userService.getAllUsers() />
<cf_HeaderFooter title="All users">
	<h1 class="page-heading">Все пользователи</h1>
	<cfif users.recordCount EQ 0>
		<p>Нет зарегистрированных пользователей!</p>
	<cfelse>
		<ul class="users-list">
			<cfoutput query="users">
				<li>#lastname# #firstname#</li>
			</cfoutput>
		</ul>
	</cfif>
</cf_HeaderFooter>