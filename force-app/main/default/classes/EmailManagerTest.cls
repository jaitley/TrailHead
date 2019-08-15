@isTest
private class EmailManagerTest {

    @isTest static void testPositive() {       
        // BAD TEST : Must have ASSERTION

        Boolean caughtException = false;

        try 
        {
            EmailManager.sendMail('djaitley@gmail.com', 'Salesforce Unit Test', 'testPositive()');              
        }
        catch(System.EmailException ex)
        {
            caughtException = true;
        } 

        System.assert(!caughtException, 'Expecting no exceptions');      
    }
   
   @isTest static void testEmailFailure() {       
        // mock email wil fail result
    }

    @isTest static void testException() 
    {      
        Boolean caughtException = false;

        try 
        {
            EmailManager.sendMail('xxx', 'Salesforce Unit Test', 'testNegative()');        
        }
        catch(System.EmailException ex)
        {
            caughtException = true;
        } 

        System.assert(caughtException, 'Caught EmailException.');
    }
    
    
      
}