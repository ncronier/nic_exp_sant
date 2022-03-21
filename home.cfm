<div style="margin:20px;">

    <cfdump var="page_subsection=#page_subsection#">
    <br>
    <cfif isDefined("session.user_id") EQ 0>
        <cfset session.user_id = 1 >
    </cfif>

    <cfscript>

        switch ( page_subsection ) {
            case  "logger":
                //struct containing screen setup and all fields details
               
                logger = new inc.components.logger(variables.DATABASE_datasource);

                Mcomps = arrayNew(1);
                Mcomps = logger.displayOnScreen();

                for ( iMcomp in Mcomps ) {
                    arrayAppend(materializeCompsToInit, iMcomp ); 
                };
            break;

            case  "logger_confirmation":
                //struct containing screen setup and all fields details
                include "functions.cfm";
                loggerStruct = getLoggerStruct();
                //confirmation view
                include "logger_confirmation.cfm";
            break;

            case  "logger_insert":
                //struct containing screen setup and all fields details
                include "functions.cfm";
                loggerStruct = getLoggerStruct();
                logger = new inc.components.logger();
                //insert in DB
                writeOutput("<p>hello</p>");

                for(aBlock in loggerStruct.screen){
                    for(aFieldProp in aBlock.fields){
                        aField = loggerStruct.fields[aFieldProp];
                        if(isdefined("form."&aFieldProp)){
                            aField = loggerStruct.fields[aFieldProp];

                            if( aField.type == "datepicker"){
                                aAmount = 0;
                                aApply_date = convertDatePickToDate(form[aFieldProp]);
                            }else{
                                aAmount = form[aFieldProp];
                                aApply_date = now();
                            };               

                            
                            InsertMeasurement = queryExecute(
                                "INSERT INTO     measure_logs
                                    (
                                        user_id
                                        ,measure_id
                                        ,amount
                                        ,apply_date
                                        ,rec_date
                                    )
                                VALUES 
                                    (
                                        :user_id
                                        ,:measure_id
                                        ,:amount
                                        ,:apply_date
                                        ,:rec_date
                                    )
                             
                                ", 
                                {
                                user_id= {value=Session.user_id,CFSQLType='CF_SQL_INTEGER'}
                                ,measure_id= {value= aFieldProp , CFSQLType='CF_SQL_VARCHAR'}
                                ,amount= {value= aAmount , CFSQLType='CF_SQL_INTEGER'}
                                ,apply_date= {value= aApply_date , CFSQLType='CF_SQL_TIMESTAMP'}
                                ,rec_date= {value= now() , CFSQLType='CF_SQL_TIMESTAMP'}
                                }, 
                                {datasource = variables.DATABASE_datasource
                                ,result="tmpRes"}
                            );
                            writeDump(#tmpRes#);
                        };
                    };
                };
                //looged view
                include "logger_logged.cfm";
            break;
            
            case "charts":
                 //looged view
                include "charts.cfm";
            break

            default:

             break;
        };




    </cfscript>

</div>