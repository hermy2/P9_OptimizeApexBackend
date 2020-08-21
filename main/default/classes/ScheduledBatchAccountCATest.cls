@isTest
public class ScheduledBatchAccountCATest {
    
    // Dummy CRON expression: every Sunday at 11pm
    public static String CRON_EXP = '0 00 23 ? * 1';
    
    static testmethod void testScheduledJob() {
        //Create test data
        Account acc = new Account();
        acc.name= 'test';
        insert acc;
        
     	Test.startTest(); 
    	//Schedule Test job
    	String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new ScheduledBatchAccountCA());
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        ScheduledBatchAccountCA.scheduleBatch();
        
        Test.stopTest();
        
    } 

}