public class getObject {
    
    public getObject(){
         /*Map<String,Schema.SObjectType> m = Schema.getGlobalDescribe();
    	 System.debug(m);*/
        
       /* Map<String, Schema.SObjectType> m = Schema.getGlobalDescribe() ;
		Schema.SObjectType s = m.get('API_Name_Of_SObject') ;
		Schema.DescribeSObjectResult r = s.getDescribe() ;
		Map<String,Schema.SObjectField> fields = r.fields.getMap() ;*/
        
        Map<String, SObjectType> sObjects = Schema.getGlobalDescribe();
        for (String apiName : sObjects.keySet())
        {
            system.debug(apiName);
            //system.debug(sObjects.get(apiName));
        }

 


 
    }
   

}