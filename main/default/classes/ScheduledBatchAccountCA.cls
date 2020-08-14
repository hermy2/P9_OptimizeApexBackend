global class ScheduledBatchAccountCA implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Batch01AccountChiffreAffaire batchAcc = new Batch01AccountChiffreAffaire();
        Database.executeBatch(batchAcc);
    }

}