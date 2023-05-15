/*========================================================================================================
Description : Class (PaymentGatewayIntegrationController) is to integrate Echeck and Card with salesforce
Created By : Ruchi Chourasia
Created Date : 

=========================================================================================================*/
public with sharing class PaymentGatewayIntegrationController {
    private static String loginId = Authorize_net__mdt.getInstance('Authorize_net').LoginId__c;
    private static String transactionKey = Authorize_net__mdt.getInstance('Authorize_net').TransactionKey__c;
    
    @AuraEnabled
   public static PaymentGatewayWrapper payByCheck(String rountingNum, String AccountNum, String name){
    // try {
        
        // Create a JSONGenerator object.
        // Pass true to the constructor for pretty print formatting.
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('createTransactionRequest');
        gen.writeStartObject();
        gen.writeFieldName('merchantAuthentication');
        gen.writeStartObject();
        gen.writeStringField('name', loginId);
        gen.writeStringField('transactionKey', transactionKey);
        gen.writeEndObject();

        gen.writeStringField('refId', '123456');
        gen.writeFieldName('transactionRequest');
        gen.writeStartObject();
        gen.writeStringField('transactionType', 'authCaptureTransaction');
        gen.writeStringField('amount', '5');
        gen.writeFieldName('payment');
        gen.writeStartObject();
        gen.writeFieldName('bankAccount');
        gen.writeStartObject();
        gen.writeStringField('routingNumber', rountingNum);
        gen.writeStringField('accountNumber', AccountNum);
        gen.writeStringField('nameOnAccount', name);
        gen.writeEndObject();
        gen.writeEndObject();
        gen.writeStringField('refTransId', '2148889729');

        HttpResponse response = new HttpResponse();
        Map<String,String> valuesMap = new Map<String,String>();
        valuesMap.put('Method', 'POST');
        valuesMap.put('EndPoint', 'https://apitest.authorize.net/xml/v1/request.api');
        valuesMap.put('Content-Type', 'application/json');
        valuesMap.put('Body', gen.getAsString());
        //valuesMap.put('Method', 'payByCreditCard');
        response = PaymentGatewayIntegrationSeviceClass.handlePayByCheck(valuesMap);
        System.debug('Response is :'+ response);

        if(response.getStatusCode() == 200){
            //.substring(1,response.getBody().length()
            PaymentGatewayWrapper result = (PaymentGatewayWrapper)JSON.deserialize(response.getBody().trim().replace('\uFEFF', ''), PaymentGatewayWrapper.class);
            System.debug('Wrapper Result :' + result);
            return result;
           
        }
        return null;
        
        
        
   }

   @AuraEnabled
   public static PaymentGatewayWrapper payByCreditCard(String cardNum, String month , String year, String cvvNum){
    try {
        
        String expireDate = year+'-'+month;
        System.debug('expirationDate :' +expireDate);
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('createTransactionRequest');
        gen.writeStartObject();
        gen.writeFieldName('merchantAuthentication');
        gen.writeStartObject();
        gen.writeStringField('name', loginId);
        gen.writeStringField('transactionKey', transactionKey);
        gen.writeEndObject();
        
        gen.writeStringField('refId', '123456');
        gen.writeFieldName('transactionRequest');
        gen.writeStartObject();
        gen.writeStringField('transactionType', 'authCaptureTransaction');
        gen.writeStringField('amount', '5');
        gen.writeFieldName('payment');
        gen.writeStartObject();
        gen.writeFieldName('creditCard');
        gen.writeStartObject();
        gen.writeStringField('cardNumber', cardNum);
        gen.writeStringField('expirationDate', expireDate);
      
        gen.writeEndObject();
        gen.writeEndObject();

        HttpResponse response = new HttpResponse();
        Map<String,String> valuesMap = new Map<String,String>();
        valuesMap.put('Method', 'POST');
        valuesMap.put('EndPoint', 'https://apitest.authorize.net/xml/v1/request.api');
        valuesMap.put('Content-Type', 'application/json');
        valuesMap.put('Body', gen.getAsString());
        //valuesMap.put('Method', 'payByCreditCard');
        response = PaymentGatewayIntegrationSeviceClass.handlePayByCreditCard(valuesMap);
        System.debug('Response is :'+ response);

        if(response.getStatusCode() == 200){
            PaymentGatewayWrapper result = (PaymentGatewayWrapper)JSON.deserialize(response.getBody().trim().replace('\uFEFF', ''), PaymentGatewayWrapper.class);
            System.debug('Wrapper Result :' + result);
            return result;
           
        }
        return null;
        
    } catch (Exception e) {
        System.debug('Error : ' + e.getMessage());
        throw new AuraHandledException(e.getMessage());
    }
    }
}