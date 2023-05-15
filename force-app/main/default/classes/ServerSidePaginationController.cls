public class ServerSidePaginationController {
	
    @AuraEnabled
    public static List<SObject> getRecords(String qry){
       List<SObject> recordList = Database.query(qry);
       return recordList;
        //System.debug(recordList);
    }
    @AuraEnabled
    public static Integer getTotalRecords(){
        Integer record = [SELECT count() FROM Account];
        system.debug(record);
        return record;
    }
}