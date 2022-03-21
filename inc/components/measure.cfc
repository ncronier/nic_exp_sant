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


	property name="defaultChecked" type="boolean";
	property name="defaultValue" type="numeric";
	property name="defaultLevelNum" type="numeric";
	property name="defaultRangeStartDate" type="date";
	property name="defaultRangeEndDate" type="date";

    public function init(
		required string dataSource
		,required struct measure_row
	){
		setDataSource(arguments.dataSource);

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
		
		//use that logged value (if exits) to overwrite the default value
		populateDefaultFromLastLogged();

    }


    public function setVal(
        required string attr, 
        required any val = "")
        {

        variables[arguments.attr] = arguments.val;
    }

    public function getVal(required string attr){
        return variables[arguments.attr];
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
			setDefaultRangeEndDate( 
				_makeDateFromRef(listGetAt(arguments.default_custom_value, 3),listGetAt(arguments.default_custom_value, 4) )
			);	
		};
	}

	private function _makeDateFromRef( required string refDate, required string refTime ){

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
				newDate = dateAdd("d", 1, newDate) ;
				break;
			case "tomorrow":
				newDate = dateAdd("d", -1, newDate) ;
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
				case "date_range":
					setDefaultRangeStartDate(loggedRow.range_start_date);
					setDefaultRangeEndDate(loggedRow.range_start_date);
					break;		
			}
		}

	}

}