<cfscript>
   if( isdefined("form.show_logger")){
        page_subsection="logger";
    }else if( isdefined("form.log_data")){
        //display confirmation screen
        page_subsection="logger_confirmation";
    }else if( isdefined("form.log_data_confirm")){
        page_subsection="logger_insert";
    }else if( isdefined("form.log_data_cancel")){
        page_subsection="logger";
    }else if( isdefined("form.show_charts")){
        page_subsection="charts";
    };
    
</cfscript>