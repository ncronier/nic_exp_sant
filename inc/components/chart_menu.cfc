component displayname="Logger" output="true" accessors="true"
{
	property name="dataSource" type="string";

	property name="measures" type="struct" hint="each key is the id of a measure and the value is a measure component";
	property name="charts" type="array" hint="charts already set in the db - charts table";


    public function init(required string dataSource, string mode){
		
		setDataSource(arguments.dataSource);
 
		variables.measures = structNew();
		populateMeasures();

		variables.charts = arrayNew(1);
		populateCharts();
		//writeDump(this);
    }



	public function populateMeasures(){
		getMeasuresQuery = queryExecute(
            "SELECT     m.id
						,m.type
						,m.name
                        ,m.description 
						,m.unit

						,mdv.block_id
						,mdv.range
						,mdv.step

						,mdv.value as default_value
						,mdv.checked as default_checked				
						,mdv.level_num as default_level_num
						,mdv.custom	as default_custom_value

            FROM 	    measure_logs AS ml
            LEFT JOIN   measures AS m ON m.id = ml.measure_id
			WHERE		user_id = :user_id
			",
            {
				user_id = session.user_id
            }, 
            {datasource = getDataSource()} 
        );

		for(measureRow in getMeasuresQuery){
			aMeasureComp = new measure(getDataSource(), measureRow, this);
			if( isValid("component", aMeasureComp)){
				variables.measures[aMeasureComp.getID()] = aMeasureComp;
			};
		}
	}

	public function insertMeasures(){

		for(iMeasureKey in variables.measures ){
			iMeasure = variables.measures[iMeasureKey];
			
			if( iMeasure.isCheckedInLogForm() ){
				//the measure was checked - lets' log it
				iMeasure.insertInDB();
			}
		}
	}


	public function populateBlocks(){
		
		 getUserBlocks = queryExecute(
            "SELECT     measure_default_values.block_id
						,blocks.color_class
						,blocks.title
						,blocks.order
            FROM 	    measure_default_values
			LEFT JOIN  	blocks ON blocks.id = measure_default_values.block_id
			WHERE		measure_default_values.user_id = :user_id
			GROUP BY 	measure_default_values.block_id
			ORDER BY 	blocks.order ASC
			",
            {
				user_id = session.user_id
            }, 
            {datasource = getDataSource()} 
        )
	
		for(blockRow in getUserBlocks){
			aBlockComp = new block(getDataSource(), blockRow, this);

			if( isValid("component", aBlockComp)){
				arrayAppend(variables.blocks, aBlockComp);
			};
		}
	}

	
	public function displayOnScreen(){		
		Mcomps = arrayNew(1);
		//the cfm files (views) populate Mcomps: materialize components that need to be initialized
		switch( getMode() ){
			case "log": case "confirm":
				include variables.templatePath&"inc/views/logger/logger.cfm"; 
				break;
			case "insert":
				include variables.templatePath&"inc/views/logger/inserted.cfm"; 
				break;
		}
		return Mcomps
	}
}
