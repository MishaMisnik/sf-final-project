public inherited sharing class TouristAssignmentController {
    
    @AuraEnabled(cacheable = true)
    public static List<Trip__c> getTrips(Tourist__c tourist) {
        if (tourist == null) return new List<Trip__c>();
        
        return TripManager.getByTouristParams(tourist);
    }
    
    @AuraEnabled
    public static Boolean createFlgiht(String touristId, String tripId) {
        if (String.isBlank(touristId)  ||  String.isBlank(tripId)) return false;
        
        return TripServise.createFlightRequested(touristId, tripId);
    }

    @AuraEnabled(cacheable = true)
    public static String getConstantRegistration() {
        return Constants.COMMUNITY_TOURIST_REGISTRATION_URL;
    }
    
    
    @AuraEnabled(cacheable = true)
    public static String getConstantPriceList() {
        return Constants.COMMUNITY_TOURIST_PRICELIST_URL;
    }
}