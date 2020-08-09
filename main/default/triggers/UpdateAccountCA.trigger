trigger UpdateAccountCA on Order (after update) {
	
    Map<Id, Decimal> mAccAmount = new Map<Id, Decimal>();
    
    //Iterate through each Order 
    for(Order o : Trigger.new) {
        if(mAccAmount.containskey(o.accountid)) {
          Decimal d = mAccAmount.get( o.AccountId );
          System.debug('Decimal value ' +d);
          d += o.TotalAmount;

          mAccAmount.put( o.AccountId, d );  
            
        } else {
            mAccAmount.put( o.AccountId, o.TotalAmount );

        }
        
    }
    List<Account> lAccs = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :mAccAmount.keySet()];
	System.debug('Account Keyset: ' +mAccAmount.keySet());
    //Iterate through each List of Accounts 
   	
    if(lAccs.size()>0) {
        for(Account acc : lAccs){
            acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + mAccAmount.get(acc.Id);  
        }
    }
    update lAccs;  
}