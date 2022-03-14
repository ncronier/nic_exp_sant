component displayname="Logger Block" output="true" accessors="true" 
{
	property name="id" type="string";
	property name="title" type="string";
   	property name="colorClass" type="string";
	property name="columnClass" type="string";
	property name="measures" type="array";
	property name="logger" type="component";

    public function init(
		required string dataSource
		,required struct blockRow
		,required component logger
	){
		setDataSource(arguments.dataSource);

		setColorIdarguments.blockRow.title);
		setColorTitle(arguments.blockRow.title);
		setColorClass(arguments.blockRow.color_class);

		//setColumnClass(arguments.columnClass);
		setColumnClass("s12 m6 l4 xl3");
        variables.measures = arrayNew(1);
		populateMeasures();
    }


	public function addMeasure(required component measureComp){
		//if( this.isFieldIncluded(arguments.fieldComp.measure_id) ){
			arrayAppend(variables.measures, arguments.measureComp);
		//};
	}

	public function isMeasureIncluded(required string measure_id){
        found = false;
        for( aMeasure in variables.measures){
			if( aMeasure.getId() == arguments.measure_id){
				found = true;
				break;
			}
		};
		return found;
	}

	public function populateMeasures(){
		for(iMeasure in getLogger.getMeasures() ){
			if(iMeasure.getBlockID() == getID()){
				arrayAppend(variables.measures, iMeasure);
				iMeasure.setBlock(this);
			}
		};
	}

}