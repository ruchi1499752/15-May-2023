public with sharing class CommunityOrgSeviceClass {
    public static HttpResponse httpCallout(String Method, String endPoint, String body, Map<String,String> header){
        HttpRequest req = new HttpRequest();
        System.debug('Body is :' + body);
        req.setMethod(Method);
        req.setEndpoint(endPoint);
        req.setHeader('Content-Type', header.get('Content-Type'));
        req.setBody(body);

        Http h = new Http();
        HttpResponse resp = h.send(req);
        System.debug('ENDpoint :'  + req.getEndpoint());
        
        while (resp.getStatusCode() == 302) {
            req.setEndpoint(resp.getHeader('Location'));
            resp = new Http().send(req);
        }
        System.debug('Response : ' + resp);
        return resp;

    }
}