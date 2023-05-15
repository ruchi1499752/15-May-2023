public class ServerSideController {
    Public static List<String> fields;
    Public static String objNme;
   
    
    @AuraEnabled
    public static Map<String, String> ObjectNames() 
    {
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        System.debug('schemaMap ---'+schemaMap);
        list<String> Standardlist = new list<String>{'Account','Contact','Product2',
            'Opportunity','Campaign','contract','Lead','idea','User','order'};
                
        Map<String, String> objNames  = new Map<String, String>(); 
        objNames.put('','--NONE--');
        
        Schema.DescribeSObjectResult ds;
        System.debug('before ds---'+ds);
         for(String S3:Standardlist ) {
                objNames.put(S3,S3); 
            }
        for(string name : schemaMap.keySet()) {
            ds = schemaMap.get(name).getDescribe();
            if(ds.isCustom()) {
                objNames.put(name,ds.getLabel());
                System.debug('objNames ---'+objNames);
            }
            
        }
       
        System.debug('objNames'+objNames);
        return objNames;
    }
    
    @AuraEnabled
    public static Map<String, String> fields(String selectedObject) {
        String Objname = selectedObject;
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.DescribeFieldResult ds;
        Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);
        Map<String, Schema.SObjectField> fieldMap = new Map<String, Schema.SObjectField>();
        fieldMap = ObjectSchema.getDescribe().fields.getMap();
        map<String, String> fieldNames = new map<String, String>();
        for (String fieldName: fieldMap.keySet()) 
        {  
            // ds =fieldMap.get(fieldName).getDescribe();
            
            fieldNames.put(fieldName,fieldMap.get(fieldName).getDescribe().getLabel());
        }
        System.debug('fieldNames'+fieldNames);
        return fieldNames;
    }
    
    @AuraEnabled
    public static DynamicBindingWrapper getfields ( String ObjName, List<String> selectedfields, Decimal pageNumber ,Integer recordToDisply, String sortField, boolean isAsc) {
        DynamicBindingWrapper wrapper = new DynamicBindingWrapper();
        List<fieldDataWrapper> Listfieldwrapper = new List<fieldDataWrapper>();
     
        System.debug('selectedfields'+selectedfields);
         System.debug('pageNumber'+pageNumber);
       
        System.debug('objNme---'+objNme);
         System.debug('selectedfields---'+selectedfields);
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.DescribeFieldResult ds;
        Schema.SObjectType ObjectSchema = schemaMap.get(ObjName);
        System.debug('ObjectSchema'+ObjectSchema);
        Map<String, Schema.SObjectField> fieldMap = new Map<String, Schema.SObjectField>();
        fieldMap =ObjectSchema.getDescribe().fields.getMap();
        map<String, String> fieldNames = new map<String, String>();
        for (String fieldName: fieldMap.keySet()) 
        {  
            fieldNames.put(fieldName,fieldMap.get(fieldName).getDescribe().getLabel());
            for(String s : selectedfields){
                if(fieldName.equals(s)) {
                    fieldDataWrapper fieldwrapper = new fieldDataWrapper();
                    fieldwrapper.label = fieldMap.get(s).getDescribe().getLabel();
                    fieldwrapper.apiName = fieldMap.get(s).getDescribe().getName();
                   
                    Listfieldwrapper.add(fieldwrapper);
                }
            }
        } 
        System.debug('Listfieldwrapper'+Listfieldwrapper);
        String commaSepratedFields='';
        for(String fieldName : selectedfields) {
            if(commaSepratedFields == '') {
                commaSepratedFields = fieldName;
            } else {
                commaSepratedFields = commaSepratedFields + ',' + fieldName;
            }
        }
        System.debug('commaSepratedFields' +commaSepratedFields);
          System.debug('hitttt');
        //record to be displayed on particular page
        Integer pageSize = recordToDisply;  
        System.debug('recordToDisply '+recordToDisply);
          System.debug('fields---- '+fields);
         System.debug('objNme--- '+objNme);
        
        Integer offset = ((Integer)pageNumber - 1) * pageSize; 
        System.debug('offset '+offset);
        
        List<AccountPagerWrapper> accobj = new List<AccountPagerWrapper>(); 
        AccountPagerWrapper obj = new AccountPagerWrapper();
        obj.pageSize = pageSize;  
        System.debug('pageSize '+pageSize);
        
        obj.page = (Integer) pageNumber;  
      
        obj.total = [SELECT count() FROM account]; 
         accobj.add(obj);
        String query = 'SELECT '+commaSepratedFields+' FROM '+ObjName+' ORDER BY '+sortField+ (isAsc?' ASC':' DESC')+' LIMIT '+recordToDisply+' OFFSET '+offset;  
        system.debug('query ::: ' + query); 
        
        List<sObject> objList =  Database.query(query);  
        System.debug(Database.Query(query));
         
        System.debug('objList'+objList);
        wrapper.sObjectData = objList;
        wrapper.fieldList = Listfieldwrapper;
        wrapper.pagination = accobj;
        System.debug('wrapper sobjcet' + objList);
         system.debug('wrapper fieldList' +Listfieldwrapper);
         system.debug('wrapper pagination' +accobj);
        system.debug('wrapper list' +wrapper);
         
        return wrapper;
    }
     
    public class AccountPagerWrapper {  
        @AuraEnabled
        public Integer pageSize; 
        @AuraEnabled 
        public Integer page;
        @AuraEnabled
        public Integer total;
         
    } 
    
    //Class to store the field information 
    public class fieldDataWrapper {
        @AuraEnabled
        public String label ;
        @AuraEnabled
        public String apiName ;
      
     } 
    
    // Class to store the dynamic data and list of related fields
    public class DynamicBindingWrapper {
        @AuraEnabled
        public List<sObject> sObjectData;  
        @AuraEnabled
        public List<fieldDataWrapper> fieldList;
        @AuraEnabled
        Public List<AccountPagerWrapper> pagination;
    }
}