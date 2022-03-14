component displayname="Logger Field" output="true" extends="field"
{
   	property name="start_date_value_name" type="string";
	property name="end_date_value_name" type="string";
  	property name="value_name" type="string";
	property name="default_start_date" type="date";
	property name="default_end_date" type="date";
	property name="start_date" type="date";
	property name="end_date" type="date";



    public function init(
		required string measureId hint="the measure_id in the database"
		,required string name
		,required string defaultChecked
		,required string defaultStartDate
		,required string defaultEndDate

	){
		super.init(arguments.name, "timeRange", arguments.defaultChecked);

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


