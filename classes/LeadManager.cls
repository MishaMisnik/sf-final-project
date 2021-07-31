public class LeadManager {

    public static EmailTemplate getByName(String name) {
        if (String.isBlank(name)) return new EmailTemplate();
        
        return [
            SELECT Id,
                   Name
            FROM EmailTemplate
            WHERE Name = :name
        ];
    }
}