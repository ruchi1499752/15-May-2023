public with sharing class ContactController1 {
    public ContactController1() {

    }
    @AuraEnabled
    public static List<Contact> contactList(){
        try {
            List<Contact> conList = [SELECT LastName, Email, Account.Name FROM Contact LIMIT 10];
            return conList;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}