/*=============================================================================
Description : Service class for http callout for dropbox integration
Created By : Ruchi Chourasia


================================================================================*/
public with sharing class DropboxService_Class {
   
    public static String handleRequest(Map<String,String> valuesMap){

        HttpRequest req = new HttpRequest();
        req.setMethod(valuesMap.get('Method'));
        req.setEndpoint(valuesMap.get('EndPoint'));

        if(valuesMap.get('MethodName') == 'getAccessToken'){
            System.debug('call getAccessToken from service class');
            System.debug(valuesMap.get('Body'));
            req.setBody(valuesMap.get('Body'));
            req.setHeader('Content-type', valuesMap.get('Content-type'));
        }
        else if(valuesMap.get('MethodName') == 'getRefreshToken'){
            req.setBody(valuesMap.get('Body'));
        }
        // else if(valuesMap.get('MethodName') == 'getData'){
        //     System.debug('getData method call ');
        //     req.setHeader('Content-type', valuesMap.get('Content-type'));
        //     req.setHeader('Authorization', valuesMap.get('Authorization'));
        //     req.setBody(valuesMap.get('Body'));
        // }

        Http h = new Http();
        HttpResponse resp = h.send(req);
        System.debug('request body : '+resp.getBody());
        String result = resp.getBody();
        System.debug('Result is :'+ result);

        
        if(valuesMap.get('MethodName') == 'getAccessToken'){
            System.debug('Hii from getAccessToken');
            DropBoxWrapperClass.AccessTokenWrapper token = (DropBoxWrapperClass.AccessTokenWrapper)JSON.deserialize(resp.getBody(), DropBoxWrapperClass.AccessTokenWrapper.class);
            System.debug('Wrapper Access Token :' + token.access_token); 
            System.debug('Wrapper Refresh Token :' + token.refresh_token);    

            List<Integration_Access__c> integrationUserDetails = [
                SELECT Id, Access_Token__c, Refresh_Token__c ,ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];

            
            if(!integrationUserDetails.isEmpty()){
                System.debug('If Part Run');
                integrationUserDetails[0].Access_Token__c = token.access_token;
                integrationUserDetails[0].Refresh_Token__c = token.refresh_token;
                integrationUserDetails[0].ExpireTime__c = System.now().addHours(4);
                System.debug('Record Update');
                update integrationUserDetails;
            }else{
                Integration_Access__c obj = new Integration_Access__c();
                obj.RecordTypeId = '0125j000001ZrpQAAS';
                obj.Access_Token__c = token.access_token;
                obj.Refresh_Token__c = token.refresh_token;
                obj.userId__c = userInfo.getUserId();
                obj.ExpireTime__c = System.now().addHours(4);
                
                System.debug('Record Insert');
                insert obj;
            
            }
            return 'Token exist';
        }
        else if(valuesMap.get('MethodName') == 'getRefreshToken'){
            List<Integration_Access__c> record = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(resp.getBody()) ; 
            
            System.debug('Response code :' + resp.getStatusCode());
            String AccessToken =  String.valueOf(responseMap.get('access_token'));
            System.debug('Refresh : AccessToken :'+ AccessToken);

            if(resp.getStatusCode() == 200){
                record[0].Access_Token__c = AccessToken;
                record[0].ExpireTime__c = System.now().addHours(4);
                update record;
                System.debug('Record Updated !!!!!!');
            }   
            return 'Token exist';

        }
        // else if(valuesMap.get('MethodName') == 'getData'){
        //     System.debug('getData Response :' + result);
        //     return result;
        //    // return h.send(req);

        // }

        return null;


    }
    
    public static HttpResponse dropboxData(Map<String,String> valuesMap){
        HttpRequest req = new HttpRequest();
        req.setMethod(valuesMap.get('Method'));
        req.setEndpoint(valuesMap.get('EndPoint'));
        req.setHeader('Content-type', valuesMap.get('Content-type'));
        req.setHeader('Authorization', valuesMap.get('Authorization'));
        req.setBody(valuesMap.get('Body'));

        Http h = new Http();
        HttpResponse resp = h.send(req);
        System.debug('request body : '+resp.getBody());
        String result = resp.getBody();

        return h.send(req);


    }

    public static String createNewFolder(Map<String,String> valuesMap){
        System.debug('Hii from Create New Folder from service class');
        HttpRequest req = new HttpRequest();
        req.setMethod(valuesMap.get('Method'));
        req.setEndpoint(valuesMap.get('EndPoint'));
        req.setHeader('Content-type', valuesMap.get('Content-type'));
        req.setHeader('Authorization', valuesMap.get('Authorization'));
        req.setBody(valuesMap.get('Body'));

        Http h = new Http();
        HttpResponse resp = h.send(req);
        System.debug('request body : '+resp.getBody());
        String result = resp.getBody();
        return result;

        //return h.send(req);
    }

    public static String deleteFileAndFolder(Map<String,String> valuesMap){
        HttpRequest req = new HttpRequest();
        req.setMethod(valuesMap.get('Method'));
        req.setEndpoint(valuesMap.get('EndPoint'));
        req.setHeader('Content-type', valuesMap.get('Content-type'));
        req.setHeader('Authorization', valuesMap.get('Authorization'));
        req.setBody(valuesMap.get('Body'));

        Http h = new Http();
        HttpResponse res = h.send(req);
        System.debug('Status code :' + res.getStatusCode());
        String resp = res.getBody();
        System.debug('Response :' + resp);
        Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(resp) ; 
        if(res.getStatusCode() == 200){
            return 'Folder was deleted';
        }else{
            return 'error';
        }
    }

    public static String downloadFile(Map<String,String> valuesMap){
        HttpRequest req = new HttpRequest();
        req.setMethod(valuesMap.get('Method'));
        req.setEndpoint(valuesMap.get('EndPoint'));
        req.setHeader('Content-type', valuesMap.get('Content-type'));
        req.setHeader('Authorization', valuesMap.get('Authorization'));
        req.setBody(valuesMap.get('Body'));

        Http h = new Http();
        HttpResponse res = h.send(req);
        System.debug('Status code :' + res.getStatusCode());
        String resp = res.getBody();
        System.debug('Response :' + resp);
        return resp;
        

    }




}