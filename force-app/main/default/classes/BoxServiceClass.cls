public with sharing class BoxServiceClass {
   
    public static String handleRequest(Map<String,String> valuesMap){
        HttpRequest req = new HttpRequest();
        req.setMethod(valuesMap.get('Method'));
        req.setEndpoint(valuesMap.get('EndPoint'));

        if(valuesMap.get('MethodName') == 'requestAccessToken'){
            System.debug('Call requestAccessToken');
            req.setHeader('Content-type', valuesMap.get('Content-type'));
            req.setHeader('Content-length', valuesMap.get('Content-length'));
            req.setBody(valuesMap.get('Body'));
        }else if(valuesMap.get('MethodName') == 'refreshAccessToken'){
            req.setHeader('Content-type', valuesMap.get('Content-type'));
            req.setBody(valuesMap.get('Body'));
        }else if(valuesMap.get('MethodName') == 'getAllfilesAndFolders'){
            req.setHeader('Content-type', valuesMap.get('Content-type'));
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            
        }else if(valuesMap.get('MethodName') == 'createFolder'){
            req.setHeader('Content-type', valuesMap.get('Content-type'));
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            req.setBody(valuesMap.get('Body'));
        }else if(valuesMap.get('MethodName') == 'deleteFolder'){
            req.setHeader('Content-type', valuesMap.get('Content-type'));
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            
        }
        else if(valuesMap.get('MethodName') == 'deleteFile'){
            req.setHeader('Content-type', valuesMap.get('Content-type'));
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            
        }
        else if(valuesMap.get('MethodName') == 'downloadBoxFile'){
            req.setHeader('Content-type', valuesMap.get('Content-type'));
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            
        }
        
        
        
        Http h = new Http();
        String resp;
       
        HttpResponse res = h.send(req);
        resp = res.getBody();
        System.debug('Response : ' + resp);

        if(valuesMap.get('MethodName') == 'requestAccessToken'){
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(resp) ;

            String AccessToken =  String.valueOf(responseMap.get('access_token'));
            System.debug('AccessToken :'+ AccessToken);
            String RefreshToken  =  String.valueOf(responseMap.get('refresh_token'));
            System.debug('RefreshToken : '+ RefreshToken);
            
            List<Box_Integration__c> integrationUserDetails = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c WHERE userId__c =: userInfo.getUserId()];
            if(!integrationUserDetails.isEmpty()){
                integrationUserDetails[0].Access_Token__c = AccessToken;
                integrationUserDetails[0].Refresh_Token__c = RefreshToken;
                integrationUserDetails[0].ExpireTime__c = System.now().addHours(1);
                System.debug('Record Update');
                update integrationUserDetails;
            }else {
                Box_Integration__c obj = new Box_Integration__c();
                obj.Access_Token__c = AccessToken;
                obj.Refresh_Token__c = RefreshToken;
                obj.userId__c = userInfo.getUserId();
                obj.ExpireTime__c = System.now().addHours(1);
                obj.Name = 'IntegrationUser1';
                System.debug('Record Update');
                insert obj;
            }
            
            //return resp;
            return 'Token Exist';

        }else if(valuesMap.get('MethodName') == 'refreshAccessToken'){

            Map<String, Object> mapResponse = (Map<String, Object>)json.deserializeUntyped(resp);
            String AccToken = String.valueOf(mapResponse.get('access_token'));
            System.debug('Refresh : AccessToken : ' + AccToken);
            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            record[0].Access_Token__c = AccToken;
            record[0].ExpireTime__c = System.now().addHours(1);
            update record;
            System.debug('Record Updated !!!!!!');
           
            return 'Token Exist';
        }
        else if(valuesMap.get('MethodName') == 'getAllfilesAndFolders'){
            return resp;
        }
        else if(valuesMap.get('MethodName') == 'createFolder'){
            return resp;
        }
        else if(valuesMap.get('MethodName') == 'deleteFolder'){
            return String.valueOf(res.getStatuscode());
        }
        else if(valuesMap.get('MethodName') == 'deleteFile'){
            return String.valueOf(res.getStatuscode());
        }
        else if(valuesMap.get('MethodName') == 'downloadBoxFile'){
            System.debug('Location :'  + res.getHeader('location'));    //The GET request header has a location and that returns the URL for download of the file .
            
           return res.getHeader('location');
        }
        
        
        
        return null;
    }
}