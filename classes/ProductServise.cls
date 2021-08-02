public class ProductServise {

    public static List<Product2> insertProducts (List<Trip__c> trips) {
        if (trips == null || trips.isEmpty()) return new List<Product2>(); 
        
        List<Product2> products = new List<Product2>();
        
        for (Trip__c trip : trips) {
            Product2 product = new Product2(
                Name = trip.Name,
                isActive = true,
                Trip__c = trip.Id
            );
            
            products.add(product);
        }
        
        try {
            insert products;            
        } catch (DmlException e) {
            System.debug('Error : ' + e.getMessage());
        }  catch (Exception e) {
            System.debug('Error : ' + e.getMessage());
        }
        
        return products;
    }
}