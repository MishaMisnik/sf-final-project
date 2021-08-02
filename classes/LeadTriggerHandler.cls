public class LeadTriggerHandler {
    public static Boolean onBeforeUpdateIsFirstTime = true;
    
    public static void onBeforeUpdate(List<Lead> leads) {
        if (leads == null || leads.isEmpty()) return;
        
        List<Tourist__c> newTourists = new List<Tourist__c>();
        
        for (Lead lead : leads) {
            if (lead.IsConverted && String.isNotEmpty(lead.FirstName) &&  String.isNotEmpty(lead.Email)) {
                Tourist__c tourist = new Tourist__c(
                	Name = lead.FirstName,
                    LastName__c = lead.LastName,
                    Email__c = lead.Email,
                    Birthdate__c = lead.Birthdate__c,
                    Contact__c = lead.ConvertedContactId
                );
                newTourists.add(tourist);
            }
        }
        
        try {
            insert newTourists;
            LeadServise.sendEmail(newTourists);
        } catch (DmlException e) {
            System.debug('Error' + e.getMessage());
        }  catch (Exception e) {
            System.debug('Error : ' + e.getMessage());
        }
    }
}