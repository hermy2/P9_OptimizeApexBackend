public with sharing class SearchOpportunityController {

    @AuraEnabled
 	public static List <Opportunity> getOppty(String searchOppty, Id accountId) {
        String searchKey = '%' + searchOppty + '%';
 		List <Opportunity> oppties = new List <Opportunity>();
  		List <Opportunity> lstOfOppty = [SELECT Id, Name, StageName, Amount, CloseDate FROM Opportunity
                                   		 WHERE Name LIKE: searchKey AND AccountId = :accountId];
       
  		return lstOfOppty;
 	}
}    
	
    
       
    
    /*
	@AuraEnabled
 	public static List <Opportunity> getOppty(String searchOppty, Account a) {
  		String accId = a.Id;
        String searchKey = searchOppty + '%';
 		List <Opportunity> oppties = new List <Opportunity>();
  		List <Opportunity> lstOfOppty = [SELECT Id, Name, StageName, Amount, CloseDate FROM Opportunity
                                   		 WHERE Name LIKE: searchKey AND AccountId = :accId];
 		System.debug('lstOfOppty' +lstOfOppty);
        
  		for (Opportunity opp: lstOfOppty) {
   			oppties.add(opp);
            System.debug('oppties' +oppties);
  		}
  		return oppties;
 	}
	*/
    

/*
 @AuraEnabled
	public static List<Opportunity> getOppty(String searchOppty){
   	List<Opportunity> oppties = new List<Opportunity>();

	string query = 'SELECT Id,Name,StageName,Amount,CloseDate FROM Opportunity';
	System.debug('### Account Opportunities - '+query);
	//oppties = Database.query(query);

	return oppties;

-----------------------------------
-----------------------------------

@AuraEnabled
 	public static List <Opportunity> getOppty(String searchOppty) {
  		String searchKey = searchOppty + '%';
 		List <Opportunity> oppties = new List <Opportunity>();
  		List <Opportunity> lstOfOppty = [SELECT Id, Name, StageName, Amount, CloseDate FROM Opportunity
                                   		 WHERE Name LIKE: searchKey LIMIT 10];
 		System.debug('lstOfOppty' +lstOfOppty);
        
  		for (Opportunity opp: lstOfOppty) {
   			oppties.add(opp);
            System.debug('oppties' +oppties);
  		}
  		return oppties;
 	}
}    

 */