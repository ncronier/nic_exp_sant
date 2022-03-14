<cffunction name="importPage">
	<!--- Template to include --->
	<cfargument	name="template" type="string" required="yes" />

	<cfif FileExists(ExpandPath(template))>
		<!--- Template found, so import --->
		<cfoutput>
		<cfinclude template="#arguments.template#" />
		</cfoutput>
	<cfelse>
		<!--- Template not found, display an error message --->
		<div id="container">
			<div class="content">
				<div class="box-header">
					<h2>Error</h2>
				</div>

				<div class="inner">
					<div class="logical-block">
						<p>A required component of this page could not be found.</p>

						<p>If the problem persists, please <a href="<cfoutput>#variables.templateName#</cfoutput>/support">contact our technical support team</a>.</p>
					</div>
				</div>
			</div>
		</div>
	</cfif>
</cffunction>