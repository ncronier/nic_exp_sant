
<!--- Compiled and minified JavaScript for MaterializeCss --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"  ></script>
<!---<script src="<cfoutput>#variables.templatePath#</cfoutput>js/materialize/scrollspy_scroll.js"  ></script>--->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        <cfloop array="#materializeCompsToInit#" index="aComponent">     
            <cfswitch expression="#aComponent.type#">

                <cfcase value="datepicker">               
                    var elems = document.querySelectorAll('#<cfoutput>#aComponent.id#</cfoutput>');             
                    completeDate = new Date("<cfoutput>#aComponent.defaultValue.year()#</cfoutput>-<cfoutput>#aComponent.defaultValue.month()#</cfoutput>-<cfoutput>#aComponent.defaultValue.day()#</cfoutput>");
                    var instances = M.Datepicker.init(elems, {
                        format:'dd mmm yyyy',
                        defaultDate:completeDate,
                        setDefaultDate:true
                    });                             
                </cfcase>
               
                <cfcase value="timepicker">      
                    var elems = document.querySelectorAll('#<cfoutput>#aComponent.id#</cfoutput>');
                    var instances = M.Timepicker.init(elems, { twelveHour:false, defaultTime:'<cfoutput>#aComponent.defaultValue#</cfoutput>'});
                    var aInput = document.getElementById("<cfoutput>#aComponent.id#</cfoutput>");
                    aInput.value="<cfoutput>#aComponent.defaultValue#</cfoutput>";
                </cfcase>
              
            </cfswitch>
        </cfloop>
    });
</script>