component displayname="Logger" output="true" accessors="true"
{
	property name="dataSource" type="string";

	property name="measures" type="struct" hint="each key is the id of a measure and the value is a measure component";
	property name="blocks" type="array" hint="blocks are visual cards that contain a number of measures";


    public function init(required string dataSource){
		
		setDataSource(arguments.dataSource);
 
		variables.measures = structNew();
		populateMeasures();

		variables.blocks = arrayNew(1);
		populateBlocks();
		//writeDump(this);
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


	public function addBlock(required component block){
		arrayAppend(variables.blocks, arguments.block);
	};

	public function populateMeasures(){
		 getMeasures = queryExecute(
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

            FROM 	    measures AS m
            LEFT JOIN   measure_default_values AS mdv ON m.id = mdv.measure_id
			WHERE		user_id = :user_id
			",
            {
				user_id = session.user_id
            }, 
            {datasource = getDataSource()} 
        );

		for(measureRow in getMeasures){
			aMeasureComp = new measure(getDataSource(), measureRow);
			if( isValid("component", aMeasureComp)){
				variables.measures[aMeasureComp.getID()] = aMeasureComp;
			};
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
		//logger.cfm populate Mcomps: materialize components that need to be initialized
		include "../views/logger/logger.cfm"; 
		return Mcomps
	}
}
