trigger FlightCleanerTrigger on BatchApexErrorEvent (after insert) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            if (FlightCleanerTriggerHandler.onAfterInsertIsFirstTime) {
                FlightCleanerTriggerHandler.onAfterInsert(Trigger.new);
                FlightCleanerTriggerHandler.onAfterInsertIsFirstTime = false;
            }
        }
    }
}