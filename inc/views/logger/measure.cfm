
<cfif 
    isDefined("iMeasure") 
    and isValid("component", iMeasure) 
    <!---and iMeasure.getType() EQ "number_select"--->
>
    <label>
        <input name="checkbox_<cfoutput>#iMeasure.getID()#</cfoutput>" 
            type="checkbox"
            class="filled-in" 
            <cfif iMeasure.defaultChecked()>
                checked="checked"
            </cfif>
        />
        <span><cfoutput>#iMeasure.getName()#</cfoutput>:</span>
        
        <cfswitch expression="#iMeasure.getType()#">

            <cfcase value="boolean">
                <input name="<cfoutput>#iMeasure.getId()#</cfoutput>" 
                    type="checkbox"
                    class="filled-in" 
                    <cfif iMeasure.getDefaultValue() EQ 1 >
                        checked="checked"
                    </cfif>
                />
                <cfbreak>
            </cfcase>

            <cfcase value="number_select">

                <select 
                    class="browser-default"
                    name="<cfoutput>#iMeasure.getId()#</cfoutput>" 
                    rows="1" 
                >
                    <cfset aRangeMin = iMeasure.getDefaultValue() - iMeasure.getRange()>
                    <cfset aRangeMax = iMeasure.getDefaultValue() + iMeasure.getRange()>
                    <cfloop 
                        index="aNum"
                        from="#aRangeMin#"
                        to ="#aRangeMax#"
                        step="#iMeasure.getStep()#"
                    >
                            <option 
                                value="<cfoutput>#aNum#</cfoutput>"
                                <cfif aNum EQ iMeasure.getDefaultValue() >
                                    selected
                                </cfif>
                            ><cfoutput>#aNum#</cfoutput> <cfoutput>#iMeasure.getUnit#</cfoutput></option>
                    </cfloop>
                </select>  
                <cfbreak>
            </cfcase>

             <cfcase value="level_select">

                <select 
                    class="browser-default"
                    name="<cfoutput>#iMeasure.getId()#</cfoutput>" 
                    rows="1" 
                >
  
                    <cfloop 
                        index="iLevel"
                        array="#iMeasure.getLevels()#"
                    >
                            <option 
                                value="<cfoutput>#iLevel.num#</cfoutput>"
                                <cfif iLevel.num EQ iMeasure.getDefaultLevelNum() >
                                    selected
                                </cfif>
                            ><cfoutput>#iLevel.num#</cfoutput> <cfoutput>#iLevel.name#</cfoutput></option>
                    </cfloop>
                </select>  
                <cfbreak>
            </cfcase>


            <cfcase value="date_range">
                <span>From:</span>
                    <input 
                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_date_start"
                    type="text" 
                    name="<cfoutput>#iMeasure.getId#</cfoutput>_date_start" 
                    class="datepicker"
                    value="<cfoutput>#iMeasure.getDefaultRangeStartDate()#</cfoutput>"
                    >
                    <cfscript>
                        aMcomp = {
                            type:"datepicker"
                            ,id:iMeasure.getId()&"_date_start"
                            ,defaultValue:iMeasure.getDefaultRangeStartDate()
                        };
                        arrayAppend(Mcomps, aMcomp);
                    </cfscript>

                    <input 
                    id="<cfoutput>#iMeasure.getId#</cfoutput>_time_start"
                    type="text" 
                    name="<cfoutput>#iMeasure.getId#</cfoutput>_time_start" 
                    class="timepicker"
                    value="<cfoutput>#iMeasure.getDefaultRangeStartDate()#</cfoutput>" 
                    >
                    <cfscript>
                        aMcomp = {
                            type:"timepicker"
                            ,id:iMeasure.getId()&"_time_start"
                            ,defaultValue:iMeasure.getDefaultRangeStartDate()
                        };
                        arrayAppend(Mcomps, aMcomp);
                    </cfscript>

                <span>From:</span>
                    <input 
                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_date_end"
                    type="text" 
                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_date_end" 
                    class="datepicker"
                    value="<cfoutput>#iMeasure.getDefaultRangeEndDate()#</cfoutput>"
                    >
                    <cfscript>
                        aMcomp = {
                            type:"datepicker"
                            ,id:iMeasure.getId()&"_date_end"
                            ,defaultValue:iMeasure.getDefaultRangeEndDate()
                        };
                        arrayAppend(Mcomps, aMcomp);
                    </cfscript>

                    <input 
                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_time_end"
                    type="text" 
                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_time_end" 
                    class="timepicker"
                    value="<cfoutput>#iMeasure.getDefaultRangeEndDate()#</cfoutput>" 
                    >
                    <cfscript>
                        aMcomp = {
                            type:"timepicker"
                            ,id:iMeasure.getId()&"_time_end"
                            ,defaultValue:iMeasure.getDefaultRangeEndDate()
                        };
                        arrayAppend(Mcomps, aMcomp);
                    </cfscript>


                <cfbreak>
            </cfcase>

        </cfswitch>
    </label>
</cfif>