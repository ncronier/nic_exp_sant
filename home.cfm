<div  style="margin:20px;">
    <!---<cfdump var="page_subsection=#page_subsection#">--->

    <cfif isDefined("session.user_id") EQ 0>
        <cfset session.user_id = 1 >
    </cfif>

    <cfscript>

        switch ( page_subsection ) {
            case  "logger":
                //struct containing screen setup and all fields details
               
                logger = new inc.components.logger(variables.DATABASE_datasource, variables.templatePath, "Log");
                Mcomps = arrayNew(1);
                Mcomps = logger.displayOnScreen();
                for ( iMcomp in Mcomps ) {
                    arrayAppend(materializeCompsToInit, iMcomp ); 
                };

            break;

            case  "logger_confirmation":
                logger = new inc.components.logger(variables.DATABASE_datasource, variables.templatePath, "confirm");
                Mcomps = arrayNew(1);
                //confirmation form
                Mcomps = logger.displayOnScreen();
                for ( iMcomp in Mcomps ) {
                    arrayAppend(materializeCompsToInit, iMcomp ); 
                };
            break;

            case  "logger_insert":
                logger = new inc.components.logger(variables.DATABASE_datasource, variables.templatePath, "insert");
                //insert in DB
                logger.insertMeasures();
                //logged screen
                Mcomps = logger.displayOnScreen();
            break;
            
            case "charts":
                include "charts.cfm";
                break;

            case "log_food":
                include variables.templatePath&"inc/views/log_food.cfm";
                break;

            case "edit_food":

                foodEditor = new inc.components.food.editor(variables.DATABASE_datasource, variables.templatePath);
                foodEditor.displayOnScreen();
                //include variables.templatePath&"inc/views/food/edit_food.cfm";
             
                break;

            default:

                break;
        };




    </cfscript>

</div>