
<form method="post" action="">
    <button 
        class="btn waves-effect waves-light"
        type="submit"
        name="log_food"      
    >
        Log Food
    </button>  
     <button 
        class="btn waves-effect waves-light"
        type="submit"
        name="edit_food"      
    >
        Edit Food
    </button>  
</form>
<cfif isdefined("variables.blocks") and isValid("array", variables.blocks) and arrayLen(variables.blocks)>
    <form method="post" action="">
        <div class="card">
            <div class="card-content">
                <!---<span class="card-title">Logger:</span>--->
                <div class="row no-mb">
                    <div class="col s12 cards-container">
                        <cfloop index="iBlock" array="#variables.blocks#">       
                            <cfinclude  template="block.cfm">
                        </cfloop>
                    </div>
                </div>
            </div>
        </div>

        <cfif this.getMode() EQ "log">
            <button 
                class="btn waves-effect waves-light"
                type="submit"
                name="submit_logger"      
            >
                Submit
                <i class="material-icons right">send</i>
            </button>  
        <cfelseif this.getMode() EQ "confirm">
            <button 
                class="btn green waves-effect waves-light"
                type="submit"
                name="confirm_logger"      
            >
                Confirm
                <i class="material-icons right">check</i>
            </button>  
        </cfif>
            
    </form>
<cfelse>
    <p>No blocks found in logger</p>
</cfif>