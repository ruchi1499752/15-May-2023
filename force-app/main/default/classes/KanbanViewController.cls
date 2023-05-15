public class KanbanViewController {
    
	@AuraEnabled
    public static Map<String,String> getObjectNames(){
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();

        List<String> standardObj = new List<String>{'Account','Contact','Product2',
            'Opportunity','Campaign','contract','Lead','idea','User','order'};
                
        Map<String,String> objNames = new Map<String,String>();
        for(String s :standardObj){
            objNames.put(s,s);
        }
       	for(String name : schemaMap.keySet()){
            Schema.DescribeSObjectResult res = schemaMap.get(name).getDescribe();
            if(res.isCustom()){
                objNames.put(name,res.getLabel());
                System.debug('Object Name : '+ objNames);
            }
        }        
        return objNames;
    }
    
    @AuraEnabled
    public static Map<String,String> getFields(String objs){

        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType obj = schemaMap.get(objs);
        system.debug(objs);
        
        Map<String,String> fieldsNames = new Map<String,String>();

        Map<String,Schema.SObjectField> fieldMap = obj.getDescribe().fields.getMap();
        

        for(String fname : fieldMap.keySet()){
            Schema.DescribeFieldResult res = fieldMap.get(fname).getDescribe();
           /* List<Schema.PicklistEntry> ple = res.getPicklistValues();
            for(Schema.PicklistEntry picklistVal : ple){
                System.debug('Picklist : ' + picklistVal.getLabel(),fieldMap.get(fname).getDescribe().getLabel()) ;
            }
            if(res.isAccessible() && res.isSortable() && res.isFilterable()){
                fieldsNames.put(fname, fieldMap.get(fname).getDescribe().getLabel());
                System.debug('fields name :' + fieldsNames);
            }*/
            //Returns one of the DisplayType enum values, depending on the type of field.
            if(String.valueOf(res.getType()) == 'Picklist'){
                fieldsNames.put(fname, fieldMap.get(fname).getDescribe().getLabel());
            }
            
        }
        return fieldsNames;

    }
    @AuraEnabled
    public static Map<String,List<sObject>> KanbanPicklist_Values(String obj, String picklistFieldName){
        List<String> pickListValues = new List<String>();
        Map<String, List<sObject>> pickListRecordMap = new Map<String,List<sObject>>();

        Schema.SObjectType convertToObj  = Schema.getGlobalDescribe().get(obj);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(picklistFieldName).getDescribe();
        
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : pList){
            pickListValues.add(pickListVal.getLabel());
            System.debug(pickListValues);  
        } 
        
        for(String pickVal : pickListValues){
            pickListRecordMap.put(pickVal, new List<sObject>());
        }
        String qry;
        qry = 'SELECT Id, Name, ' + picklistFieldName + ' FROM ' + obj;
        System.debug(qry);
        List<sObject> allRecords = Database.query(qry);

        for(sObject record : allRecords){
            if(pickListRecordMap.containsKey(String.valueOf(record.get(picklistFieldName)))){   //get(field) Returns the value for the field specified by the field token Schema.sObjectField, such as, Schema.Account.AccountNumber.
                pickListRecordMap.get(String.ValueOf(record.get(picklistFieldName))).add(record);
            }
            
        }
        return pickListRecordMap;
        
        
    }
    @auraEnabled
    public static String updatePickListValue(Id recordId, String PicklistField, String pickListValue){
        System.debug('Record ID :' + recordId);
        System.debug('PickListField :' + PicklistField);
        System.debug('PickListValues :' + pickListValue);
        SObject updateRec = recordId.getSObjectType().newSObject(recordId);
        updateRec.put(PicklistField,pickListValue);
        update updateRec;
        return 'Success';
    }
   
}

/*
@AuraEnabled
    public static ResultWrapper getDetails(String obj, String picklistFieldName) {
        ResultWrapper result = new ResultWrapper();
        try{
            KanbanPicklist_Values(String obj, String picklistFieldName);
        } catch(Exception e) {
            result.errorMessage = e.getMessage();
        }
        return result;
        //
    }
    public class WrapperClass {

        @AuraEnabled public List<String> picklistFieldDetails;
        @AuraEnabled public List<sObject> records;
        
        public WrapperClass() {
            picklistFieldDetails = new List<String>();
            records = new List<sObject>();
        }
    }
    
    public class ResultWrapper {
        @AuraEnabled public Boolean success;
        @AuraEnabled public WrapperClass allDetails;
        @AuraEnabled public String errorMessage;
        public ResultWrapper() {
            success = false;
            allDetails = new WrapperClass();
        }
    }
*/