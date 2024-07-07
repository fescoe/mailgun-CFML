component output="true" displayname="dude" accessors="true"{

    // By pass local cors policy 
    
    boolean function onRequestStart( required string targetPage ) {
            
    var response = getPageContext().getResponse();
        response.setHeader("Access-Control-Allow-Origin","*");
        // response.setHeader("Access-Control-Allow-Methods", "DELETE", "POST", "GET", "OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
    
            return true;
        }
    
    }
    
    