public with sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> acctIds) {    
        
        List<Account> accountsToUpdate = new List<Account>();

        for (Account account :  [Select Id, Number_of_Contacts__c, (select Id from Contacts) from Account Where Id IN :acctIds]) {            
            account.Number_of_Contacts__c = account.contacts.size();            
            accountsToUpdate.add(account);
        }
        
        update accountsToUpdate;
  }
}