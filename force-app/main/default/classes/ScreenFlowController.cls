public with sharing class ScreenFlowController {
    @AuraEnabled
    public static List<Case> getCase(String recId){
        try {
            List<Case> parentId = [SELECT Case.ParentId FROM Case where id =: recId];
            System.debug('Parent ID  ' + parentId[0].ParentId);

            String res = parentId[0].ParentId;
            System.debug('RESULT :' + res);
            List<Case> caseList = [Select subject,Id,CaseNumber,Origin, SuppliedEmail,(select case.ParentId from Cases where Case.ParentId !=: res ) from case where Id !=: res] ;
            System.debug('CaseList :' + caseList);

            return caseList ;

    

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

   /* @AuraEnabled
    public static string updateCaseRecord(String parentCaseId, String CaseOrigin){
        try {
            System.debug('Parent Id  :' + parentCaseId);
            List<Case> res = [SELECT Subject, CaseNumber, Id, Origin, SuppliedEmail FROM Case Where Id =: parentCaseId];
            System.debug('Rec :' + res);

            // for(Case result : res){
            //     if(result.Origin != 'Email'){
            //         result.Origin = 'abc';
            //     }
            //     else if(){

            //     }
            // }
            System.debug('Case Origin value ::::' + CaseOrigin);


            // if(CaseOrigin != 'Email'){
            //     res[0].ParentId = parentCaseId;
            //     res[0].Origin = CaseOrigin;
            //     System.debug('Record Updated');
            //     update res;
            // }
            // else{
            //     System.debug('Case Origin :' + CaseOrigin);
            // }
            return 'Case';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/

    

    // @InvocableMethod(label = 'Pass Parent Record Id')
    // public static List<List<Case>> passRecordId(){
    //     String str = 'rucha';


    //     List<Case> caseList = [SELECT Id from Case Where id = '5005j00000Tffc9AAB'];
    //     List<List<Case>> caseListItem = new List<List<Case>>();
    //     caseListItem.add(caseList);
    //     return caseListItem;
    // }

    // @InvocableMethod(label = 'Pass Parent Record Id')
    // public static List<List<Case>> passRecordId(){
    //     String str = 'rucha';


    //     List<Case> caseList = [SELECT Id,Origin,Subject from Case Where id = '5005j00000Tffc9AAB'];
        
    //     List<List<Case>> caseListItem = new List<List<Case>>();
    //     caseListItem.add(caseList);
    //     return caseListItem;
    // }


    @AuraEnabled
    public static string getCaseOrigin(String origin){
        try {
            System.debug('Case Origin :' + origin);
            return origin;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}