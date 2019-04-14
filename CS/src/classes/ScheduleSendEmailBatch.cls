global class ScheduleSendEmailBatch implements Schedulable{
    
    // Define date and time for job to run
    public static final String CRON_JOB = '0 59 23 * * ? *';
   
    // Execute batch job on given date and time
	global void execute(SchedulableContext sc) {
        SendEmailBatch sendEmailBatch = new SendEmailBatch(); 
 	    Database.executeBatch(sendEmailBatch,200);
    }
    	
}