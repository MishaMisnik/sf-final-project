public class FlightManager {
    
    public static List<Flight__c> getByStartDateAndTouristId(List<Tourist__c> tourists) {
        if (tourists == null || tourists.isEmpty()) return new List<Flight__c>();
        
        Set<Id> touristsId = TouristManager.getIds(tourists);
        
        return [
            SELECT id
            FROM Flight__c
            WHERE (Tourist__c IN :touristsId AND Trip__r.Start_Date__c > :date.today())
        ];
    }
}