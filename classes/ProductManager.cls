public class ProductManager {
    
    public static List<Product2> getByTripId(Set<Id> tripIds) {
        if (tripIds == null || tripIds.isEmpty()) return new List<Product2>();
        
        return [
            SELECT Id, 
                   Name,
                   Trip__r.Id
            FROM Product2
            WHERE Trip__c IN :tripIds
        ];
    }

    public static List<Product2> getByIds(Set<Id> ids) {
        if (ids == null || ids.isEmpty()) return new List<Product2>();
        
        return [
            SELECT Id, 
                   Name,
                   Trip__c
            FROM Product2
            WHERE Id IN :ids
        ];
    }
}