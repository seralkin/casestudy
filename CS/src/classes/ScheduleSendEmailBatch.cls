global class ScheduleSendEmailBatch implements Schedulable{
    
    // Define date and time for job to run
    public static final String CRON_JOB = '0 59 23 * * ? *';
   
    // Schedule job manually on predifened date and time
    global static String scheduleManually() {
        ScheduleSendEmailBatch scheduler = new ScheduleSendEmailBatch(); 
        return System.schedule('Send Email Batch', CRON_JOB, scheduler);
    }
    
    // Execute batch job, process 200 records at a time
	global void execute(SchedulableContext sc) {
        SendEmailBatch sendEmailBatch = new SendEmailBatch(); 
 	    Database.executeBatch(sendEmailBatch,200);
    }
    	
}