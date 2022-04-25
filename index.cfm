<!DOCTYPE html>

<cfheader name="Cache-Control" value="no-cache, no-store, must-revalidate" />
<cfheader name="Pragma" value="no-cache" />
<cfheader name="Expires" value="0" />

<cfsetting enableCFoutputonly = "YES" />


<!--- Start up application --->
<cfapplication
	name="nic_exp_sant"
	sessionManagement="yes"
	sessionTimeout = "#CreateTimeSpan(0, 16, 0, 0)#"
	setClientCookies="yes"
/>

<cfscript>
	// Import libraries 
	include "utils.cfm" runonce=true;
	variables.DATABASE_datasource = "expsant";

	SetLocale("French (Standard)");
	if( FileExists(ExpandPath("suspend.ed")) ){
		if( FileExists(ExpandPath("suspend.ed")) ){
			include "template.cfm" runonce=true;
			if( check_if_test_ip() ){
				session.service_suspended = false;
			}else{
				session.service_suspended = true;
			};
		}else{

		};
	}else{
		session.service_suspended = false;
	};

	//Get template location
	variables.templateName = CGI.script_name;
	variables.templatePath = GetDirectoryFromPath(variables.templateName);

	//Decode URL
	variables.argsString = CGI.path_info;

	//Count the URL elements
	variables.argsCount = ListLen(argsString, "/");

	//Remove index.cfm from the path if we're on a Unix box
	if( (FileExists(ExpandPath(".htaccess"))) OR (FileExists(ExpandPath("live.site"))) ){
		variables.templateName = GetDirectoryFromPath(variables.templateName);
		variables.templateName = Mid(variables.templateName, 1, len(variables.templateName) - 1);
	};

	variables.absoluteURL = "http://" & CGI.SERVER_NAME & variables.templateName & variables.argsString;

	if( (FileExists(ExpandPath(".htaccess"))) OR (FileExists(ExpandPath("live.site"))) ){
		if( CGI.HTTPS == "ON" ){
			variables.GLOBAL_absolute_ajax_path = "https://" & CGI.SERVER_NAME & variables.templatePath;
		}else{
			variables.GLOBAL_absolute_ajax_path = "http://" & CGI.SERVER_NAME & variables.templatePath;
		};
	}else{
		variables.GLOBAL_absolute_ajax_path =  CGI.SERVER_NAME &":"& CGI.SERVER_PORT & variables.templatePath;
	};

	//Check if we are using an SSL connection
	variables.usingSSL = (cgi.https eq "on");
	variables.useSSL = FileExists(ExpandPath("use.ssl"));

	if( variables.useSSL AND not variables.usingSSL ){
		//Redirect the user to the SSL version of the same page
		if(variables.argsString == "/index.cfm"){
			variables.argsString = "";
		};
		variables.redirect_ssl_url = "https://" & CGI.SERVER_NAME & variables.templateName & variables.argsString;
		location(url="#variables.redirect_ssl_url#");
	};
 </cfscript>







<cfif variables.useSSL AND not variables.usingSSL>
	<!--- Redirect the user to the SSL version of the same page --->
	<cfif variables.argsString EQ "/index.cfm">
		<cfset variables.argsString = "" />
	</cfif>
	<cfset variables.redirect_ssl_url = "https://" & CGI.SERVER_NAME & variables.templateName & variables.argsString />
	<cflocation url="#variables.redirect_ssl_url#" addToken="no" />
</cfif>



<cfif	not isdefined("Session.signed_in") OR
		Session.signed_in NEQ "Y">
	<cfset variables.page_action = "show_home" />
	<cfset variables.page_subsection = "sign_in_v2" />
</cfif>




<!--- Process the URL --->
<cfif 	isdefined("Session.service_suspended") AND
		Session.service_suspended EQ True>
	<cfset variables.page_action = "show_home" />
	<cfset variables.page_subsection = "service_suspended" />
<cfelse>

	<cfif variables.argsCount EQ 0>
		<cfset page_title = "Logger">
		<cfset variables.show_tab = "" />
		<cfset variables.page_action = "show_home" />
		<cfset variables.page_subsection = "logger" />
	<cfelse>
		<cfset variables.function = ListGetAt(variables.argsString, 1, "/") />
		<cfswitch expression="#variables.function#">
			<!--- ------------------------------------------------------------- --->
			<cfcase value="logger">
				<cfset page_title = "Logger">
				<cfset variables.show_tab = "" />
				<cfset variables.page_action = "show_home" />
				<cfset variables.page_subsection = "logger" />
			</cfcase>
			<!--- ------------------------------------------------------------- --->
			<cfcase value="stats">
				<cfset page_title = "stats">
				<cfset variables.show_tab = "" />
				<cfset variables.page_action = "show_home" />
				<cfset variables.page_subsection = "sign_in_v2" />
			</cfcase>
			<!--- ------------------------------------------------------------- --->
			<cfcase value="signout">
				<cfset page_title = "signout">
				<cfset variables.show_tab = "" />
				<cfset Session.signed_in = "" />
				<cfset Session.user_options = "" />
				<cflocation url="#variables.templateName#" addToken="no" />
			</cfcase>
			<!--- ------------------------------------------------------------- --->
			<cfcase value="change-password">
				<cfset page_title = "change password">
				<cfset variables.show_tab = "" />
				<cfset variables.page_action = "show_home" />
				<cfset variables.page_subsection = "account_change_password" />
			</cfcase>
			<!--- ------------------------------------------------------------- --->
			<cfcase value="change-email">
				<cfset page_title = "change email">
				<cfset variables.show_tab = "" />
				<cfset variables.page_action = "show_home" />
				<cfset variables.page_subsection = "account_change_email" />
			</cfcase>
			<!--- ------------------------------------------------------------- --->
			<cfcase value="password-reset">
				<cfset page_title = "reset password">
				<cfif variables.argsCount GT 1>
					<cfset variables.uuid = ListGetAt(variables.argsString, 2, "/") />
					<cfset Session.password_reset_uuid = variables.uuid />
				</cfif>

				<cfif variables.useSSL AND not variables.usingSSL>
					<cfset variables.redirect_url = "https://" & CGI.SERVER_NAME & variables.templateName />
				<cfelse>
					<cfset variables.redirect_url = "http://" & CGI.SERVER_NAME & variables.templateName />
				</cfif>

				<cflocation url="#variables.redirect_url#" addToken="no" />
			</cfcase>
		</cfswitch>
	</cfif>

</cfif>

<!---<cfinclude template="globals.cfm" />--->
<cfinclude template="form_handlers.cfm" />

<!--- End of page logic --->

<cfsetting enableCFoutputonly = "NO" />

<!--- https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control --->

<html lang="en-GB" >
	<head>
		<title><cfoutput>#page_title#</cfoutput><!---<cfoutput>#variables.APPLICATION_version_name#</cfoutput>---></title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<meta name="viewport" content="width=1200" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link rel="shortcut icon" href="<cfoutput>#variables.templatePath#</cfoutput>favicon.ico" />

		<script type="text/javascript" src="<cfoutput>#variables.templatePath#</cfoutput>js/scripts.js"></script>
		<link rel="stylesheet" type="text/css" href="<cfoutput>#variables.templatePath#</cfoutput>css/main.css">

		
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet" type="text/css">
		<link type="text/css" rel="stylesheet" media="all" href="<cfoutput>#variables.templatePath#</cfoutput>css/main.css" />
		<link rel="stylesheet" type="text/css" href="<cfoutput>#variables.templatePath#</cfoutput>css/WebfontsKit.css">

		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

		<!----FOR MaterializeCss ------------------------------------------------------------------------->
		<!--Import Google Icon Font-->
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
			<!-- Compiled and minified materialize CSS -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
		<cfset materializeCompsToInit = arrayNew(1)>
		<!------------------------------------------------------------------------------------------------>


		<script type="text/javascript">
			/* Add functions to the queue, to be run after the page has finish loading */

			function addLoadEvent(func) {
  				var oldonload = window.onload;
	  			if (typeof window.onload != 'function') {
    				window.onload = func;
  				} else {
	    			window.onload = function() {
      				oldonload();
      				func();
    				}
  				}
			}

			function show_element(elId){
				var El = document.getElementById(elId);
				El.style.display = '';
			}

			function hide_element(elId){
				var El = document.getElementById(elId);
				El.style.display = 'none';
			}

		</script>

	</head>


	<body>

		<!--- Header --->
		<cfinclude template="header.cfm" />

		<!--- Page body --->
		<cfswitch expression="#variables.page_action#">

			<cfcase value="show_home">
				<cfoutput>#importPage("home.cfm")#</cfoutput>
			</cfcase>

			<cfdefaultcase>
				<!--- Error handler - something went wrong here --->
				<h2>Template not found</h2>

				<p>This application has encountered an unexpected occurrence.</p>
				<p><cfoutput>#variables.page_action#</cfoutput></p>
			</cfdefaultcase>

		</cfswitch>

		<!--- footer --->
		<cfinclude template="footer.cfm" />

	</body>


	
	<!---this is to initialize all the possible materialize components--->
	<cfinclude template="materialize_inits.cfm" />

		
</html>