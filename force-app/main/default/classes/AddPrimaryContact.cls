public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state;
    
    public AddPrimaryContact(Contact contact, String stateAbbr) {
        this.contact = contact;
        this.state = stateAbbr;
    }

    public void execute(QueueableContext context) {

        List<Contact> listContacts = new List<Contact>();

        for (Account account : [select 
                                    Id, Name, BillingState 
                                from 
                                    Account 
                                where BillingState = :this.state
                                LIMIT 200]
            ) 
        {
          Contact cont = this.contact.clone(false, false, false, false);
          cont.AccountId = account.Id;
          listContacts.add(cont);
        }

        if (listContacts.size() > 0) {
            insert listContacts;
        }        
    }
    
}
