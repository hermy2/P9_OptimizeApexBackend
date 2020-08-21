@isTest
public class Batch01AccountChiffreAffaireTest {
    @testSetup
    public static void setup() {
        
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;
      
        Id pricebookId = Test.getStandardPricebookId();
        
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        //Create the PricebookEntry
        PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.Pricebook2Id = pricebookId;
            standardPrice.Product2Id = pd1.Id;
            standardPrice.UnitPrice = 1020;
            standardPrice.IsActive = true;
        	standardPrice.UseStandardPrice = false;
        
        Insert standardPrice;

        List<Order> tobeUpdatedOrder = new List<Order>();
        Order o1 = new Order(AccountId = acc1.Id, EffectiveDate=date.today(), Status='Draft', Pricebook2Id = pricebookId, ShipmentCost__c = 15);
        insert o1;
        System.assert(o1.AccountId == acc1.Id);

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = standardPrice.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = standardPrice.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;

		o1.Status = 'Activated';
		tobeUpdatedOrder.add(o1);
        
        Order o2 = new Order(AccountId = acc1.Id, EffectiveDate=date.today(), Status='Draft', Pricebook2Id = pricebookId);
        insert o2;
        System.assert(o2.AccountId == acc1.Id);

        OrderItem oi3 = new OrderItem (OrderId = o2.Id, PricebookEntryId = standardPrice.Id, Quantity=10, UnitPrice = 150);
        insert oi3;
        OrderItem oi4 = new OrderItem (OrderId = o2.Id, PricebookEntryId = standardPrice.Id, Quantity=20, UnitPrice = 1000);
        insert oi4;

		o2.Status = 'Activated';
		tobeUpdatedOrder.add(o2);   
        update tobeUpdatedOrder;
        
    }
    public static testmethod void test() {
        Test.startTest();
        Batch01AccountChiffreAffaire batchAccTest = new Batch01AccountChiffreAffaire();
        Id batchId = Database.executeBatch(batchAccTest);
        Test.stopTest();
    }
 
}