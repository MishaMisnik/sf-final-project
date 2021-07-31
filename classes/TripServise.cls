public class TripServise {
    
    public static Boolean createFlightsOfferPending(List<Tourist__c> tourists, Trip__c trip) {
        if (tourists == null || tourists.isEmpty() ||  trip == null) return false;
        
        Boolean isComplete = true;
        List<Flight__c> flights = new List<Flight__c>();
        
        for (Tourist__c tourist : tourists) {
            Flight__c newFlight = new Flight__c(
                Status__c = 'Offer Pending',
                Tourist__c = tourist.Id,
                Trip__c = trip.Id
            );
            flights.add(newFlight);
        }
        
        try{
            insert flights;
        } catch(DmlException e) {
            isComplete = false;
            System.debug('Error : ' + e.getMessage());
        }
        
        return isComplete;
    }  
    
    public static Boolean createFlightRequested(String touristId, String tripId) {
        if (String.isBlank(touristId)  ||  String.isBlank(tripId)) return false;
        
        Boolean isComplete = true;
        Flight__c flight = new Flight__c(
            Status__c = 'Requested',
            Tourist__c = touristId,
            Trip__c = tripId
        );
        
        try {
            insert flight;
        } catch(DmlException e) {
            isComplete = false;
            System.debug('Error : ' + e.getMessage());
        }
        
        return isComplete;
    }
    
    public static Set<Id> getIds(List<Trip__c > trips) {
        if (trips == null || trips.isEmpty()) return new Set<Id>();
        
        Set<Id> ids = new Set<Id>();
        
        for (Trip__c trip : trips) {
            ids.add(trip.Id);
        }
        
        return ids;
    }
    
    public static List<Trip__c> getPriceFromPriceBook (List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) return new List<Trip__c>();
        
        List<Trip__c> result = new List<Trip__c>();
        Pricebook2 pricebook = PriceBookManager.getCustomByName('Trips');
        List<Product2> products = ProductManager.getByTripId(TripServise.getIds(trips));
        List<PricebookEntry> entryPB = PriceBookManager.getBriceBookEntryByProductAndPricebook2(products, pricebook);
        Map<Id, Decimal> priceForProduct = new Map<Id, Decimal>();
        
        for (PricebookEntry record : entryPB) {
            for (Product2 product : products ) {
                if (record.Product2Id == product.Id) {
                    priceForProduct.put(product.Trip__c, record.UnitPrice);
                }
            }
        }
        
        for (Id tripId : priceForProduct.keySet()) {
            for (Trip__c trip : trips) {
                if (tripId == trip.Id) {
                    trip.Price__c = priceForProduct.get(tripId);
                    result.add(trip);
                }       
            }
        }
        
        return result;
    }
}