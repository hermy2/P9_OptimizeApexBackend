trigger UpdateAccountCA on Order (after update, before delete) {
	
    Map<Id, Decimal> mAccAmount = new Map<Id, Decimal>();
    
    if(Trigger.isUpdate) {
        //Iterate through each Order 
        for(Order o : Trigger.new) {
            Decimal totalAmount = o.TotalAmount == null ? 0 : o.TotalAmount;
            if(mAccAmount.containskey(o.accountid)) {
              Decimal d = mAccAmount.get( o.AccountId );
              System.debug('Decimal value ' +d);
              d += totalAmount;
              mAccAmount.put( o.AccountId, d );  
                
            } else {
                mAccAmount.put( o.AccountId, totalAmount );
    
            }
        }
    }  
    
    else if(Trigger.isDelete) {
        for(Order o2 : Trigger.old) {
           Decimal newTotalAmount = o2.TotalAmount != null ? 0 : o2.TotalAmount; 
            if(mAccAmount.containsKey(o2.AccountId)) {
                Decimal dc = mAccAmount.get(o2.AccountId);
                System.debug('New Value after Delete ' +dc);
                dc -= newTotalAmount;
            }
        }  
    }
        
    //List<Account> lAccs = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :mAccAmount.keySet()];
	List<Account> lAccs = new List<Account>();
    Map<Id, Account> acct = new Map<Id, Account> ([SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :mAccAmount.keySet()]);
    System.debug('Account Keyset: ' +mAccAmount);
    
    AggregateResult[] groupedResults = [SELECT AccountId, SUM(TotalAmount)amt FROM Order WHERE AccountId in :mAccAmount.keySet() GROUP BY AccountId];
    
    
    for(AggregateResult Results: groupedResults) {
        Id accountId = (id) Results.get('AccountId');
        Account a = acct.get(accountId);
        a.Chiffre_d_affaire__c = (Decimal)Results.get('amt');
        lAccs.add(a);
    }
    
    //Iterate through each List of Accounts 
    if(lAccs.size()>0) {
    	for(Account acc : lAccs){
        	Decimal ca = acc.Chiffre_d_affaire__c == null ? 0 : acc.Chiffre_d_affaire__c;
            System.debug('acc ' +acc);
            if(mAccAmount.get(acc.Id)!=null) {
            	acc.Chiffre_d_affaire__c = ca + mAccAmount.get(acc.Id);  
            }
        }
    }
    
    update lAccs;
    
}