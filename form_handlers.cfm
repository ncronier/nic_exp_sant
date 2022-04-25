<cfscript>
   if( isdefined("form.show_logger")){
        page_subsection="logger";
    }else if( isdefined("form.submit_logger")){
        //display confirmation screen
        page_subsection="logger_confirmation";
    }else if( isdefined("form.confirm_logger")){
        page_subsection="logger_insert";
    }else if( isdefined("form.log_data_cancel")){
        page_subsection="logger";
    }else if( isdefined("form.show_charts")){
        page_subsection="charts";
    }else if( isdefined("form.log_food")){
        page_subsection="log_food";
    }else if( isdefined("form.edit_food")){
        page_subsection="edit_food";
    };
    
</cfscript>