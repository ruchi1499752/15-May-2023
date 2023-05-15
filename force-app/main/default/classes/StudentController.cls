public with sharing class StudentController {
    
    @auraEnabled
    public static List<SObject> StudentDetails(){
        //List<StudentDetails__c> studentList = [SELECT Name, DOB__c, Gender__c, 	Address__c FROM StudentDetails__c];
        //System.debug('Student Details :' + studentList);
        
        String qry = 'SELECT Name, DOB__c, Gender__c, Address__c FROM StudentDetails__c';
        return Database.query(qry);
    }
}