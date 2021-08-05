public class FlightCleanerTriggerHandler {
    public static final Boolean onAfterInsertIsFirstTime = true;
    
    public static void onAfterInsert (List<BatchApexErrorEvent> errorEvent) {
        if (errorEvent == null || errorEvent.isEmpty()) return;
        
        Set<Id> jobIds = new Set<Id>();
        
        for(BatchApexErrorEvent event : errorEvent) {
            jobIds.add(event.AsyncApexJobId);
        }
        
        Map<Id, AsyncApexJob> jobs = AsyncApexJobManager.getByJobIds(jobIds);
        List<Error_Log__c> log = new List<Error_Log__c>();
        
        for(BatchApexErrorEvent event : errorEvent){
            String jobName = jobs.get(event.AsyncApexJobId).ApexClass.Name;
            
            if(jobName == FlightCleanerBatch.class.getName()){
                for (String item : event.JobScope.split(',')) {
                    Error_Log__c errorLog = new Error_Log__c(
                        Error__c = event.ExceptionType,
                        Records__c = event.JobScope,
                        JobId__c = event.Id
                    );
                    
                    log.add(errorLog);
                }
            }
        }
        
        try {
            insert log;
        } catch (DmlException e) {
            System.debug('Error : ' + e.getMessage());
        } catch (Exception e){
            System.debug('Error : ' + e.getMessage());
        }
        
    }
}