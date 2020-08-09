@isTest
public class UpdateAccountCATest {
    
    @isTest static void test() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;
        
        //Pricebook2 pb = new Pricebook2(Name = 'Standard Price Book', Description = 'Price Book Products', IsActive = true);
        //insert pb;
        
        Pricebook2 pb = [SELECT Id, name, isActive from Pricebook2 WHERE isStandard=true];
      
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        //Create the PricebookEntry
        PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.Pricebook2Id = pb.Id;
            standardPrice.Product2Id = pd1.Id;
            standardPrice.UnitPrice = 1020;
            standardPrice.IsActive = true;
        	standardPrice.UseStandardPrice = false;
        
        Insert standardPrice;

        Order o1 = new Order(AccountId = acc1.Id, EffectiveDate=date.today(), Status='Draft');
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = standardPrice.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = standardPrice.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;        
    }
 
}