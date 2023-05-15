public with sharing class PaymentGatewayIntegrationSeviceClass {
    public static HttpResponse handlePayByCreditCard(Map<String,String> values){
        HttpRequest req = new HttpRequest();
        
        req.setMethod(values.get('Method'));
        req.setEndpoint(values.get('EndPoint'));
        req.setHeader('Content-Type', values.get('Content-Type'));
        req.setBody(values.get('Body'));


        Http h = new Http();
         // Send the request, and return a response
        HttpResponse resp = new HttpResponse();
        resp = h.send(req);
        String responseBody = resp.getBody();
        System.debug('Response Body :'+ resp.getBody());
        System.debug('Error Code :'+ resp.getStatusCode());

        // if(values.get('Method') == 'payByCreditCard'){
            return resp;
        // }
        // return null;
        


    }
    public static HttpResponse handlePayByCheck(Map<String,String> values){
        HttpRequest req = new HttpRequest();
        
        req.setMethod(values.get('Method'));
        req.setEndpoint(values.get('EndPoint'));
        req.setHeader('Content-Type', values.get('Content-Type'));
        req.setBody(values.get('Body'));
        System.debug('Request Body :' + values.get('Body'));


        Http h = new Http();
         // Send the request, and return a response
        HttpResponse resp = new HttpResponse();
        resp = h.send(req);
        String responseBody = resp.getBody();
        System.debug('Response Body :'+ resp.getBody());
        System.debug('Error Code :'+ resp.getStatusCode());

        // if(values.get('Method') == 'payByCreditCard'){
            return resp;
        // }
        // return null;
        


    }
}