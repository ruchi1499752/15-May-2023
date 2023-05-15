public with sharing class serverSideApexController {
    public serverSideApexController() {

    }
    @AuraEnabled
    public static paginationWrapper getRecords(Integer pageNumber, Integer recPageSize){
        paginationWrapper obj = new paginationWrapper();
        obj.pageSize = recPageSize;
        obj.page = pageNumber;
        obj.total =  [SELECT count() FROM account];
        String qry = 'SELECT Id, Name,AccountNumber,Active__c,AccountSource FROM Account ORDER BY ID LIMIT 10';
        obj.accounts = Database.query(qry);
        return obj;
        /*String obj ='Account';
       // List<field> flds =['Id','Name', 'Type'];
       String qry ='SELECT Id, Name FROM ' + obj ;
       List<SObject> listData = Database.query(qry);
       return listData;


        //List<Account> accList= [Select Id, Name, Type from Account ORDER BY ID LIMIT 10];
        //return accList;*/

    }
    
    public class paginationWrapper {  
        @AuraEnabled public Integer pageSize {get;set;}  
        @AuraEnabled public Integer page {get;set;}  
        @AuraEnabled public Integer total {get;set;}  
        @AuraEnabled public List<Account> accounts {get;set;}  
    }  


    
}