public with sharing class AccountController {
    
    @AuraEnabled
      public static List<Contact> getAllActiveAccounts(){
        try {
          System.debug('hfjkrg');
          return [SELECT Id,Name, Phone FROM Contact LIMIT 10 ];
        } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
        }
      }
}