@isTest
public class TestDataFactory {

    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;
        
        return accts;
    }

    public static List<Account> createAccountsWithContacts(Integer numAccts, Integer numContactsPerAcct) {
        
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        
        List<Contact> contacts = new List<Contact>();

        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numContactsPerAcct;k++) {
                
                contacts.add(new Contact(
                                        FirstName = 'First ' + k
                                        ,LastName = 'Last ' + k
                                        ,AccountId = acct.Id
                                        ));
            }
        }
        // Insert all opportunities for all accounts.
        insert contacts;
        
        return accts;
    }

    public static List<Lead> createLeads(Integer numLeads) {
        
        List<Lead> leads = new List<Lead>();
        
        for(Integer i=0;i<numLeads;i++) {
            Lead a = new Lead(
                FirstName ='Test Lead-' + i,
                LastName = 'Last Test',
                Company = 'Test Company',
                LeadSource = 'TestFactory'
                );
            leads.add(a);
        }
        insert leads;
        
        return leads;
    }
}