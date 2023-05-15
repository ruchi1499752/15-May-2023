public with sharing class PaymentGatewayIntegrationMockClass implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req) {
        String method = req.getMethod();
        System.debug('Method is ' + method);
        String endPoint = req.getEndpoint();
        System.debug('EndPoint is ' + endPoint);
		
        // Create a fake response
        HttpResponse res = new HttpResponse();
        
      	if(req.getEndpoint() == 'https://apitest.authorize.net/xml/v1/request.api'){
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"transactionResponse":{"responseCode":"1","authCode":"E5485S","avsResultCode":"Y","cvvResultCode":"P","cavvResultCode":"2","transId":"60195954643","refTransID":"","transHash":"","testRequest":"0","accountNumber":"XXXX0012","accountType":"Discover","messages":[{"code":"1","description":"This transaction has been approved."}],"transHashSha2":"","SupplementalDataQualificationIndicator":0,"networkTransId":"A81WCP4QYMYZHA39XFWIHGR"},"refId":"123456","messages":{"resultCode":"Ok","message":[{"code":"I00001","text":"Successful."}]}}');
            res.setStatusCode(200);
            return res;
        }
        return null;
        /*if(req.getEndpoint() == 'https://apitest.authorize.net/xml/v1/request.api'){
           	res.setBody('{"transactionResponse":{"responseCode":"3","authCode":"","avsResultCode":"P","cvvResultCode":"","cavvResultCode":"","transId":"0","refTransID":"","transHash":"","testRequest":"0","accountNumber":"XXXX0000","accountType":"","errors":[{"errorCode":"6","errorText":"The credit card number is invalid."}],"transHashSha2":"","SupplementalDataQualificationIndicator":0},"refId":"123456","messages":{"resultCode":"Error","message":[{"code":"E00027","text":"The transaction was unsuccessful."}]}}');
            res.setStatusCode(200);
        }*/
        //System.debug('MockClass Response :'+ res);
        //return res;
        

    }
    
}