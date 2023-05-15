public with sharing class CustomAccountController {
    
    @AuraEnabled
    public static List<SObject> getData(String qry){
        try {
            System.debug('Query :' + qry);
            return Database.query(qry);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Account_Custom__c> updateData(String objectName, String objList){
        try {
            System.debug('ObjectName :' + objectName);
            System.debug('ObjList ::' + objList);
            System.debug('Inside Account if part');
                List<Account_Custom__c> accountList = (List<Account_Custom__c>)JSON.deserialize(objList, List<Account_Custom__c>.class);
                System.debug('accountList :: ' + accountList);
                upsert accountList;
                System.debug('Record Updated');
                return accountList;

            /*if(objectName == 'Account_Custom__c'){
                System.debug('Inside Account if part');
                List<Account_Custom__c> accountList = (List<Account_Custom__c>)JSON.deserialize(objList, List<Account_Custom__c>.class);
                System.debug('accountList :: ' + accountList);
                upsert accountList;
                System.debug('Record Updated');
            }
           else if(objectName == 'Contact_Custom__c'){
                System.debug('Inside Contact');
                List<Contact_Custom__c> contactList = (List<Contact_Custom__c>)JSON.deserialize(objList, List<Contact_Custom__c>.class);
                System.debug('ContactList :: ' + contactList);
                upsert contactList;
                System.debug('Contact Record Updated');
            }
            else if(objectName == 'Case_Custom__c'){
                System.debug('Inside Case ');
                List<Case_Custom__c> caseList = (List<Case_Custom__c>)JSON.deserialize(objList, List<Case_Custom__c>.class);
                System.debug('CaseList :: ' + caseList);
                upsert caseList;
                System.debug('Case Record Updated');
            }else{
                System.debug('Inside contractList ');
                List<Contract_Custom__c> contractList = (List<Contract_Custom__c>)JSON.deserialize(objList, List<Contract_Custom__c>.class);
                System.debug('Contract List :: ' + contractList);
                upsert contractList;
                System.debug('Case Record Updated');

            }*/

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    

}