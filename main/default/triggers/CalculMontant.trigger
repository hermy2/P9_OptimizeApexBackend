trigger CalculMontant on Order (before update) {

//Iterates over all records 
    for(Order o: Trigger.New) {
        if(o.TotalAmount != null && o.ShipmentCost__c != null) {
        	o.NetAmount__c = o.TotalAmount - o.ShipmentCost__c;    
        }  
    }
}

       
    /*
     * The following trigger assumes that only one record caused the trigger to fire...
     * 
       Order newOrder= trigger.new[0];
	   newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;

     */