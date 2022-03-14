



<cfscript>

    function convertDatePickToDate(required string argDatePick){
        date = parsedateTime(argDatePick, "dd mmm yyyy");
        return date;
    }
    function getLoggerStruct(){
        //get the all last measurements
        /*
            
            Daily:
                --pre-fill de details from previous record 

                waist_min
                waist
                waist_max
                
                skinfold_calipers

                weight

                pull_up_max

                breath_holds before bed
                sleep_from
                sleep_to
                Woke up before/without alarm

                heart_beat
                pef (peak expiratory flow)
                spo2 (Peripheral oxygen saturation) 

                breath_hold

                lung_mucus
                blocked nose
                itchy eyes

                tension musculaire la nuit

                sparadrap la nuit.
                morning_exercice_routine
                ->have a whole block

                sensation vésicule
                
                prise relvar 184/22Ug
                prive ventoncie

                prise huile poisson 
                NOTES

            Isolated
                stool
                nap

                meal

                comment
        */    
        /*
        getMeasurements = queryExecute(
            "SELECT     name
                        ,description 
            FROM 	    measure_logs
            LEFT JOIN   measures ON measures.id = measure_id
            GROUP BY    measures.id
            ORDER BY    measure_", 
            {
            customer_id={value= Session.customer_id , CFSQLType='CF_SQL_INTEGER'}
            ,user_id= {value=Session.user_id,CFSQLType='CF_SQL_INTEGER'}
            ,assessment_code= {value= current_dependency , CFSQLType='CF_SQL_VARCHAR'}
            ,passed= {value= "Y" , CFSQLType='CF_SQL_VARCHAR'}
            }, 
            {datasource = variables.DATABASE_datasource} 
        );
        */
        logger = structNew();
        log_fields = structNew();

        

        log_fields.waist_min = {name:"waist min", unit:"cm", type:"select", range_min:60, range_max:100, step:0.5, checked:true, default_value:85};
        log_fields.waist = {name:"waist", unit:"cm", type:"select", range_min:60, range_max:100, step:0.5, checked:true, default_value:87};
        log_fields.waist_max = {name:"waist max", unit:"cm", type:"select", range_min:60, range_max:100, step:0.5, checked:true, default_value:99};
        log_fields.weight = {name:"weight", unit:"cm", type:"select", range_min:60, range_max:80, step:0.1, checked:true, default_value:71};
        
        
        log_fields.pull_up_max = {name:"pull up max", unit:"pullups", type:"select", range_min:0, range_max:30, step:1, checked:true, default_value:4};
        log_fields.push_up_max = {name:"push up max", unit:"pushups", type:"select", range_min:0, range_max:100, step:1, checked:true, default_value:10};


       

        log_fields.sleep_from = {};


        log_fields.sleep_from_date = {name:"slept from (date)", unit:"date", type:"datepicker",  checked:true, default_value: sleep_from_def_date};
        log_fields.sleep_to_date = {name:"slept until (date)", unit:"date", type:"datepicker",  checked:true, default_value: sleep_to_def_date};
        log_fields.sleep_from_time = {name:"slept from (hour)", unit:"HH:mm", type:"timepicker",  checked:true, default_value: "23:00"};
        log_fields.sleep_to_time = {name:"slept until (hour)", unit:"HH:mm", type:"timepicker",  checked:true, default_value: "7:30"};


        block1 = structNew();
        block1.fields = ["waist_min","waist","waist_max","weight"];
        block1.column_class = "s6 m3 l2 xl2";
        block1.color_class = "blue lighten-5";

        block2 = structNew();
        block2.fields = ["pull_up_max","push_up_max"];
        block2.column_class = "s6 m3 l2 xl2";
        block2.color_class = "amber lighten-5";

        block3 = structNew();
        block3.fields = ["sleep_from_date","sleep_from_time","sleep_to_date","sleep_to_time"];
        block3.column_class = "s6 m3 l2 xl2";
        block3.color_class = "pink lighten-5";

        LogScreen = [block1,block2,block3];

        logger.fields = log_fields;
        logger.screen = LogScreen;

        return logger;
    };


</cfscript>


