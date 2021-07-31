public class PriceBookManager {
    
    public static PriceBook2 getStandart () {
        return [
            SELECT Id, Name
            FROM PriceBook2  
            WHERE isStandard = true
        ];
    }
    
    public static PriceBook2 getCustomByName (String name) {
        if (String.isBlank(name)) return new PriceBook2();
        
        return [
            SELECT Id, Name
            FROM PriceBook2  
            WHERE Name = :name
        ];
    }
    
    public static List<PricebookEntry> getBriceBookEntryByProductAndPricebook2 (List<Product2> products, Pricebook2 pricebook) {
        if (products == null || products.isEmpty() || pricebook == null) return new List<PricebookEntry>(); 
        
        return [
            SELECT Id, 
                   Product2Id, 
                   Pricebook2Id, 
                   UnitPrice 
            FROM PricebookEntry
            WHERE Product2Id IN :products AND Pricebook2Id = :pricebook.Id
        ];
    }
}