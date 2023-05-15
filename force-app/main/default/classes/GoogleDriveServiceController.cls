/*=============================================================================
Description : Service class for http callout for Googledrive integration
Created By : Ruchi Chourasia
Created Date : 

================================================================================*/
public with sharing class GoogleDriveServiceController {
    
    public static String handleRequest(Map<String,String> valuesMap){

        HttpRequest req = new HttpRequest();
        req.setMethod(valuesMap.get('Method'));
        req.setEndpoint(valuesMap.get('EndPoint'));
        // req.setHeader('content-type', valuesMap.get('content-type'));
        //req.setHeader('Content-length', valuesMap.get('Content-length'));

        if(valuesMap.get('MethodName') == 'getAccessToken'){
            System.debug('Call getAccessToken');
            req.setHeader('content-type', valuesMap.get('content-type'));
            req.setHeader('Content-length', valuesMap.get('Content-length'));
            req.setBody(valuesMap.get('Body'));
            req.setTimeout(60000); // timeout in milliseconds - this is one minute
           // req.setTimeout(60*1000);
        }
        else if(valuesMap.get('MethodName') == 'getRefreshToken'){
            System.debug('Call getRefreshToken');
           
            req.setHeader('content-type', valuesMap.get('content-type'));
            req.setHeader('Content-length', valuesMap.get('Content-length'));
            req.setBody(valuesMap.get('Body'));
            System.debug(req.getHeader('content-type'));
            System.debug(req.getHeader('Content-length'));
            System.debug(req.getBody());
        }
        else if(valuesMap.get('MethodName') == 'getFiles'){
            System.debug('Hii From getFiles method');
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            req.setHeader('content-type', valuesMap.get('content-type'));

            
        }
        else if(valuesMap.get('MethodName') == 'createFolder'){
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            req.setHeader('content-type', valuesMap.get('content-type'));
            req.setBody(valuesMap.get('Body'));
        }
        else if(valuesMap.get('MethodName') == 'deleteFolder'){
            req.setHeader('Authorization', valuesMap.get('Authorization'));
        }
        else if(valuesMap.get('MethodName') == 'downloadFileData'){
            System.debug('Hi from DownloadData');
            req.setHeader('Authorization', valuesMap.get('Authorization'));
        }
        else if(valuesMap.get('MethodName') == 'uploadFile'){
            req.setHeader('Authorization', valuesMap.get('Authorization'));
            req.setHeader('content-type', valuesMap.get('content-type'));
            req.setHeader('Content-length', valuesMap.get('Content-length'));
            req.setBody(valuesMap.get('Body'));

        }

        Http h = new Http();
        String resp;
        System.debug(' request body : '+req.getBody());
        HttpResponse res = h.send(req);
        
        resp = res.getBody();
        //System.debug('Response : ' + resp);

       
        if(valuesMap.get('MethodName') == 'getAccessToken'){
            System.debug('GetAccessToken Method Calllll!!!!!!!!!!!!!!!');
           

            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(res.getBody()) ; 
            String code = String.valueOf(res.getStatuscode());
            
            String AccessToken =  String.valueOf(responseMap.get('access_token'));
            System.debug('AccessToken :'+ AccessToken);
            String RefreshToken  =  String.valueOf(responseMap.get('refresh_token'));
            System.debug('RefreshToken : '+ RefreshToken);
            System.debug('Access Token :  Status code :' + code);
            /*



            */
            List<Integration_Access__c> integrationUserDetails = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c,Contact__c FROM Integration_Access__c WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
            System.debug('record===='+integrationUserDetails);
            System.debug('size===='+integrationUserDetails.size());

            if(!integrationUserDetails.isEmpty()){
                integrationUserDetails[0].Access_Token__c = AccessToken;
                integrationUserDetails[0].Refresh_Token__c = RefreshToken;
                integrationUserDetails[0].ExpireTime__c = System.now().addHours(1);
                System.debug('Record Update');
                update integrationUserDetails;
            }else{
                System.debug('Record Insert');
                Integration_Access__c obj = new Integration_Access__c();
                obj.RecordTypeId = '0125j000001ZrffAAC';
                obj.Access_Token__c = AccessToken;
                obj.Refresh_Token__c = RefreshToken;
                obj.userId__c = userInfo.getUserId();
                obj.ExpireTime__c = System.now().addHours(1);
                obj.Name = 'User1';
                //obj.userId__c = userInfo.getUserId();

                System.debug('Record Insert');
                insert obj;
            }
            
            return 'Access Token Exist';
        }
        else if(valuesMap.get('MethodName') == 'getRefreshToken'){
            List<Integration_Access__c> record = [select Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, Contact__c from Integration_Access__c where userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
            Map<String, Object> mapResponse = (Map<String, Object>)json.deserializeUntyped(res.getBody());
            String AccToken = String.valueOf(mapResponse.get('access_token'));
            System.debug('Refresh : AccessToken : ' + AccToken);

            record[0].Access_Token__c = AccToken;
            record[0].ExpireTime__c = System.now().addHours(1);
            update record;
            System.debug('Record Updated !!!!!!');
            
            return 'Access Token Exist';
        }
        else if(valuesMap.get('MethodName') == 'getFiles'){
            System.debug('Response from getfiles method');
            return resp;
        }
        else if(valuesMap.get('MethodName') == 'createFolder'){
            return resp;
        }
        else if(valuesMap.get('MethodName') == 'deleteFolder'){
            //return resp;
            return String.valueOf(res.getStatuscode());
        }
        else if(valuesMap.get('MethodName') == 'downloadFileData'){
           // return resp;
            System.debug('Download File response');
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(res.getBody()) ; 
            String downloadLink = String.valueOf(responseMap.get('webContentLink'));
            System.debug('ResponseMap Link:' + downloadLink);

            return downloadLink;
            
        }else if(valuesMap.get('MethodName') == 'uploadFile'){
            System.debug('Upload File Response : ' + resp);
            return resp;
        }
        return null;

    }
}