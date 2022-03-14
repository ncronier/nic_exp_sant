<cfif isdefined("variables.blocks") and isValid("array", variables.blocks) and arrayLen(variables.blocks)>
    <form method="post" action="">
        <div class="card">
            <div class="card-content">
                <span class="card-title">Logger:</span> 
                
                <cfloop index="iBlock" array="variables.blocks">
                    <cfinclude  template="block.cfm">
                </cfloop>
            
            
            </div>
        </div>

        <button 
            class="btn waves-effect waves-light"
            type="submit"
            name="log_data"      
        >
            Submit
            <i class="material-icons right">send</i>
        </button>   


        <div class="fixed-action-btn">
            <button class="btn-floating btn-large red" type="submit">
                submit
                <i class="large material-icons">send</i>
            </button>

        </div>
            
            
    </form>
<cfelse>
    <p>No blocks found in logger</p>
</cfif>