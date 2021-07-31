trigger LeadTrigger on Lead (before update) {
    
    switch on Trigger.operationType {
        when BEFORE_UPDATE {
            if (LeadTriggerHandler.onBeforeUpdateIsFirstTime) {
                LeadTriggerHandler.onBeforeUpdate(Trigger.new);
                LeadTriggerHandler.onBeforeUpdateIsFirstTime = false;
            }
        }
    }
}