component output="true" displayname="mailgunLib" accessors="true" {
/**
* @file  ext/mgunLib.cfc
* @author  Brian Fescoe
* @description  keys and such
*/
     public function init(){
         return this;
     }

     remote struct function mailguns()  { 
        // We are going to hold the mailgun keys and other config info.. Ideally the keys should like on a file on the server 
        // located outside of the web rooot and not in the code.
         mailgunConfig = 
         {
            "MAILGUN_API_KEY"="key-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
            "MAILGUN_API_URL" = "mailgun api url", //https://api.mailgun.net/v3/sandboxc1edeaf501214cb3bb04a83bfc7afb89.mailgun.org/messages
         }
         return mailgunConfig;
     }
} // end Component