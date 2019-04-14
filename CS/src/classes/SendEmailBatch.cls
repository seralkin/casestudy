global class SendEmailBatch implements Database.Batchable<sObject>{
   global String query {get;set;}
   global List<Messaging.SingleEmailMessage> emailsToSend {get;set;}
   global Database.QueryLocator start(Database.BatchableContext BC){
       emailsToSend = new List<Messaging.SingleEmailMessage>();
       DateTime now = System.now();
       // query contact records to retrieve contacts which has Survey Date less than now.
       query = 'SELECT Id, FirstName, Email, Language__c, Survey_Date__c FROM Contact WHERE Survey_Date__c < :now AND Email != null';
       system.debug('query :' + query);
       return Database.getQueryLocator(query);
   }
    
   global void execute(Database.BatchableContext BC, List<sObject> scope){               
       List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
       try{
           //Create email list and set Survey Date value to null
           for(sObject sObjectItem : scope){
              emailsTosend.add(createEmail(sobjectItem));
              sObjectItem.put('Survey_Date__c', null); 
           } 
           system.debug('EmailstoSend ***' + emailsToSend);
           //Send emails as a list so that we use 1 email invocation limit for multiple emails.
           Messaging.SendEmailResult [] result = Messaging.sendEmail(emailsToSend); 
           update scope;
           System.debug('Made ' + Limits.getEmailInvocations() + ' email calls out of ' + Limits.getLimitEmailInvocations() + ' allowed');        
       }
       catch (Exception e) {
            system.debug('Following exception has occured ' + e);
       }
   }

   global void finish(Database.BatchableContext BC){

   }
   
   // Create an email message
   private Messaging.SingleEmailMessage createEmail(Sobject sObjectItem){
       Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
       List<String> addresses = new List<String>();
       email.setSubject('Survey');
       email.setHTMLBody(createMessage(sObjectItem));
       addresses.add((String)sObjectItem.get('Email'));
       email.setToAddresses(addresses);
       return email;
   }
    
    // Create an appropriate message string according Language__c, use English if Language is not 'de'
    private String createMessage(Sobject sObjectItem){
       String msg = '';
       if(sObjectItem.get('Language__c') == 'de'){
           msg = 'Hey ' + sObjectItem.get('FirstName') + ', bitte fülle unsere Umfrage aus: http://n26.com/survey/' + sObjectItem.get('Id');
       }
       else{
           msg = 'Hey ' + sObjectItem.get('FirstName') + ', please fill out our survey: http://n26.com/survey/' + sObjectItem.get('Id'); 
       }
       return msg; 
    } 
}