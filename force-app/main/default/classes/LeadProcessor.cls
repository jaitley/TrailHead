global class LeadProcessor implements Database.Batchable<sObject> 
{
    // ---------- START ----------
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT ID, Name, LeadSource FROM Lead');
    }

    // ---------- EXECUTE ----------
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        
        List<Lead> leads = new List<Lead>();

        for (Lead lead : scope) {
                lead.LeadSource = 'Dreamforce';                
                leads.add(lead);           
        }

        update leads;
    }    

    // ---------- FINISH ----------
    global void finish(Database.BatchableContext bc){
        // cleanup if needed.
    }    
}