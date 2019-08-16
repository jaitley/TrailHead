// REF: https://trailhead.salesforce.com/content/learn/modules/apex_integration_services/apex_integration_rest_callouts
public class AnimalLocator {
    
    public static String getAnimalNameById(Integer Id) {
        
        String animalName = '';

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            // Cast the values in the 'animal' key as a Map
            Map<String, Object> animalInfo = (Map<String, Object>)  results.get('animal');
            
            animalName = (String) animalInfo.get('name');
            System.debug('Received animal:' + animalName);
           
        }

        return animalName;
    }
}
