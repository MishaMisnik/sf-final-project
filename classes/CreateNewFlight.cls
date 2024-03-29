public class CreateNewFlight {
    
    @InvocableMethod
    public static void createNewFlight(List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) return;
        
        List<Flight__c> flights = new List<Flight__c>();
        List<Tourist__c> selectedTourists = TouristManager.getWithoutFlightsAndAppropriateAge(trips);
        
        for (Trip__c trip : trips) {
            for (Tourist__c tourist : selectedTourists) {
                Flight__c flight = new Flight__c(
                    Tourist__c = tourist.id,
                  	Trip__c = trip.id
                );

                flights.add(flight);
            }
        }
        
        try {
            insert flights;
        } catch (DmlException e) {
            System.debug('Error : ' + e.getMessage());
        } catch (Exception e) {
            System.debug('Error : ' + e.getMessage());
        }
    }
}