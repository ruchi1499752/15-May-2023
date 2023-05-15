@RestResource(urlMapping='/NewCustomer/*')
global class RestResourceExample {
	@httpGet
    global static String create(){
        RestRequest request = RestContext.request;
        RestResponse response =RestContext.response;
        
        String name = request.params.get('name');
        System.debug('Name is = ' + name);
        String Industry = request.params.get('industry');
        System.debug('Industry is = ' + name);
        
        System.JSONGenerator jp = JSON.createGenerator(true);
        
        jp.writeStartObject();
      	jp.writeFieldName('status');
        try{
            Account acc = new Account();
            acc.Name = name;
            acc.Industry = Industry;
            insert acc;
            jp.writeString('SUCCESS');
            jp.writeIdField('Id', acc.Id);
            
            
        }
        catch(exception ex){
            jp.writeString('Faild');
        }
        jp.writeEndObject();
        String result = jp.getAsString();
        return result;
        
    }
    @httpPost
    global static String invoke(String name, String Industry){
        
        
		System.JSONGenerator jp = JSON.createGenerator(true);
        jp.writeStartObject();
      	jp.writeFieldName('status');
        try{
            Account acc = new Account();
            acc.Name = name;
            acc.Industry = Industry;
            insert acc;
            jp.writeString('SUCCESS');
            jp.writeIdField('Id', acc.Id);
            
            
        }
        catch(exception ex){
            jp.writeString('Faild');
        }
        jp.writeEndObject();
        String result = jp.getAsString();
        return result;
      
    }
   @HttpDelete
    global static String deleteRec(){
        RestRequest request = RestContext.request;
        RestResponse response =RestContext.response;
        
        String token = request.params.get('token');
         System.debug('token is = ' + token);
        System.JSONGenerator jp = JSON.createGenerator(true);
        jp.writeStartObject();
      	jp.writeFieldName('status');
        try{
            String qry = 'SELECT id from Account Where createddate = '+ token;
            System.debug('Query :: '+qry);
            List<Account>accounts = Database.query(qry);
            delete accounts;
             jp.writeString('SUCCESS');
            jp.writeNumberField('Id', accounts.size());
            /*count acc = new Account();
            acc.Name = name;
            acc.Industry = Industry;
            insert acc;
            jp.writeString('SUCCESS');
            jp.writeIdField('Id', acc.Id);*/
            
            
        }
        catch(exception ex){
            jp.writeString('Faild');
        }
        jp.writeEndObject();
        String result = jp.getAsString();
        return result;
      
        
        	
    }
    
        
    
}