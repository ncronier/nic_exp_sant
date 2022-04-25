component displayname="Logger Field" output="true" accessors="true" 
{
	property name="dataSource" type="string";

	property name="id" type="string";
	property name="type" type="string";
	property name="name" type="string";
	property name="description" type="string";
	property name="unit" type="string";
	property name="range" type="numeric";
	property name="step" type="numeric";

	property name="levels" type="array";

	property name="blockId" type="string";
	property name="block" type="component";
	property name="logger" type="component" hint="the logger component this is part of";

	//these are the default value to be displayed in the log form for example
	property name="defaultChecked" type="boolean";
	property name="defaultValue" type="numeric";
	property name="defaultLevelNum" type="numeric";
	property name="defaultRangeStartDate" type="date";
	property name="defaultRangeEndDate" type="date";
	property name="defaultStartTimeString" type="string";
	property name="defaultEndTimeString" type="string";
	property name="defaultDate" type="date";
	property name="defaultTimeString" type="string";
	property name="defaultNote" type="string";

	//These are the real value, a set after submitting the log form for example
	property name="checked" type="boolean";
	property name="value" type="numeric";
	property name="levelNum" type="numeric";
	property name="rangeStartDate" type="date";
	property name="rangeEndDate" type="date";
	property name="startTimeString" type="string";
	property name="endTimeString" type="string";
	property name="date" type="date";
	property name="timeString" type="string";
	property name="note" type="string";

    public function init(
		required string dataSource
		,required struct measure_row
		,required component logger
	){
		setDataSource(arguments.dataSource);
		setLogger(arguments.logger);

		setId(arguments.measure_row.id);
		setBlockId(arguments.measure_row.block_id)
		setType(arguments.measure_row.type);
		setName(arguments.measure_row.name);
		setDescription(arguments.measure_row.description);
		setUnit(arguments.measure_row.unit);
		if( len(arguments.measure_row.range) > 0){
			setRange(arguments.measure_row.range);
		}else{	
			setRange(0);
		};
		if( len(arguments.measure_row.step) > 0){
			setStep(arguments.measure_row.step);
		}else{	
			setStep(0);
		};

		setLevels(arrayNew(1));
		if(getType() == "level_select"){
			populateLevels();
		};

		switch(getLogger().getMode()){
			case "log":
				setDefaultValues(arguments.measure_row);
				//use that logged value (if exits) to overwrite the default value
				populateDefaultFromLastLogged();
				break;
			case "confirm": case "insert":
				setValuesFromForm();
				break;
		}

    }

	public function isCheckedInLogForm(){
		if(isdefined( "form.checkbox_"&getId() )){
			return true;
		}else{
			return false;
		}
	}

	public function setValuesFromForm(){
		if(isdefined( "form.checkbox_"&getId() )){
			//that measure was check in the form so it will be recorded
			
			switch(	getType() ){
				case "boolean":
					if( isdefined("form."&getId()) ){
						setValue(1);
					}else{
						setValue(0);
					}
					break;
				case "number_select":
					
					if( isdefined("form."&getId()) ){
						setValue( evaluate("form."&getId()) );
					}else{
						setValue(0);
					}
					break;
				case "level_select":
					if( isdefined("form."&getId()) ){
						setLevelNum( evaluate("form."&getId()) );
					}else{
						setLevelNum(0);
					}
					break;
				case "date_range":
					if( isdefined("form."&getId()&"_date_start") ){
						setRangeStartDate( evaluate("form."&getId()&"_date_start") );
					}else{
						setRangeStartDate(0);
					}
					if( isdefined("form."&getId()&"_date_end") ){
						setRangeEndDate( evaluate("form."&getId()&"_date_end") );
					}else{
						setRangeEndDate(0);
					}
					if( isdefined("form."&getId()&"_time_start") ){
						setStartTimeString( evaluate("form."&getId()&"_time_start") );
					}else{
						setStartTimeString(0);
					}
					if( isdefined("form."&getId()&"_time_end") ){
						setEndTimeString( evaluate("form."&getId()&"_time_end") );
					}else{
						setEndTimeString(0);
					}
					break;
				case "datetime":

					if( isdefined("form."&getId()&"_date") ){
						setDate( evaluate("form."&getId()&"_date") );
					}else{
						setDate(0);
					}
					if( isdefined("form."&getId()&"_time") ){
						setTimeString( evaluate("form."&getId()&"_time") );
					}else{
						setTimeString(0);
					}
					break;
				case "note":	
					if( isdefined("form."&getId()) ){
						setNote( evaluate("form."&getId()) );
					}else{
						setNote("");
					}		
				break;
			}

		}
	}

	public function getCurrentChecked(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultChecked();
				break;
			case "confirm": case "insert":
				return isCheckedInLogForm();
				break;
		}
		
	}

	public function getCurrentValue(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultValue();
				break;
			case "confirm": case "insert":
				return getValue();
				break;
		}
		
	}

	public function getCurrentLevelNum(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultLevelNum();
				break;
			case "confirm": case "insert":
				return getLevelNum();
				break;
		}	
	}
	public function getCurrentRangeStartDate(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultRangeStartDate();
				break;
			case "confirm": case "insert":
				return getRangeStartDate();
				break;
		}		
	}
	public function getCurrentRangeEndDate(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultRangeEndDate();
				break;
			case "confirm": case "insert":
				return getRangeEndDate();
				break;
		}		
	}
	public function getCurrentStartTimeString(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultStartTimeString();
				break;
			case "confirm": case "insert":
				return getStartTimeString();
				break;
		}		
	}
	public function getCurrentEndTimeString(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultEndTimeString();
				break;
			case "confirm": case "insert":
				return getEndTimeString();
				break;
		}		
	}

	public function getCurrentDate(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultDate();
				break;
			case "confirm": case "insert":
				return getDate();
				break;
		}		
	}
	public function getCurrentTimeString(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultTimeString();
				break;
			case "confirm": case "insert":
				return getTimeString();
				break;
		}		
	}

	public function getCurrentDateTime(){
		switch( getLogger().getMode() ){
			case "log":
				return _convertDateTimeValuesToDate( getDefaultDate(), getDefaultTimeString() );
				break;
			case "confirm": case "insert":
				return _convertDateTimeValuesToDate( getDate(), getTimeString() );
				break;
		}		
	}


	public function getCurrentNote(){
		switch( getLogger().getMode() ){
			case "log":
				return getDefaultNote();
				break;
			case "confirm": case "insert":
				return getNote();
				break;
		}		
	}



	public function setDefaultValues(required struct measure_row){
		if( len(arguments.measure_row.default_checked) > 0){
			setDefaultChecked(arguments.measure_row.default_checked);
		}else{
			setDefaultChecked(0);
		};
		if( len(arguments.measure_row.default_value) > 0){
			setDefaultValue(arguments.measure_row.default_value);
		}else{
			setDefaultValue(0);
		};
		if( len(arguments.measure_row.default_level_num) > 0){
			setDefaultLevelNum(arguments.measure_row.default_level_num);
		}else{
			setDefaultLevelNum(0);
		};

		if( getType() == "date_range"){
			setDefaultDateRange( arguments.measure_row.default_custom_value );
		};

		if( getType() == "datetime"){
			setDefaultDatetime( arguments.measure_row.default_custom_value );
		};


		
	}



	public function populateLevels(){
		 getLevels = queryExecute(
            "SELECT     num
						,name
						,description
            FROM 	    measure_levels
			WHERE		measure_id = :measure_id
			ORDER BY	num ASC
			",
            {
				measure_id = getID()
            }, 
            {datasource = getDataSource()} 
        );
		for(levelRow in getLevels){
			aLevel = {
				num:levelRow.num
				, name:levelRow.name
				, description:levelRow.description
			};
			arrayAppend(variables.levels, aLevel);
		};
	}


	public function setDefaultDateRange(
		required string default_custom_value
	){
		if( listlen(arguments.default_custom_value)==4 ){
			setDefaultRangeStartDate( 
				_makeDateFromRef(listGetAt(arguments.default_custom_value, 1),listGetAt(arguments.default_custom_value, 2) ) 
			);
			setDefaultStartTimeString(listGetAt(arguments.default_custom_value, 2));
			setDefaultRangeEndDate( 
				_makeDateFromRef(listGetAt(arguments.default_custom_value, 3),listGetAt(arguments.default_custom_value, 4) )
			);	
			setDefaultEndTimeString(listGetAt(arguments.default_custom_value, 4));
		};
	}

	public function setDefaultDatetime(
		required string default_custom_value
	){
		if( listlen(arguments.default_custom_value)==2 ){
			setDefaultDate( 
				_makeDateFromRef(listGetAt(arguments.default_custom_value, 1),listGetAt(arguments.default_custom_value, 2) ) 
			);
			setDefaultTimeString(listGetAt(arguments.default_custom_value, 2));
		}else if( arguments.default_custom_value == "now" ){
			setDefaultDate( now() );
			setDefaultTimeString( Hour( now() ) &":"& Minute( now() ) );
		};
	}

	







	private function _makeDateFromRef( 
		required string refDate
		, required string refTime
	 ){

		if(listLen(arguments.refTime, "h") == 2){
			aHour = listGetAt(arguments.refTime, 1, "h");
			aMin = listGetAt(arguments.refTime, 2, "h");
		}else{
			aHour = 0;
			aMin = 0;	
		};
		newDate =  CreateDateTime(Year(Now()), Month(Now()), Day(Now()), aHour, aMin, 00);

		switch(arguments.refDate){
			case "yesterday":
				newDate = dateAdd("d", -1, newDate) ;
				break;
			case "tomorrow":
				newDate = dateAdd("d", 1, newDate) ;
				break;
			case "today":
				//no change
				break;

		}
		return newDate;

	};


	public function populateDefaultFromLastLogged(){
		switch( getType() ){
			case "boolean":
				colString="value";
				break;
			case "number_select":
				colString="value";
				break;
			case "level_select":
				colString="level_num";
				break;
			case "date_range":
				colString="range_start_date,range_end_date";
				break;		
			case "datetime":
				colString="apply_date";
				break;	
			case "note":
				colString="note";
				break;	
		}
		getLastLogged = queryExecute(
            "SELECT     #colString#
            FROM 	    measure_logs 
			WHERE		user_id = :user_id
			AND 		measure_id = :measure_id
			ORDER BY	apply_date DESC
			LIMIT 		1
			",
            {
				user_id = session.user_id
				,measure_id = getId()
            }, 
            {datasource = getDataSource()} 
        );

		for(loggedRow in getLastLogged){
			switch( getType() ){
				case "boolean": case "number_select":
					setDefaultValue(loggedRow.value);
					break;
				case "level_select":
					setDefaultLevelNum(loggedRow.level_num);
					break;
				case "note":
					setDefaultNote("");
					break;
				/*
				case "date_range":
					setDefaultRangeStartDate(loggedRow.range_start_date);
					setDefaultRangeEndDate(loggedRow.range_start_date);
					break;
				case "datetime":
					setDefaultDate(loggedRow.apply_date);
					break;
				*/
			}
		}

	}

	public function insertInDB(){

		if( getLogger().checkUseCustomTime() ){
			aApply_date = getLogger().getCustomTime();
		}else{
			aApply_date = now();
		};

		switch( getType() ){
			case "boolean": case "number_select":
				InsertMeasurement = queryExecute(
					"INSERT INTO     measure_logs
						(
							user_id
							,measure_id
							,value
							,apply_date
							,rec_date
						)
					VALUES 
						(
							:user_id
							,:measure_id
							,:value
							,:apply_date
							,:rec_date
						)
					
					", 
					{
					user_id= {value=Session.user_id,CFSQLType='CF_SQL_INTEGER'}
					,measure_id= {value= getID() , CFSQLType='CF_SQL_VARCHAR'}
					,value= {value= getValue() , CFSQLType='CF_SQL_DECIMAL', scale="2" }
					,apply_date= {value= aApply_date , CFSQLType='CF_SQL_TIMESTAMP'}
					,rec_date= {value= now() , CFSQLType='CF_SQL_TIMESTAMP'}
					}, 
					{datasource = getDataSource()
					,result="tmpRes"}
				);	
				writeDump(#tmpRes#);	
				break;
			case "level_select":
				InsertMeasurement = queryExecute(
					"INSERT INTO     measure_logs
						(
							user_id
							,measure_id
							,level_num
							,apply_date
							,rec_date
						)
					VALUES 
						(
							:user_id
							,:measure_id
							,:level_num
							,:apply_date
							,:rec_date
						)
					
					", 
					{
					user_id= {value=Session.user_id,CFSQLType='CF_SQL_INTEGER'}
					,measure_id= {value= getID() , CFSQLType='CF_SQL_VARCHAR'}
					,level_num= {value= getLevelNum() , CFSQLType='CF_SQL_INTEGER'}
					,apply_date= {value= aApply_date , CFSQLType='CF_SQL_TIMESTAMP'}
					,rec_date= {value= now() , CFSQLType='CF_SQL_TIMESTAMP'}
					}, 
					{datasource = getDataSource()
					,result="tmpRes"}
				);	
				//writeDump(#tmpRes#);
				break;
			case "date_range":
				aRangeStartDate = _convertDateTimeValuesToDate( getRangeStartDate() , getStartTimeString() );
				aRangeEndDate = _convertDateTimeValuesToDate( getRangeEndDate() , getEndTimeString() );
				
				InsertMeasurement = queryExecute(
					"INSERT INTO     measure_logs
						(
							user_id
							,measure_id
							,range_start_date
							,range_end_date
							,apply_date
							,rec_date
						)
					VALUES 
						(
							:user_id
							,:measure_id
							,:range_start_date
							,:range_end_date
							,:apply_date
							,:rec_date
						)
					
					", 
					{
					user_id= {value=Session.user_id,CFSQLType='CF_SQL_INTEGER'}
					,measure_id= {value= getID() , CFSQLType='CF_SQL_VARCHAR'}
					,range_start_date= {value= aRangeStartDate , CFSQLType='CF_SQL_TIMESTAMP'}
					,range_end_date= {value= aRangeEndDate , CFSQLType='CF_SQL_TIMESTAMP'}
					,apply_date= {value= aApply_date , CFSQLType='CF_SQL_TIMESTAMP'}
					,rec_date= {value= now() , CFSQLType='CF_SQL_TIMESTAMP'}
					}, 
					{datasource = getDataSource()
					,result="tmpRes"}
				);	
				//writeDump(#tmpRes#);

				break;	
			case "datetime":
				aDate = _convertDateTimeValuesToDate( getDate() , getTimeString() );

				InsertMeasurement = queryExecute(
					"INSERT INTO     measure_logs
						(
							user_id
							,measure_id
							,apply_date
							,rec_date
						)
					VALUES 
						(
							:user_id
							,:measure_id
							,:apply_date
							,:rec_date
						)
					
					", 
					{
					user_id= {value=Session.user_id,CFSQLType='CF_SQL_INTEGER'}
					,measure_id= {value= getID() , CFSQLType='CF_SQL_VARCHAR'}
					,apply_date= {value= aDate , CFSQLType='CF_SQL_TIMESTAMP'}
					,rec_date= {value= now() , CFSQLType='CF_SQL_TIMESTAMP'}
					}, 
					{datasource = getDataSource()
					,result="tmpRes"}
				);	
				//writeDump(#tmpRes#);
				break;	
			case "note":
				InsertMeasurement = queryExecute(
					"INSERT INTO     measure_logs
						(
							user_id
							,measure_id
							,note
							,apply_date
							,rec_date
						)
					VALUES 
						(
							:user_id
							,:measure_id
							,:note
							,:apply_date
							,:rec_date
						)
					
					", 
					{
					user_id= {value=Session.user_id,CFSQLType='CF_SQL_INTEGER'}
					,measure_id= {value= getID() , CFSQLType='CF_SQL_VARCHAR'}
					,note= {value= getNote() , CFSQLType='CF_SQL_VARCHAR'}
					,apply_date= {value= aApply_date , CFSQLType='CF_SQL_TIMESTAMP'}
					,rec_date= {value= now() , CFSQLType='CF_SQL_TIMESTAMP'}
					}, 
					{datasource = getDataSource()
					,result="tmpRes"}
				);	
				//writeDump(#tmpRes#);	
				break;

		}

	}

	private function _convertDateTimeValuesToDate( date rangeDate, string timeString){
		return  CreateDateTime(
					Year(arguments.rangeDate)
					, Month(arguments.rangeDate)
					, Day(arguments.rangeDate)
					, listGetAt(arguments.timeString, 1 , ":")
					, listGetAt(arguments.timeString, 2 , ":")
					, 00
				);
	}

}