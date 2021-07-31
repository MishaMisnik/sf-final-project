trigger TripTrigger on Trip__c (after insert, before delete) {

    switch on Trigger.operationType {
        when AFTER_INSERT {
            if (TripTriggerHandler.onAfterInsertIsFirstTime) {
                TripTriggerHandler.onAfterInsert(Trigger.new);
                TripTriggerHandler.onAfterInsertIsFirstTime = false;
            }
        }
        
        when BEFORE_DELETE {
            if (TripTriggerHandler.onBeforeDeleteIsFirstTime) {
                TripTriggerHandler.onBeforeDelete(Trigger.old);
                TripTriggerHandler.onBeforeDeleteIsFirstTime = false;
            }
        }
    }
}