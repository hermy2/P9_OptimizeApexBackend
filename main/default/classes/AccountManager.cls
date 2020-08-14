public class AccountManager {
    
    public static void updateCA(Set<Id> sAccounts){
        
        AggregateResult[] groupedResults = [SELECT AccountId, SUM(TotalAmount)amt FROM Order WHERE AccountId In : sAccounts  AND Status = 'Activated' GROUP BY AccountId];
        System.debug('##### QUERY groupedResults: ' +groupedResults);
        
        List<Account> toBeUpdateAccount = new List<Account>();
       
        for(AggregateResult Results: groupedResults) {
            Account acc = new Account();
            acc.Id = (id) Results.get('AccountId');
            acc.Chiffre_d_affaire__c = (Decimal)Results.get('amt');
            toBeUpdateAccount.add(acc);
        }
        update toBeUpdateAccount;
    }
}