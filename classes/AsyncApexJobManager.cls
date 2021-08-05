public class AsyncApexJobManager {
    
    public static Map<Id, AsyncApexJob> getByJobIds (Set<Id> jobIds) {
        if (jobIds == null || jobIds.isEmpty()) return new Map<Id, AsyncApexJob>();
        
        return new Map<Id, AsyncApexJob> ([
            SELECT Id,
                   ApexClass.Name
            FROM AsyncApexJob
            WHERE Id IN :jobIds
        ]);
    }

}