public class TripManager {
    
    public static Map<Id, Trip__c> getByIds(Set<Id> tripIds) {
        if (tripIds == null || tripIds.isEmpty()) return new Map<Id, Trip__c>();

        return new Map<Id, Trip__c>([
            SELECT Id,
            	   Minimal_Age__c,
            	   Start_Date__c
            FROM Trip__c
            WHERE Id IN :tripIds
        ]);
    }
    
    public static Trip__c getById(String tripId) {
        if (String.isBlank(tripId)) return new Trip__c();
        
        return [
            SELECT Id,
            	   Name,
                   Seats__c,
                   Start_Date__c,
            	   Minimal_Age__c,
            	   (SELECT Status__c,
                           Tourist__c,
                           Tourist__r.Upcoming_Flight_Count__c, 
                           Tourist__r.Name, 
                           Tourist__r.LastName__c, 
                           Tourist__r.Age__c 
                    FROM Flights__r)
            FROM Trip__c
            WHERE Id = :tripId
        ];
    }
    
    public static List<Trip__c> getByTouristParams(Tourist__c tourist) {
        if (tourist == null) return new List<Trip__c>();
        
        return [
            SELECT Id,
                   Name,
                   Start_Date__c,
                   Minimal_Age__c,
                   Departure_Space_Point__c,
                   Departure_Space_Point__r.Name,
                   Departure_Space_Point__r.Country__c,
                   Departure_Space_Point__r.City__c,
                   Departure_Space_Point__r.Latitude__c,
                   Departure_Space_Point__r.Longitude__c
            FROM Trip__c
            WHERE Start_Date__c >= :Date.today() AND Remaining_Seats__c > 0 AND Minimal_Age__c <= :tourist.Age__c AND Id NOT IN (SELECT Trip__c FROM Flight__c WHERE Tourist__c = :tourist.Id AND CreatedDate >= :Date.today() AND CreatedDate <= :Date.today().addDays(1))
        ];
    }
    
    public static List<Trip__c> getListByIds (Set<Id> ids) {
        if (ids == null || ids.isEmpty()) return new List<Trip__c>();
        
        return [
            SELECT Id, 
                   Name, 
                   Start_Date__c,
                   Departure_Space_Point__r.Name,
                   Departure_Space_Point__r.Country__c,
                   Departure_Space_Point__r.City__c
            FROM Trip__c 
            WHERE Id IN :ids
        ];
    }
}