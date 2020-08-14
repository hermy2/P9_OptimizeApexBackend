trigger AccountTrigger on Order (after update, after delete){
    
    Set<Id> sAccountIdsToUpdateCA = new Set<Id>();
    
        if(Trigger.isAfter && Trigger.isUpdate){
            for(Order o : Trigger.new) {
            	sAccountIdsToUpdateCA.add(o.AccountId);    
        	}
        }    
        else if(Trigger.isAfter && Trigger.isDelete){
            for(Order o : Trigger.old) {
                 sAccountIdsToUpdateCA.add(o.AccountId);   
            }
        }

    if(sAccountIdsToUpdateCA.size() > 0) AccountManager.updateCA(sAccountIdsToUpdateCA);
}