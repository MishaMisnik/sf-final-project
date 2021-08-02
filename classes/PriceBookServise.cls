public class PriceBookServise {
 
    public static List<PricebookEntry> insertToStandardPB (List<Product2> products, PriceBook2 standardPB) {
        if (products == null || products.isEmpty() || standardPB == null) return new List<PricebookEntry>();
        
        List<PricebookEntry> entryPB = new List<PricebookEntry>();
        
        for (Product2 product : products) {
            PricebookEntry newPBEntry = new PricebookEntry(
                Pricebook2Id = standardPB.Id, 
                Product2Id = product.Id,
                UnitPrice = Constants.STANDARD_PRICE_FOR_TRIP,
                IsActive = true
            );
            
            entryPB.add(newPBEntry);
        }
        
        try { 
            upsert entryPB;
        } catch (DmlException ex) {
            System.debug('Error : ' + ex.getMessage());
        }  catch (Exception e) {
            System.debug('Error : ' + e.getMessage());
        }
        
        return entryPB;
    }
    
    public static List<PricebookEntry> insertToCustomPB (List<Product2> products, PriceBook2 customPB) {
        if (products == null || products.isEmpty() || customPB == null) return new List<PricebookEntry>();
        
        List<PricebookEntry> entryPB = new List<PricebookEntry>();
        
        for (Product2 product : products) {
            PricebookEntry newPBEntry = new PricebookEntry(
                Pricebook2Id = customPB.Id, 
                Product2Id = product.Id,
                UnitPrice = Constants.CUSTOM_PRICE_FOR_TRIP ,
                IsActive = true
            );
            
            entryPB.add(newPBEntry);
        }
        
        try { 
            upsert entryPB;
        } catch (DmlException ex) {
            System.debug('Error : ' + ex.getMessage());
        }  catch (Exception e) {
            System.debug('Error : ' + e.getMessage());
        }
        
        return entryPB;
    }
}