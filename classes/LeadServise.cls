public class LeadServise {
    private static final String EMAIL_TEMPLATE_NAME = 'Tourist Assignment';
    
    public static void sendEmail(List<Tourist__c> newTourists){
        if (newTourists == null || newTourists.isEmpty()) return; 
        
        EmailTemplate emailTemplate = leadManager.getByName(EMAIL_TEMPLATE_NAME);
        List<Messaging.SingleEmailMessage> allMsg = new List<Messaging.SingleEmailMessage>();
        
        for (Tourist__c tourist : newTourists) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.setTemplateId(emailTemplate.Id);
            mail.setToAddresses(new List<String>{tourist.Email__c});
            mail.setTargetObjectId(tourist.Contact__c);
            mail.setWhatId(tourist.Id);
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);

            allMsg.add(mail);
        }
        
        try {
        	Messaging.sendEmail(allMsg);    
        } catch (EmailException e) {
            System.debug('Error : ' + e.getMessage());
        }
    }
}