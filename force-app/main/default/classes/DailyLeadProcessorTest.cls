// REF: https://trailhead.salesforce.com/content/learn/modules/asynchronous_apex/async_apex_scheduled
@isTest
private class DailyLeadProcessorTest {
    
    // Dummy CRON expression: midnight on Aug 19.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 19 8 ? 2022';

    private static List<Lead> getLeads(Integer numRecords) {
        List<Lead> leads = new List<Lead>();

        for (Integer i = 0; i < numRecords; i++) {
            leads.add(new Lead(
                Company = 'Test Company',
                LastName = 'Test Lead #' + i,
                Status = 'Open'
            ));
        }
        return leads;
    }

    @isTest static void testLeadSourceUpdated() {         
        
        // insert 200 Lead records
        List<Lead> leads = getLeads(200);
        insert leads;  

        // Get the IDs of the leads just inserted
        Map<Id, Lead> leadMap = new Map<Id, Lead>(leads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());

        Test.startTest();
        
        // Schedule the test job
        String jobId = System.schedule(
                                    'LeadUpdateStatusDreamforce',
                                    CRON_EXP, 
                                    new DailyLeadProcessor()
                                    );        
                                     
        // Verify the scheduled job has not run yet.
        List<Task> lt = [SELECT Id 
            FROM Task 
            WHERE WhatId IN :leadIds];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
        // Stopping the test will run the job synchronously
        Test.stopTest();
        
               // Verify that Lead's Staus changed to 'Dreamforce';
        System.assertEquals(200, 
                            [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce'],
                            'Lead\'s Status not updated to Dreamforce');

    }    
      
}

