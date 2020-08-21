trigger AccountTrigger on Order (after insert, after update, before delete){
    if(Trigger.isAfter){
        AccountManager.updateCA(Trigger.new,Trigger.oldMap);
    } else if(Trigger.isBefore){
        if(Trigger.isDelete){
            AccountManager.updateCA(Trigger.old,null);
        }        
    }
}