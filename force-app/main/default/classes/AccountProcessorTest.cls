@isTest
private class AccountProcessorTest {

    @isTest static void testSingleAccountWithOneContact() {  

        // CREATE ACCOUNT
        Account[] accts = TestDataFactory.createAccountsWithContacts(1, 1);

        List<Id> accountsToUpdate = new List<Id>();
        accountsToUpdate.add(accts[0].Id);
        
        Test.startTest();
        AccountProcessor.countContacts(accountsToUpdate);
        Test.stopTest();

        //VERIFY 
        Account ACC = [select Number_of_Contacts__c from Account where id = :accts[0].id LIMIT 1];
        System.assertEquals(1, ACC.Number_of_Contacts__c);
    }

    @isTest static void testSingleAccountWithMultipleContact() {  

        // CREATE ACCOUNT
        Integer numberOfContacts = 5;
        Account[] accts = TestDataFactory.createAccountsWithContacts(1, numberOfContacts);

        List<Id> accountsToUpdate = new List<Id>();
        accountsToUpdate.add(accts[0].Id);
        
        Test.startTest();
        AccountProcessor.countContacts(accountsToUpdate);
        Test.stopTest();

        //VERIFY 
        Account ACC = [select Number_of_Contacts__c from Account where id = :accts[0].id LIMIT 1];
        System.assertEquals(numberOfContacts, ACC.Number_of_Contacts__c);
    }
}