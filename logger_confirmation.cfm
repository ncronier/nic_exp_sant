   
   
<div class="card">
    <div class="card-content">
        <span class="card-title">Logger:</span> 
            <form method="post" action="">
                <!---<cfdump var="#form#">--->
                <!---
                <cfloop collection="#form#" item="aProp" >
                    <cfif aProp NEQ "FIELDNAMES">
                        <cfoutput>#aProp#:</cfoutput>
                        <cfdump var="#form[aProp]#">
                        <br>
                    </cfif>
                </cfloop>
                --->
                <div class="row">
                    <cfloop index="aBlock" array="#loggerStruct.screen#">
                        <div class="col <cfoutput>#aBlock.column_class#</cfoutput>">
                            <div class="card <cfoutput>#aBlock.color_class#</cfoutput>">
                                <div class="card-content">
                                    <cfloop array="#aBlock.fields#" index="aFieldProp" >
                                        <cfif isdefined("loggerStruct.fields."&aFieldProp) >
                                            <cfset aField = loggerStruct.fields[aFieldProp] >
                                            <cfif isdefined("form.checkbox_"&aFieldProp)>
                                                <input type="hidden" name="<cfoutput>#aFieldProp#</cfoutput>" value="<cfoutput>#form[aFieldProp]#</cfoutput>" >
                                                <p><cfoutput>#aField.name#</cfoutput>: <cfoutput>#form[aFieldProp]#</cfoutput></p>
                                            </cfif>
                                        </cfif>
                                    </cfloop>
                                </div>
                            </div>
                        </div>
                    </cfloop>
                </div>




                <button 
                    class="btn waves-effect waves-light red"
                    type="submit"
                    name="log_data_cancel"
                >
                    cancel
                    <i class="material-icons right">cancel</i>
                </button>

                <button 
                    class="btn waves-effect waves-light"
                    type="submit"
                    name="log_data_confirm"
                >
                    confirm
                    <i class="material-icons right">done_all</i>
                </button>
                
            </form>
    </div>
</div>