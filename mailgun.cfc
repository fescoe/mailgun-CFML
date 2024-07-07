component output="true" displayname="mailgun" accessors="true" extends="ext.mgunLib" {
/**
* @file  mailgun.cfc
* @author  Brian Fescoe
* @description  Connect to MAilgun API with CFML
*/
     public function init(){
         return this;
     }

     remote any function contactForm () { 
        // THis is a post that is used with Vue.js and Axios
         var contactData = deserializeJSON( toString( getHTTPRequestData().content ) );
        // writeDump(contactData)

        var MG = mailguns();

// Correctly encode the 'api' and API key for Basic Auth
var authString = "Basic " & toBase64("api:" & MG.MAILGUN_API_KEY);
saveContent variable="body" {
    writeOutput("<strong>Name:</strong> #contactData.name#<br>
                 <strong>Email:</strong> #contactData.email#<br>
                 <strong>Message:</strong> #contactData.message#");
};
cfhttp( method="POST", url="#MG.MAILGUN_API_URL#", result="mailsent")
{
    cfhttpparam(type="header", name="Authorization", value="#authString#");
    cfhttpparam(type="formfield", name="from", value="mailgun@sandboxc1edeaf501214cb3bb04a83bfc7afb89.mailgun.org"); //This should be replaced with your actual from email address
    // cfhttpparam(type="formfield", name="html", value="#body#"); // uncomment to send html for the body of the email
    cfhttpparam(type="formfield", name="text", value="CFML is the best!"); // text for the boday of the email
    cfhttpparam(type="formfield", name="name", value="#contactData.name#");
    cfhttpparam(type="formfield", name="to", value="myEmail@example.com");
    cfhttpparam(type="formfield", name="subject", value="Contact Form Submission");
};


        //  writeDump( mailsent );
        if( mailsent.status_code eq 200 ){

            AOK = { "status" = "success", "message" = "Your message has been sent." };

            return AOK;
        } else {
        savecontent variable="errorContent" {
		  
	      writeOutput("error:" & mailsent.status_code);
	      
		  writeDump(mailsent.header);
          writeDump(mailsent.filecontent);
	      WriteDump(mailsent);
	    }
        cfhttp( method="POST", url="#MG.MAILGUN_API_URL#", result="emailerrors")
        {
           cfhttpparam(type="header", name="Authorization", value="#authString#");
           cfhttpparam(type="formfield", name="from", value="mailgun@sandboxc1edeaf501214cb3bb04a83bfc7afb89.mailgun.org"); //This should be replaced with your actual from email address
           cfhttpparam(type="formfield", name="html", value="#errorContent#");
           cfhttpparam(type="formfield", name="to", value="myEmail@example.com");
           cfhttpparam(type="formfield", name="subject", value="Contact Form Submission errors");    //cfmail(to="fescoebr@einstein.edu,brian.fescoe@cerner.com", from = "noreply@motorcargoexpress.com", subject="EFNO error" type="html"){writeOutput(errorContent);} // for Railo and CF2016 plus
	    // mailService = new mail(to="fescoe@gmail.com", from = "noreply@fescoe.com", subject="Fez contact error" ,type="html",body=errorContent);
	    // mailService.send();
        }
         
     } // end if
    } // end function
} // end Component