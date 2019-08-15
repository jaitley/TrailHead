@isTest
private class LeadProcessorTest {

    @isTest static void testLeadSourceDreamforce() {    

        final Integer numLeads = 200;

        TestDataFactory.createLeads(numLeads);   
        
        Test.startTest();
        LeadProcessor leadProc = new LeadProcessor();
        Id batchId = Database.executeBatch(leadProc);
        Test.stopTest();
        
        System.assertEquals(numLeads, [select count() from Lead where LeadSource = 'Dreamforce']);

    }    
      
}
