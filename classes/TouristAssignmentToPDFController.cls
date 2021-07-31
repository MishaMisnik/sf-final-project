public class TouristAssignmentToPDFController {
    
    @AuraEnabled(cacheable = true)
    public static List<Trip__c> getTripsWithPrice(List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) return new List<Trip__c>();
              
        return TripServise.getPriceFromPriceBook(trips);
    }
}