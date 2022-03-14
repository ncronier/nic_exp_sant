component displayname="Logger Field" output="true" accessors="true" extends="field"
{
	property name="measureId" type="string";//the measure_id in the database
	property name="unit" type="string";

	property name="defaultValue" type="numeric";//the default values if there is no record in the DB yet.
	property name="selectRange" type="numeric";
	property name="step" type="numeric";

	property name="rangeMin" type="numeric";
	property name="rangeMax" type="numeric";
	property name="value" type="numeric";


    public function init(
		required string measureId hint="the measure_id in the database"
		,required string name
		,required string defaultChecked
		,required string defaultValue
		,required string unit
		,required string selectRange
		,required string step
	){
		super.init(arguments.name, "select", arguments.defaultChecked);
		setMeasureId(arguments.measureId);
		setUnit(arguments.unit);
		setDefaultValue(arguments.defaultValue);
		setSelectRange(arguments.selectRange);
		setStep(arguments.step);

		refValue = getUsersReferenceValue();
		if(refValue != false){
			setDefaultValue(refValue);
		};
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

	public function getUsersReferenceValue() hint="get the last value recorded by this user"{

		getLastRecord = queryExecute(
			"SELECT     id, amount
			FROM 	    measure_logs
			WHERE		user_id = :user_id
			AND			measure_id < :measure_id
			ORDER BY	apply_date DESC
			LIMIT		1
			", 
			{
			user_id={value= Session.user_id , CFSQLType='CF_SQL_VARCHAR'}
			,measure_id= {value= "#variables.measureId#" , CFSQLType='CF_SQL_VARCHAR'}
			}, 
			{datasource = variables.datasource} 
		);

		if(getLastRecord.recordCount > 0){
			return getLastRecord.amount;
		}else{
			return false;
		};

	};

	/*
	public function isModuleIncluded(required string assessment_code){
        found = false;
        for( aModule in variables.modules){
			if( aModule.assessment_code == arguments.assessment_code){
				found = true;
				break;
			}
		};
		return found;
	}


	public function populateModules{

		getLicencedModules = queryExecute(
			"SELECT     a.assessment_code, a.course_review_assessment_code
			FROM 	    assessment_licences AS al
			INNER JOIN   assessments AS a ON a.assessment_code = al.assessment_code
			WHERE		al.customer_id = :customer_id
			AND			al.start_date < :start_date
			AND 		al.end_date > :end_date	
			AND 		a.course_main_title = :course_main_title		
			AND 		a.course_sub_title NOT LIKE '%refresher%'
			ORDER BY	a.course_main_title ASC
			", 
			{
			customer_id={value= Session.customer_id , CFSQLType='CF_SQL_INTEGER'}
			,start_date= {value= "#variables.end_of_today#" , CFSQLType='CF_SQL_TIMESTAMP'}
			,end_date= {value= "#variables.start_of_today#" , CFSQLType='CF_SQL_TIMESTAMP'}
			,course_main_title= {value= "#iLicenceFullCourse.course_main_title#" , CFSQLType='CF_SQL_VARCHAR'} //so it can only be one of the courses in variables.course_restriction
			}, 
			{datasource = variables.DATABASE_datasource} 
		);
		for (iLicencedModule in getLicencedModules){
			if( not isModuleIncluded(iLicencedModule.assessment_code) ){
				aMainModule = new inc.components.menu.module(iLicencedModule.assessment_code);
				aMainModule.populateDetails();
				if(aMoaMainModuledule.getVal("assessment_found")){
					arrayAppend(variables.modules, aMainModule);
				};
			};
			//in case the module has a refresher
			if(len(iLicencedModule.course_review_assessment_code) > 0){
				if( not isModuleIncluded(iLicencedModule.course_review_assessment_code) ){
					aRefModule = new inc.components.menu.module(iLicencedModule.course_review_assessment_code);
					aRefModule.populateDetails();
					if(aRefModule.getVal("assessment_found")){
						aRefModule.setAsRefresherOf(aMainModule);
						aMainModule.addToRefreshers(aRefModule);
						arrayAppend(variables.modules, aRefModule);
					};
				};
			};
		};	

		//now all the modules are populated and exist as component we can deal with courses dependecies between each othere and refer to the components
		for(iModule in variables.modules){
			iModule.populateDependencies();
		};
		//now all dependencies are defined we can determine what the box should look like
		for(iModule in variables.modules){
			iModule.setBoxDisplayDetails();
		};

	}
	*/

}