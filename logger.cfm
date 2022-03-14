

<cfif isdefined("LogScreen") AND isdefined("log_fields")>


    <div class="card">
        <div class="card-content">
        <span class="card-title">Logger:</span> 
            <form method="post" action="">
                <!---
                <input type="hidden" name="period_amount" value="120" >
                --->
                 <div class="row">
                    <cfloop index="aBlock" array="#loggerStruct.screen#">
                        <div class="col <cfoutput>#aBlock.column_class#</cfoutput>">
                            <div class="card <cfoutput>#aBlock.color_class#</cfoutput>">
                                <div class="card-content">
                                    <cfloop array="#aBlock.fields#" index="aFieldProp">

                                        <cfif isdefined("loggerStruct.fields."&aFieldProp)>
                                            <cfset aField = loggerStruct.fields[aFieldProp]>
                                            
                                            <label>
                                                <input name="checkbox_<cfoutput>#aFieldProp#</cfoutput>" 
                                                    type="checkbox"
                                                    class="filled-in" 
                                                    <cfif aField.checked>
                                                     checked="checked"
                                                    </cfif>
                                                />
                                                <span><cfoutput>#aField.name#</cfoutput>:</span>
                                                <cfswitch expression="#aField.type#">
                                                    <cfcase value="select">
                                                         <select 
                                                            class="browser-default"
                                                            name="<cfoutput>#aFieldProp#</cfoutput>" 
                                                            rows="1" 
                                                         >
                                                            <cfloop 
                                                                index="aNum"
                                                                from="#aField.range_min#"
                                                                to ="#aField.range_max#"
                                                                step="#aField.step#"
                                                            >
                                                                    <option 
                                                                        value="<cfoutput>#aNum#</cfoutput>"
                                                                        <cfif aNum EQ aField.default_value >
                                                                            selected
                                                                        </cfif>
                                                                    ><cfoutput>#aNum#</cfoutput> <cfoutput>#aField.unit#</cfoutput></option>
                                                            </cfloop>
                                                        </select>
                                                        
                                                    </cfcase>
                                                     <cfcase value="datepicker">
                                                         <input 
                                                            id="<cfoutput>#aFieldProp#</cfoutput>"
                                                            type="text" 
                                                            name="<cfoutput>#aFieldProp#</cfoutput>" 
                                                            class="datepicker"
                                                         >
                                                    </cfcase>
                                                    <cfcase value="timepicker">
                                                         <input 
                                                            id="<cfoutput>#aFieldProp#</cfoutput>"
                                                            type="text" 
                                                            name="<cfoutput>#aFieldProp#</cfoutput>" 
                                                            class="timepicker"
                                                            value="<cfoutput>#aField.default_value#</cfoutput>" 
                                                         >
                                                    </cfcase>

                                                </cfswitch>
                                            </label>
                                            
                                            
                                        <cfelse>
                                            <p class="error">The field '<cfoutput>#aFieldProp#</cfoutput>' is not defined</p>
                                        </cfif>
                                    </cfloop>
                                </div>
                            </div>
                        </div>
                    </cfloop>
                </div>

                <button 
                    class="btn waves-effect waves-light"
                    type="submit"
                    name="log_data"
            
                >
                    Submit
                    <i class="material-icons right">send</i>
                </button>
                
            </form>

        </div>
    </div>

</cfif>