component displayname="Food Class" output="true" accessors="true" 
{
	property name="dataSource" type="string";

	property name="id" type="string";
	property name="name" type="string";
   	property name="colorClass" type="string";
	property name="ingredients" type="array";
	property name="compounds" type="array";
	property name="editor" type="component";


    public function init(
		required string dataSource
		,required struct foodClassRow
		,required component editor
	){
		setDataSource(arguments.dataSource);

		setId(arguments.foodClassRow.id);
		setName(arguments.foodClassRow.name);
		//setColorClass(arguments.foodClassRow.color_class);

		//setColumnClass(arguments.columnClass);
		//setColumnClass("s12 m6 l4 xl3");
		setEditor(arguments.editor);
        variables.ingredients = arrayNew(1);
    }


	public function addIngredient(required component ingredientComp){
		if( this.isIngredientIncluded(arguments.ingredientComp.getId() ) ){
			arrayAppend(variables.ingredients, arguments.ingredientComp);
		};
	}

	public function isIngredientIncluded(required integer ingredientId){
        if( isvalid("component", getIngredients()[arguments.ingredientId] ) ){
			return true;
		}else{
			return false;
		};
		
	}



}