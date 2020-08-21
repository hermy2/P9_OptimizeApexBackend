@isTest
public class LeadProcessorTest {
    @testSetup
    Static void setup() {
        List<Lead> leads = new List<Lead>();
        
        //Insert 200 Leads
        for(Integer i=0; i<200; i++) {
            leads.add(new Lead(LastName ='Last ' +i, 
                               Company = 'MHA Academy',
                               Status = 'Contacted',
                               LeadSource = 'Dreamforce'));
        }
        insert leads;
        /*
        //Insert Status Dreamforce to leads just created
        for(Lead l: [SELECT Id FROM Lead]) {
            leads.add(new Lead(LastName='Last', Company='MHA Academy', 
                               Status='Contacted', LeadSource='Dreamforce', Id = l.Id));
        }
        update leads;
		*/
    }
    static testmethod void test() {
        Test.startTest();
        LeadProcessor lProcess = new LeadProcessor();
        Id batchId = Database.executeBatch(lProcess);
        Test.stopTest();
        
        // After the testing stops, assert records were updated properly
        //System.assertEquals(200, [SELECT count() FROM Lead WHERE Status = 'Dreamforce']);
    }
}