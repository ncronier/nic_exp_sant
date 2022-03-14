<!--- Compiled and minified JavaScript for MaterializeCss --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"  ></script>
<!---<script src="<cfoutput>#variables.templatePath#</cfoutput>js/materialize/scrollspy_scroll.js"  ></script>--->


<script>
    document.addEventListener('DOMContentLoaded', function() {
        <cfloop array="#materializeCompsToInit#" index="aComponent">     
            <cfswitch expression="#aComponent.type#">
                <cfcase value="datepicker">
                    var elems = document.querySelectorAll('#<cfoutput>#aComponent.id#</cfoutput>');
                    completeDate = new Date("<cfoutput>#aComponent.default_value.year()#</cfoutput>-<cfoutput>#aComponent.default_value.month()#</cfoutput>-<cfoutput>#aComponent.default_value.day()#</cfoutput>");
                    var instances = M.Datepicker.init(elems, {
                        format:'dd mmm yyyy',
                        defaultDate:completeDate,
                        setDefaultDate:true
                    });                  
                </cfcase>
                <cfcase value="timepicker">                     
                    var elems = document.querySelectorAll('#<cfoutput>#aComponent.prop_name#</cfoutput>');
                    var instances = M.Timepicker.init(elems, {
                        defaultTime:'<cfoutput>#aComponent.default_value#</cfoutput>',
                        twelveHour:false
                    });
                    
                </cfcase>
            </cfswitch>
        </cfloop>
    });
</script>