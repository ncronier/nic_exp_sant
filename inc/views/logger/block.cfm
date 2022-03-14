<cfif isValid("array", iBlock.getMeasures() ) and arrayLen(iBlock.getMeasures() )>
    <div class="col <cfoutput>#iBlock.getColumnClass()#</cfoutput>">
        <div class="card <cfoutput>#iBlock.getColorClass()#</cfoutput>">
            <div class="card-content">
                <cfloop index="iMeasure" array="#iBlock.getMeasures()#">
                    <cfinclude  template="measure.cfm">                 
                </cfloop>
            </div>
        </div>
    </div>
<cfelse>
    <p>0 fields found in block</p>
</cfif>