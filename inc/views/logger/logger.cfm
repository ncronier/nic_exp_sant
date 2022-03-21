
<style>
    .cards-container {
      column-break-inside: avoid;
    }
    .cards-container .card {
        display: inline-block;
        overflow: visible;
    }

    @media only screen and (max-width: 600px) {
        .cards-container {
            -webkit-column-count: 1;
            -moz-column-count: 1;
            column-count: 1;
        }
    }
    @media only screen and (min-width: 601px) {
        .cards-container {
            -webkit-column-count: 2;
            -moz-column-count: 2;
            column-count: 2;
        }
    }
    @media only screen and (min-width: 993px) {
        .cards-container {
            -webkit-column-count: 3;
            -moz-column-count: 3;
            column-count: 3;
        }
    }
    .text-center {
    text-align: center;
    }
</style>


<cfif isdefined("variables.blocks") and isValid("array", variables.blocks) and arrayLen(variables.blocks)>
    <form method="post" action="">
        <div class="card">
            <div class="card-content">
                <!---<span class="card-title">Logger:</span>--->
                <div class="row">
                    <div class="col s12 cards-container">
                        <cfloop index="iBlock" array="#variables.blocks#">       
                            <cfinclude  template="block.cfm">
                        </cfloop>
                    </div>
                </div>
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