public with sharing class AccountController {
    
    @AuraEnabled
      public static List<Contact> getAllActiveAccounts(){
        try {
          return [SELECT Id,Name, Phone FROM Contact LIMIT 10 ];
        } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
        }
      }
}