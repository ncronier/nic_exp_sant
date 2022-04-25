
<cfif 
    isDefined("iMeasure") 
    and isValid("component", iMeasure) 
    <!---and iMeasure.getType() EQ "number_select"--->
>
    

    <cfif iMeasure.getLogger().getMode() EQ "log" >
        <cfset textColorClass ="black-text">
        <cfset measureExtraClass = "">
    <cfelse>
        <cfif iMeasure.isCheckedInLogForm() >
            <cfset textColorClass ="black-text">
            <cfset measureExtraClass = "">
        <cfelse>
            <cfset textColorClass ="grey-text  text-lighten-1">
             <cfset measureExtraClass = "skipped">
        </cfif>
    </cfif>

        <div class="measure-block <cfoutput>#measureExtraClass#</cfoutput>" style="width:100%;">
            <label 
                class="<cfoutput>#textColorClass#</cfoutput>"          
            >
                
                <div class="row no-mb" >
                    <cfif 
                        iMeasure.getType() EQ "date_range"
                        OR iMeasure.getType() EQ "datetime"
                        OR iMeasure.getType() EQ "note" 
                    >
                        <cfset aTitleColClass="s12">
                        <cfset aInputClass="s12">
                    <cfelse>
                        <cfset aTitleColClass="s7">
                        <cfset aInputClass="s5">
                    </cfif>
                    <div class="col <cfoutput>#aTitleColClass#</cfoutput> <cfoutput>#textColorClass#</cfoutput>">
                        <cfif 
                            iMeasure.getLogger().getMode() EQ "log"
                            OR 
                            (
                                iMeasure.getLogger().getMode() EQ "confirm"
                                AND iMeasure.getCurrentChecked()
                            )
                        >
                            <input name="checkbox_<cfoutput>#iMeasure.getID()#</cfoutput>" 
                                type="checkbox"
                                class="filled-in" 
                                <cfif iMeasure.getCurrentChecked()>
                                    checked="checked"
                                </cfif>
                            />
                        </cfif>
                        <span class="measure-name"><cfoutput>#iMeasure.getName()#</cfoutput>:</span>
                    </div>
                
                    <cfswitch expression="#iMeasure.getType()#">

                        <cfcase value="boolean">
                            <div class="col <cfoutput>#aInputClass#</cfoutput>">
                                <cfif 
                                    iMeasure.getLogger().getMode() EQ "log"
                                    OR iMeasure.isCheckedInLogForm() 
                                >
                                    <div class="switch right" style="margin-top:4px;">
                                        <label class="black-text">
                                        No
                                        <input 
                                            
                                            name="<cfoutput>#iMeasure.getId()#</cfoutput>" 
                                            type="checkbox"
                                            <cfif iMeasure.getCurrentValue() EQ 1 >
                                                checked="checked"
                                            </cfif>
                                        >
                                        <span class="lever"></span>
                                        Yes
                                        </label>
                                    </div>
                                </cfif>
                            </div>
                        </cfcase>

                        <cfcase value="number_select">
                            <div class="col <cfoutput>#aInputClass#</cfoutput>">
                                 <cfif 
                                    iMeasure.getLogger().getMode() EQ "log"
                                    OR iMeasure.isCheckedInLogForm() 
                                >
                                    <cfif iMeasure.getRange() GT 0 AND iMeasure.getStep() GT 0>
                                        <select 
                                            class="browser-default"
                                            name="<cfoutput>#iMeasure.getId()#</cfoutput>" 
                                            rows="1" 
                                        >

                                            <cfset aRangeMin = iMeasure.getCurrentValue() - iMeasure.getRange()>
                                            <cfset aRangeMax = iMeasure.getCurrentValue() + iMeasure.getRange()>
                                            <cfloop 
                                                index="aNum"
                                                from="#aRangeMin#"
                                                to ="#aRangeMax#"
                                                step="#iMeasure.getStep()#"
                                            >
                                                    <cfset mySel = round(iMeasure.getCurrentValue()*100) - round(aNum*100) >
                                                    <option 
                                                        value="<cfoutput>#aNum#</cfoutput>"
                                                        <cfif mySel EQ 0 >
                                                            selected
                                                        </cfif>
                                                    ><cfoutput>#aNum#</cfoutput> <cfoutput>#iMeasure.getUnit()#</cfoutput></option>
                                            </cfloop>
                                        </select>  
                                    <cfelse>
                                        <p class="grey-text">Range not defined</p>
                                    </cfif>
                                </cfif>
                            </div>
                        </cfcase>

                        <cfcase value="level_select">
                            <div class="col <cfoutput>#aInputClass#</cfoutput>">
                                <cfif 
                                    iMeasure.getLogger().getMode() EQ "log"
                                    OR iMeasure.isCheckedInLogForm() 
                                >
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
                                                    <cfif iLevel.num EQ iMeasure.getCurrentLevelNum() >
                                                        selected
                                                    </cfif>
                                                ><cfoutput>#iLevel.num#</cfoutput> - <cfoutput>#iLevel.name#</cfoutput> - <cfoutput>#iLevel.description#</cfoutput></option>
                                        </cfloop>
                                    </select>  
                                </cfif>
                            </div>
                        </cfcase>

                        
                        <cfcase value="date_range">
                             <cfif 
                                    iMeasure.getLogger().getMode() EQ "log"
                                    OR iMeasure.isCheckedInLogForm() 
                                >

                                <div class="col s2">
                                    <span>From:</span>
                                </div>
                                <div class="col s6">
                                    <input 
                                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_date_start"
                                    type="text" 
                                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_date_start" 
                                    class="datepicker"
                                    value="<cfoutput>#iMeasure.getCurrentRangeStartDate()#</cfoutput>"
                                    >
                                    <cfscript>
                                        aMcomp = {
                                            type:"datepicker"
                                            ,id:iMeasure.getId()&"_date_start"
                                            ,defaultValue:iMeasure.getCurrentRangeStartDate()
                                        };
                                        arrayAppend(Mcomps, aMcomp);
                                    </cfscript>
                                </div>
                                <div class="col s4">
                                    <input 
                                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_time_start"
                                    type="text" 
                                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_time_start" 
                                    class="timepicker"
                                    <!--- value="<cfoutput>#iMeasure.getCurrentStartTimeString()#</cfoutput>"  --->
                                    >
                                    <cfscript>
                                        aMcomp = {
                                            type:"timepicker"
                                            ,id:iMeasure.getId()&"_time_start"
                                            ,defaultValue:iMeasure.getCurrentStartTimeString()
                                        };
                                        arrayAppend(Mcomps, aMcomp);
                                    </cfscript>
                                </div>

                                <div class="col s2">
                                    <span>Until:</span>
                                </div>
                                <div class="col s6">
                                    <input 
                                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_date_end"
                                    type="text" 
                                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_date_end" 
                                    class="datepicker"
                                    value="<cfoutput>#iMeasure.getCurrentRangeEndDate()#</cfoutput>"
                                    >
                                    <cfscript>
                                        aMcomp = {
                                            type:"datepicker"
                                            ,id:iMeasure.getId()&"_date_end"
                                            ,defaultValue:iMeasure.getCurrentRangeEndDate()
                                        };
                                        arrayAppend(Mcomps, aMcomp);
                                    </cfscript>
                                </div>

                                <div class="col s4">
                                    <input 
                                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_time_end"
                                    type="text" 
                                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_time_end" 
                                    class="timepicker"
                                    <!--- value="<cfoutput>#iMeasure.getCurrentEndTimeString()#</cfoutput>"  --->
                                    >
                                    <cfscript>
                                        aMcomp = {
                                            type:"timepicker"
                                            ,id:iMeasure.getId()&"_time_end"
                                            ,defaultValue:iMeasure.getCurrentEndTimeString()
                                        };
                                        arrayAppend(Mcomps, aMcomp);
                                    </cfscript>
                                </div>
                            </cfif>

                        </cfcase>

                        <cfcase value="datetime">
                             <cfif 
                                    iMeasure.getLogger().getMode() EQ "log"
                                    OR iMeasure.isCheckedInLogForm() 
                                >

                                <div class="col s2">
                                    <span>apply to:</span>
                                </div>
                                <div class="col s6">
                                    <input 
                                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_date"
                                    type="text" 
                                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_date" 
                                    class="datepicker"
                                    value="<cfoutput>#iMeasure.getCurrentDate()#</cfoutput>"
                                    >
                                    <cfscript>
                                        aMcomp = {
                                            type:"datepicker"
                                            ,id:iMeasure.getId()&"_date"
                                            ,defaultValue:iMeasure.getCurrentDate()
                                        };
                                        arrayAppend(Mcomps, aMcomp);
                                    </cfscript>
                                </div>
                                <div class="col s4">
                                    <input 
                                    id="<cfoutput>#iMeasure.getId()#</cfoutput>_time"
                                    type="text" 
                                    name="<cfoutput>#iMeasure.getId()#</cfoutput>_time" 
                                    class="timepicker"
                                    >
                                    <cfscript>
                                        aMcomp = {
                                            type:"timepicker"
                                            ,id:iMeasure.getId()&"_time"
                                            ,defaultValue:iMeasure.getCurrentTimeString()
                                        };
                                        arrayAppend(Mcomps, aMcomp);
                                    </cfscript>
                                </div>


                            </cfif>

                        </cfcase>
                        
                        <cfcase value="note">
                            <div class="col <cfoutput>#aInputClass#</cfoutput>">
                                <cfif 
                                    iMeasure.getLogger().getMode() EQ "log"
                                    OR iMeasure.isCheckedInLogForm() 
                                >
                                    <input 
                                        class="browser-default"
                                        style="width:100%;"
                                        type="text" 
                                        name="<cfoutput>#iMeasure.getId()#</cfoutput>"
                                        value="<cfoutput>#iMeasure.getCurrentNote()#</cfoutput>"
                                     />
                                </cfif>
                            </div>
                        </cfcase>

                    </cfswitch>
                    
                </div>
            </label>
        </div>

 
</cfif>