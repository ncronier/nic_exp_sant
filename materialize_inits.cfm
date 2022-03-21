
<script>
    alert("waha");
</script>
<!--- Compiled and minified JavaScript for MaterializeCss --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"  ></script>
<!---<script src="<cfoutput>#variables.templatePath#</cfoutput>js/materialize/scrollspy_scroll.js"  ></script>--->
<script>
    alert("waehe");
</script>

<script>
    alert("youhou");
    document.addEventListener('DOMContentLoaded', function() {
        alert("DOMContentLoaded");
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
                     alert("start timepicker");                  
                    var elems = document.querySelectorAll('#<cfoutput>#aComponent.id#</cfoutput>');
                    alert(elems);
                    var instances = M.Timepicker.init(elems, { twelveHour:false, defaultTime:"23:15"});
                    <!---
                    var instances = M.Timepicker.init(elems, {
                        defaultTime:<cfoutput>#aComponent.defaultValue#</cfoutput>,
                        twelveHour:false
                    });
                    --->
                    alert("end timepicker");   
                </cfcase>
              
            </cfswitch>
        </cfloop>
    });
</script>