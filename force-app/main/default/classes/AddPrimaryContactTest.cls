// REF: https://trailhead.salesforce.com/content/learn/modules/asynchronous_apex/async_apex_queueable
@isTest
private class AddPrimaryContactTest {

    private static List<Account> getAccountWithState(Integer numRecords, String billingState) {
        // FACTORY METHOD FOR ACCOUNTS
        List<Account> accounts = new List<Account>();

        for (Integer i = 0; i < numRecords; i++) {
            accounts.add(new Account(
                Name = 'Test Account #' + i,
                BillingState = billingState
            ));
        }
        return accounts;
    }

    @testSetup static void setup() {
        // insert 50 Account records for BillingState "NY" and 50 Account records for BillingState "CA". 
        List<Account> accountsNY = getAccountWithState(50, 'NY');
        insert accountsNY;

        List<Account> accountsCA = getAccountWithState(50, 'CA');        
        insert accountsCA;
    }


    @isTest static void testAccountWithContactsforCA() {    
     
        Contact testContact = new Contact(LastName = 'LastName Test');
        AddPrimaryContact accountUpdator = new AddPrimaryContact(testContact, 'CA');

        Test.startTest();        
        Id batchId = System.enqueueJob(accountUpdator);
        Test.stopTest();
        
        // GET CA ACCOUNTS
        List<Account> accts = [select 
                                    Id, Name, BillingState,(Select Id, Name from Contacts)
                                from 
                                    Account
                                where BillingState = 'CA'];


        System.assertEquals(50, accts.size());

        // CHECK ACCOUNTS HAVE ONE CONTACT
        for (Account acct : [select 
                                Id, Name, BillingState,(Select Id, Name from Contacts)
                            from 
                                Account
                            where BillingState = 'CA']
            ) 
        {            
            System.assertEquals(1, acct.Contacts.size());
        }

    }    
      
}