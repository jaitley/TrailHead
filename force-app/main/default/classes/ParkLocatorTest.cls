@isTest
public with sharing class ParkLocatorTest {
    @isTest
    static void testCallout() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        List<String> parksInGermany = ParkLocator.country('Germany');

        // expecting three parks in result.
        System.assertEquals(3, parksInGermany.size());
    }
}