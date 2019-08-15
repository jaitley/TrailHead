global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
    
        List<Lead> leads = new List<Lead>();

        for (Lead lead : [SELECT Id, Name, LeadSource FROM Lead WHERE LeadSource !='' LIMIT 200]) {
            lead.LeadSource = 'Dreamforce';
            leads.add(lead);
        }

        update leads;
    }
    
}
