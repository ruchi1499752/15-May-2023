/*********************************************************************************** 
Name : Client Side Pagination Apex Controller
Description : Apex controller for Client side pagination
Created By : Ruchi Chourasia
Created Date : 
************************************************************************************/
public with sharing class ClientSidePaginationController {

// This method is used to get all SObjects name from Org    
    @AuraEnabled
    public static Map<String,String> getObjectName(){
        try {
            Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();
            List<String> standardObj = new List<String>{'Account','Contact','Product2',
            'Opportunity','Campaign','contract ','Lead','idea','User','order'};

            Map<String,String> objNames = new Map<String,String>();
            for(String obj : standardObj){
                objNames.put(obj,obj);
            }
            for(String name : objectMap.keySet()){
                Schema.DescribeSObjectResult res = objectMap.get(name).getDescribe();
                if(res.isCustom()){
                    objNames.put(res.getName(),res.getLabel());
                    
                }
            }
            
            return objNames;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

//This method is used to Get the Fields List According to Passing Object Name    
    @AuraEnabled
    public static Map<String,String> getFields(String obj){
        System.debug('Object :' + obj);
        try {
            
            SObjectType objs = Schema.getGlobalDescribe().get(obj);
            System.debug('Selected Object :' + objs);
            Map<String,String> fieldNames = new Map<String,String>();
            Map<String,Schema.SObjectField> fieldMap = objs.getDescribe().fields.getMap();
            for(String fname : fieldMap.keySet()){
                Schema.DescribeFieldResult res = fieldMap.get(fname).getDescribe();
                if(res.isAccessible() && res.isSortable() && res.isFilterable()){
                    fieldNames.put(res.getName(),res.getLabel());
                    
                }
            }
            System.debug('Fields Names :' + fieldNames);
            return fieldNames;

        } catch (Exception e) {
            
            throw new AuraHandledException(e.getMessage());
        }
    }

//This method is used to Get the The Records Of Selected Fields and Selected Object 
    @AuraEnabled
    public static List<SObject> getData(String objName, List<String> fieldList){
        try {
            system.debug('Object Name :' + objName);
            System.debug('FieldList :' + fieldList);

            String qry = 'SELECT ';
            for(String fieldName : fieldList){
                qry += fieldName + ', ';
            }
            qry = qry.substring(0,qry.lastIndexOf(','));
            qry += ' FROM ' + objName;
            
            System.debug('Query :' + qry);
            
            //return qry;


            return Database.query(qry);
            
            // if(String.isBlank(objName) && fieldList != null){
                // String qry = 'SELECT id, ' + String.join(fieldList, ',') + ' FROM ' + objName;
                // System.debug('Query :' + qry);
                // return Database.query(qry);
            
            //return null;
            
        } catch (Exception e) {
            System.debug('Get Data Exceprion :' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}


















//This method is used to Get the Name And Label Of Selected Fields
   /* @AuraEnabled
    public static Map<String,String> getFieldNameAndLabel(String objectName, List<String> SelectedFieldsList){
        try {
            System.debug('Object NAme :'+ objectName);
            System.debug('Selected Field List :' + SelectedFieldsList);
            Map<String,String> fieldsList = new Map<String,String>();

            // if(String.isNotBlank(objectName)){
                Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().SObjectType.getDescribe().fields.getMap();

                for (Schema.SObjectField fieldName: fieldMap.values()) {
                    if(SelectedFieldsList.contains(fieldName.getDescribe().getName())){
                        fieldsList.put(fieldName.getDescribe().getName(),fieldName.getDescribe().getLabel());
                    }
                }
                System.debug('getFieldNameAndLabel :'+ fieldsList);
            //}

            return fieldsList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }*/