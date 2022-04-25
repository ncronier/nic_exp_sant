component displayname="Food Editor" output="true" accessors="true"
{
	property name="dataSource" type="string";
	property name="templatePath" type="string";
	
	property name="ingredients" type="array" ;
	property name="compounds" type="array" ;
	property name="classes" type="array" ;


    public function init(required string dataSource, required string templatePath){
		
		setDataSource(arguments.dataSource);
		setTemplatePath(arguments.templatePath);
		
		populateClasses();

		populateIngredients();

		populateCompounds();

    }

	public function populateClasses(){
		variables.classes = arrayNew(1);
		getClassesQuery = queryExecute(
            "SELECT     id, name
            FROM 	    food_classes
			ORDER BY	name ASC
			",
            {
				//user_id = session.user_id
            }, 
            {datasource = getDataSource()} 
        )
	
		if( getClassesQuery.recordCount > 0 ){
			for(ClassRow in getClassesQuery){
				aClassComp = new class(getDataSource(), ClassRow, this);
				if( isValid("component", aClassComp)){
					variables.classes[ClassRow.id] = aClassComp;
				}
			}
		}
	}



	public function populateIngredients(){
		variables.ingredients = arrayNew(1);
		
		 getIngredientsQuery = queryExecute(
            "SELECT     id, name, classes
            FROM 	    food_ingredients
			ORDER BY	name ASC
			",
            {
				//user_id = session.user_id
            }, 
            {datasource = getDataSource()} 
        )

		if( getIngredientsQuery.recordCount > 0 ){
			for(ingredientRow in getIngredientsQuery){
				aIngredientComp = new ingredient(getDataSource(), ingredientRow, this);
				if( isValid("component", aIngredientComp)){
					variables.ingredients[ingredientRow.id] = aIngredientComp;
				}
			}
		}

	}

	public function populateCompounds(){
		variables.compounds= arrayNew(1);
		 getCompoundsQuery = queryExecute(
            "SELECT     id, name, ingredients
            FROM 	    food_compounds
			ORDER BY	name ASC
			",
            {
				//user_id = session.user_id
            }, 
            {datasource = getDataSource()} 
        )

		if( getCompoundsQuery.recordCount > 0 ){
			for(compoundRow in getCompoundsQuery){
				aCompoundComp = new compound(getDataSource(), compoundRow, this);
				if( isValid("component", aCompoundComp)){
					variables.compounds[compoundRow.id] = aCompoundComp;
				};
			}
		};
	}


	public function addIngredientToClass(required component ingredientComp, required string classId){
		getClasses()[arguments.classId].addIngredient(arguments.ingredientComp);
	}


	public function displayOnScreen(){			
		Mcomps = arrayNew(1);
		//the cfm files (views) populate Mcomps: materialize components that need to be initialized
		include variables.templatePath&"inc/views/food/editor.cfm"; 
		return Mcomps
	}

}
