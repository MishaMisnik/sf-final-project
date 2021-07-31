public class TripTriggerHandler {
    public static Boolean onAfterInsertIsFirstTime = true;
    public static Boolean onBeforeDeleteIsFirstTime = true;
    
    public static void onAfterInsert(List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) return;
        
        List<Product2> products = ProductServise.insertProducts(trips);
        
        PriceBookServise.insertToStandardPB(products, PriceBookManager.getStandart());
        PriceBookServise.insertToCustomPB(products, PriceBookManager.getCustomByName(Constants.TRIP_PRICE_BOOK));
    }
    
    public static void onBeforeDelete(List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) return;
        
        try {
            delete ProductManager.getByTripId(TripServise.getIds(trips));
        } catch (DmlException ex) {
            System.debug('Error : ' + ex.getMessage());
        }
    }
}