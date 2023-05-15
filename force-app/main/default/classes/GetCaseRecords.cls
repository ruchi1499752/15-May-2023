public class GetCaseRecords {
    @AuraEnabled
    public static List<Case> getCaseRecords(String RecordId){
        List<Case> caseList = [SELECT Id, Subject, SuppliedEmail FROM CASE WHERE Id  =: RecordId];
        return caseList;
    }

}