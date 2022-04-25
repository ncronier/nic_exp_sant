component displayname="Food compound" output="true" accessors="true" 
{
	property name="dataSource" type="string";

	property name="id" type="string";
	property name="name" type="string";
   	property name="colorClass" type="string";
	//property name="classes" type="array";
	property name="ingredients" type="array";
	property name="editor" type="component";


    public function init(
		required string dataSource
		,required struct compoundRow
		,required component editor
	){
		setDataSource(arguments.dataSource);

		setId(arguments.ingredientRow.id);
		setName(arguments.ingredientRow.name);
		//setColorClass(arguments.ingredientRow.color_class);

		//setColumnClass(arguments.columnClass);
		//setColumnClass("s12 m6 l4 xl3");
		setEditor(arguments.editor);

		/*
        variables.classes = arrayNew(1);
		for(iClassId in listToArray(ingredientRow.classes) ){
			getEditor.addIngredientToClass(ingredientRow.this, iClassId);
			addClass(iClassId);
		};
		*/
		variables.ingredients = arrayNew(1);
		for(iIngredientId in listToArray(arguments.compoundRow.ingredients) ){
			addIngredient(iIngredientId);
		};

    }

	/*
	public function addClass(required component classId){
		aClassComp = getEditor().getClasses()[arguments.classId];
		if( 
			isvalid("component", aClassComp)
			&& NOT arrayFind( this.getClasses, aClassComp)   
		){
			arrayAppend(variables.classes, aClassComp);
		};
	}
	*/

	public function addIngredient(required component ingredientId){
		aIngredientComp = getEditor().getIngredients()[arguments.ingredientId];
		if( 
			isvalid("component", aIngredientComp)
			&& NOT arrayFind(getIngredients(), aIngredientComp)   
		){
			arrayAppend(variables.ingredients, aIngredientComp);
		};
	}


	



}