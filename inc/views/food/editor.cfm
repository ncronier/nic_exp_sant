<div class="row">

    <!---classes--->
    <div class="col s4">
        <h2 class="editor-header">Food Classes (<cfoutput>#arrayLen(getClasses())#</cfoutput>)</h2>
        <form method="post" action="">
            <div class="collection" style="border:1px solid black; padding:2px;">
                <a type="submit" name="add_class" class="collection-item blue lighten-3 black-text">
                    <i class="material-icons left">add</i>Add Class
                </a>
                <cfloop array="#getClasses()#" index="aClassComp">
                    <a  class="collection-item">
                        <i class="material-icons right blue-text">edit</i>
                        <span class="badge"><cfoutput>#arraylen(aClassComp.getIngredients())#</cfoutput></span>
                        <cfoutput>#aClassComp.getName()#</cfoutput>
                    </a>
                </cfloop>
            </div>
        </form>
    </div>

    <!---ingredients--->
    <div class="col s4">
        <h2 class="editor-header">Food (<cfoutput>#arrayLen(getIngredients())#</cfoutput>)</h2>
        <div class="collection" style="border:1px solid black; padding:2px;">
            <a type="submit" name="add_class" class="collection-item blue lighten-3 black-text">
                <i class="material-icons left">add</i>Add Food
            </a>
            <cfloop array="#getIngredients()#" index="aIngredientComp">
                <a  class="collection-item">
                    <i class="material-icons right blue-text">edit</i>
                    <span class="badge"><cfoutput>#arraylen(aIngredientComp.getClasses())#</cfoutput></span>
                    <cfoutput>#aIngredientComp.getName()#</cfoutput>
                </a>
            </cfloop>       
        </div>
    </div>

    <!---compounds--->
    <div class="col s4">
        <h2 class="editor-header">Food Compounds (<cfoutput>#arrayLen(getCompounds())#</cfoutput>)</h2>
         <div class="collection" style="border:1px solid black; padding:2px;">
            <a type="submit" name="add_compound" class="collection-item blue lighten-3 black-text">
                <i class="material-icons left">add</i>Add Compound
            </a>
            <cfloop array="#getCompounds()#" index="aCompoundComp">
                <a  class="collection-item">
                    <i class="material-icons right blue-text">edit</i>
                    <span class="badge"><cfoutput>#arraylen(aCompoundComp.getIngredients())#</cfoutput></span>
                    <cfoutput>#aCompoundComp.getName()#</cfoutput>
                </a>
            </cfloop>       
        </div>
    </div>
    
</div>



<!---
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
</form>

--->
<!---
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
--->