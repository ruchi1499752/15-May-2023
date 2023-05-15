public with sharing class CommunityOrgMockClass implements HttpCalloutMock{
    
    public HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json;charset=UTF-8');

        if(req.getEndpoint() == 'callout:IntegrationUser/services/apexrest/uploadFile'){
            System.debug('call Mock Class');
           	//res.setBody('{"example" : "test"}');
            res.setBody('{"filename" : "filename" ,"base64" : "fbhjbffb"}');
            res.setStatusCode(200);
			
       }
       System.debug('res??'+ res);
       return res;
    }
}