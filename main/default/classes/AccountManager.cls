public class AccountManager {
    
    public static void updateCA(List<Order> newList, Map<Id,Order> oldMap){
        
        Set<Id> accIds = new Set<Id>();
        
        for(Order ord : newList){
            if(Trigger.isInsert || Trigger.isDelete){
                if(ord.AccountId != null) accIds.add(ord.AccountId);
            } else if(Trigger.isUpdate){
                Order oldOrder = oldMap.get(ord.Id);
                if(ord.Status != oldOrder.Status){
                    if(ord.AccountId != null) accIds.add(ord.AccountId);
                }
            }    
        }
        
        List<Account> lstAccount = new List<Account>([SELECT Id,Name,Chiffre_d_affaire__c,(SELECT Id,TotalAmount FROM Orders WHERE Status = 'Activated') FROM Account WHERE Id In : accIds]);
        if(lstAccount.size() > 0){
            for(Account acc : lstAccount){
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
            update lstAccount;
        }
    }
}