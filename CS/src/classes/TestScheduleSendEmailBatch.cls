@isTest
public class TestScheduleSendEmailBatch {
	static testMethod void myUnitTest() {
            Test.startTest();
            String CRON_JOB = '0 59 23 * * ? *';
            createContacts();
            //String jobId = System.schedule('Send Email', CRON_JOB, new ScheduleSendEmailBatch());
            //Schedule manually 
            String jobId = ScheduleSendEmailBatch.scheduleManually();
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_JOB, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
            Test.stopTest();
            
   }
    
    private static void createContacts(){
        List<Contact> contactList = new List<Contact>();
            for(integer i=0;i<200;i++){
                Contact c=new Contact();
                c.FirstName='First Name '+ i;
                c.LastName = 'Last Name ' + i;
                c.Email = 'test' + i + '@test.com';
                c.Phone = '34343434' + i;
                c.Survey_Date__c = System.now().addMinutes(-2);
                if(i<50)
                    c.Language__c = 'en';
                else if(i>=50 && i<100)
                    c.Language__c = 'de';
                else if(i>=100 && i<150)
                    c.Language__c = 'ja';
                else 
                    c.Language__c = 'it';
                
                contactList.add(c);
            }
            
            if(contactList.size()>0)
                 insert contactList;
    }
}