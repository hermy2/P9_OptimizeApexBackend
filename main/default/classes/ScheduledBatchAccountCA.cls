global class ScheduledBatchAccountCA implements Schedulable {
    
    //Runs every Sunday at 11pm
    public static String sch = '0 00 23 ? * 1';
    
    global static String scheduleBatch() {
      ScheduledBatchAccountCA sc = new ScheduledBatchAccountCA();
      return System.schedule('Batch scheduled', sch, sc);
    }
    
    global void execute(SchedulableContext sc) {
        Batch01AccountChiffreAffaire batchAcc = new Batch01AccountChiffreAffaire();
        Id batchProcessId = Database.executeBatch(batchAcc);
    }

}