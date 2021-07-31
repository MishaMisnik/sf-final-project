global class LeadFromEmail implements Messaging.InboundEmailHandler{
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        List<String> emailBody = email.plainTextBody.split('\n');
        
        Lead newLead = new Lead(
            FirstName = emailBody[2].substringAfter('First Name: '),
            LastName = emailBody[3].substringAfter('Last Name: '),
            Email = emailBody[4].substringAfter('Email Address: '),
            Company = emailBody[5].substringAfter('Company Name: '),
            Birthdate__c = Date.parse(emailBody[6].substringAfter('Birthdate: ')) 
        );
        
        try {
            insert newLead;
        } catch (DmlException ex) {
            System.debug('Error: ' + ex.getMessage());
        }
        
        return result;
    }
}