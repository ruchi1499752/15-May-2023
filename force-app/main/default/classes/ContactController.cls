public class ContactController {
	// @AuraEnabled
    // public List<Contact> getContacts(){
    //     List<Contact> contacts =[SELECT Id, Name, MailingStreet, Phone, Email, LeadSource FROM Contact];
    //     return contacts;
    // }
    @AuraEnabled
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, FirstName, LastName, Phone, Email 
                FROM Contact 
                WHERE Email != null
                AND Phone != null
                ORDER BY CreatedDate limit 20];
    }
}