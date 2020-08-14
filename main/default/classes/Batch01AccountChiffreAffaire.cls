global class Batch01AccountChiffreAffaire implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        
        return Database.getQueryLocator('SELECT Id,Chiffre_d_affaire__c,(SELECT Id,TotalAmount FROM Orders WHERE Status = \'Activated\') FROM Account');
        //return Database.getQueryLocator('SELECT AccountId FROM Order WHERE Status = \'Activated\'');
        //return Database.getQueryLocator([SELECT AccountId, SUM(TotalAmount)amt FROM Order WHERE Status = 'Activated' GROUP BY AccountId]);
    }
   
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        Set<Id> accountToUpdate = new Set<Id>();
        
        for(Account acc : scope){
            accountToUpdate.add(acc.id);
        }
        
        AccountManager.updateCA(accountToUpdate);
    }
	
    global void finish(Database.BatchableContext info){     
       
   } 
}