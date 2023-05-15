public with sharing class auraApexController {
    //public Map<String,Schema.SobjectType> objectMap{get;set;}
    public auraApexController() {
		
    }
    @AuraEnabled
    public static List<sObject> getsAllObjects() {
        List <sObject>  sobjectList = [SELECT QualifiedApiName FROM EntityDefinition Order by QualifiedApiName];                      
        return sobjectList;
    }
    @AuraEnabled
    public static List<FieldDefinition> getFieldOfSobj(String selectedObject){
        List<FieldDefinition> fieldDefinitionList = new List<FieldDefinition>();
        fieldDefinitionList = [SELECT Label,
            DataType,
            QualifiedApiName
            FROM FieldDefinition
            Where EntityDefinition.QualifiedApiName=:selectedObject
        ];
        System.debug(fieldDefinitionList);
        return fieldDefinitionList;
    }
    @AuraEnabled
    public static List<String> getDefaultFieldsRecord(String objectName, list<String> fieldObjList){
        String strQuery = '';
        String strFieldToQuery = '';
        if( fieldObjList!=null){            
            for(Integer i=0; i < fieldObjList.size()-1;i++){
                strFieldToQuery += fieldObjList[i] + ',';
            }
            strFieldToQuery += fieldObjList[fieldObjList.size()-1];
            strQuery = 'Select ' + strFieldToQuery + ' FROM '+ objectName;
        }
        System.debug('strQuery'+strQuery);
        
        List<sObject> listOfFieldRecords = Database.query(strQuery);
        System.debug('listOfFieldRecords'+listOfFieldRecords);
        List<String> strData = new List<String>();
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Schema.SobjectType oType = gd.get(ObjectName);
        for(sObject a: listOfFieldRecords){
            sobject object_instance = oType.newSObject();
            object_instance = a;
            for(String singleField:fieldObjList){
                strData.add((string)object_instance.get(singleField));
            }
        }
        System.debug('strData: = '+strData);
        return strData;        
    }
    /*@AuraEnabled
    public static void getObjectList(){

        List<SelectOption> sObjectList = new List<SelectOption>();

        sObjectList.add(new SelectOption('None','---None---'));
        Map<String,Schema.SobjectType> objectMap = Schema.getGlobalDescribe();
        
        List<String> standardObjectList = new List<String>();
        standardObjectList.addAll(objectMap.keySet());
        Schema.DescribeSObjectResult[] objName = Schema.describeSObjects(standardObjectList);
        
        sObjectList.add(new SelectOption('Account','Account'));
        sObjectList.add(new SelectOption('Asset','Asset'));
        sObjectList.add(new SelectOption('Case','Case'));
        sObjectList.add(new SelectOption('Campaign','Campaign'));
        sObjectList.add(new SelectOption('Lead','Lead'));
        sObjectList.add(new SelectOption('Opportunity','Opportunity'));
        sObjectList.add(new SelectOption('Contract','Contract'));
        sObjectList.add(new SelectOption('idea','idea'));
        sObjectList.add(new SelectOption('Product2','Product2'));
        sObjectList.add(new SelectOption('Order','Order'));
        sObjectList.add(new SelectOption('Solution','Solution'));
        sObjectList.add(new SelectOption('User','User'));
        
        for(Schema.DescribeSObjectResult res : objName){
            //System.debug(res);
            if(res.isCustom()){
                sObjectList.add(new SelectOption(res.getName(), res.getLabel()));
                System.debug(sObjectList);
            }
        }
       //return SobjectList;
    }

    @AuraEnabled
    public static List<String> getCountries(String fname){
        List<String> c = new List<String>();
        c.add('USA');
        c.add('India');
        c.add(fname);
        return c;
        
    }*/

    @AuraEnabled
	public static String[] getStringArray() {
		String[] arrayItems = new String[]{ 'red', 'green', 'blue' };
		return arrayItems;
	}

}