public inherited sharing class TouristRegistrationController {
    
    @AuraEnabled
    public static Tourist__c createNewTourist(String firstName, String lastName, String email, Date birthday) {
        if (String.isBlank(firstName) || String.isBlank(lastName) || String.isBlank(email) || birthday == null) return new Tourist__c();
        
        Tourist__c result = new Tourist__c();
        Tourist__c tourist = new Tourist__c(
            Name = firstName,
            LastName__c = lastName,
            Email__c = email,
            Birthdate__c = birthday
        );

        try {
            insert tourist;
            result = tourist;
        } catch (Dmlexception ex) {
            System.debug('Error : ' + ex.getMessage());
        }

        return result;
    }

    @AuraEnabled
    public static Constants getAllConstants() {
        return new Constants();
    }
}