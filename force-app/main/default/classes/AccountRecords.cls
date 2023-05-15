public with sharing class AccountRecords {
   
    @AuraEnabled
    public static List<Account> AccountData(){
        try {
            list<Account> accList = [SELECT Id, Name From Account];
            System.debug('Account List :' + accList);
            System.debug('Account Size :' + accList.size());
            return accList;

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}