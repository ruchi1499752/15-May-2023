public with sharing class CaseController {
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getAllCases(){
        try {
            List<Case> caseList = [SELECT Id,Subject, Description,Status, Origin FROM Case];
            return caseList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}