public class FlowExample {
    //label is a record parameter
    @InvocableMethod(label='Delete Related Opportunities' description='Delete Related Opportunities for the given Record Ids.')
    public static void deleteOpportunites(List<String> ids){
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =: ids AND StageName = 'Closed Won'];
        delete oppList; 
     }
  


}