public without sharing class MyTeamOrdersController {
    
    public Account currentRecord{get; set;}
    public Map<String,Decimal> displayMap{get;set;}
    public Decimal total{get;set;}
    
    //Extensions method to use custom controller on Account page layout
    public MyTeamOrdersController(ApexPages.StandardController controller) {
       
        currentRecord = [SELECT Id, Name,(SELECT ID,Status,OwnerId,Owner.Name,TotalAmount FROM Orders WHERE Status = 'Activated') FROM Account WHERE Id =:ApexPages.currentPage().getParameters().get('id')];
        total = 0;
        
        if(currentRecord.Orders.size() > 0){
            
            displayMap = new Map<String,Decimal>();
            for(Order ord : currentRecord.Orders){
                if(displayMap.containsKey(ord.Owner.Name)){
                    Decimal totalCount = ord.TotalAmount + displayMap.get(ord.Owner.Name);
                    displayMap.put(ord.Owner.Name, totalCount);
                } else {
                    displayMap.put(ord.Owner.Name, ord.TotalAmount);
                }
                total += ord.TotalAmount;
            }
        }
    }
    
}