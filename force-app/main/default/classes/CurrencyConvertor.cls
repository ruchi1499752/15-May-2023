public with sharing class CurrencyConvertor {
   public static decimal currencyConvertorFromEUROtoINR(decimal eur){
    decimal inr = 0.0;
    Http h = new Http();
    HTTPRequest req = new HTTPRequest(); 
    String ENDPOINT_URL = 'https://api.exchangeratesapi.io/v1';
    String API_KEY = 'RO0e8m8gUQS12tgrZPEvYhhT4icgvgni';   
    //req.setEndPoint(ENDPOINT_URL + '?access_key=' + API_KEY);
    req.setEndpoint('https://api.exchangeratesapi.io/v1/latest? access_key ='+ API_KEY);   
    req.setMethod('GET');

    HTTPResponse resp = h.send(req);

    Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(resp.getBody());
    System.debug('JSON BOdy ::' + result);

	return inr;

   }
}