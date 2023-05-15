public with sharing class AccountHelper {
    
    @AuraEnabled
    public static List<Account> getAccountList(){
        try {
            List<Account> accList = [SELECT  Id, Name, Type, Rating, Phone FROM  Account];
            system.debug('Account Details is :' + accList);
            return accList;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}