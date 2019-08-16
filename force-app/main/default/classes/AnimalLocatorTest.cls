// REF: https://trailhead.salesforce.com/content/learn/modules/apex_integration_services/apex_integration_rest_callouts
@isTest
public class AnimalLocatorTest {

        @isTest static  void testGetCallout() {
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 

        // Call method to test
        String result = AnimalLocator.getAnimalNameById(1);
        
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');

        System.assertEquals('bear',result, 'Expecting animal to be a bear');
    }   

}
