public class CaseAction {
	@invocableMethod(label='Get Case Records')
     public static void getCaseRecords(List<Id> ids){
        List<Case> caseList = [SELECT Id, Subject, SuppliedEmail FROM CASE WHERE Id  !=: ids];
         //caseList = [SELECT Id, Subject, SuppliedEmail FROM CASE WHERE Id  !=: ids LIMIT 1];
         System.debug('Result :' + caseList);
        //return caseList;
    }
}