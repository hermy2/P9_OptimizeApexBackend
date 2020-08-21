global class Batch01AccountChiffreAffaire implements Schedulable, Database.Batchable<sObject> {

	global void execute(SchedulableContext sc) {
    	Id batchProcessId = Database.executeBatch(this);
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator('SELECT Id,Chiffre_d_affaire__c,(SELECT Id,TotalAmount FROM Orders WHERE Status = \'Activated\') FROM Account');  
    }
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        System.debug(scope.size());
        for(Account acc : scope){
            List<Order> lstOrder = new List<Order>();
            lstOrder = acc.Orders;
            if(lstOrder.size() > 0){
                Decimal total = 0;
                for(Order ord : lstOrder){
                    total += ord.TotalAmount;
                }
                acc.Chiffre_d_affaire__c = total;
            } else {
                acc.Chiffre_d_affaire__c = 0;
            }
        }
        update scope;
    }
	
   global void finish(Database.BatchableContext info){         
   } 
}