public with sharing class LWCExampleController {
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContacts(){
        return [SELECT Id, Name, FirstName,LastName, Phone, Email FROM Contact limit 20];
    }
}