public with sharing class MultiSelectComboboxController {
    @AuraEnabled
    public static List<SObject> fetchRecord(String qry){
        try {
            System.debug('Query is :'+ qry);
            return Database.query(qry);
           // List<Account> accList = [SELECT ID,Name FROM Account ];
            //return accList;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<sObject> searchData(String chr){
        try {
            String temp = chr + '%';
            String qry = 'SELECT Id, Name FROM Account WHERE Name LIKE \'' + chr + '%\'' ;
            
            System.debug('Query is :' + qry);
            List<sObject> sobjList = Database.query(qry);
            return sobjList;
            // List<Account> accList = [SELECT ID,Name FROM Account WHERE Name LIKE '%' LIMIT 5];
            // return accList;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}