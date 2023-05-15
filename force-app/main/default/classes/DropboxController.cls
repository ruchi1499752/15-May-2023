/*=============================================================================
Description : Class (DropboxController) is to integrate Dropbox with salesforce
Created By : Ruchi Chourasia
Created Date : 

================================================================================*/
public with sharing class DropboxController {
    private static String key = DropBox__mdt.getInstance('DropBox').App_key__c;
    private static String secret = DropBox__mdt.getInstance('DropBox').App_secret__c;
    private static String RedirectURI = DropBox__mdt.getInstance('DropBox').RedirectURI__c;
    
/************************************************************************************* 
*    Description     :      This method is used to check user exist in dropbox or not
*
*    Arguments       :      No arguments
*     
*    Return Types    :      String
*
**************************************************************************************/    
    @AuraEnabled
    public static string getUserInfo(){
        try {
            List<Integration_Access__c> integrationUserDetails = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            System.debug('integrationUserDetails :' + integrationUserDetails);

            if(integrationUserDetails.size()>0){
                System.debug('If part 1');
                if(integrationUserDetails[0].Access_Token__c != null){
                    System.debug('If part 2');
                    if(integrationUserDetails[0].ExpireTime__c < System.now()){
                        System.debug('If part 3');
                        if(integrationUserDetails[0].Refresh_Token__c != null){
                            System.debug('If part 4');
                            String newAccessToken = getRefreshToken();  //refresh token to access token
                            return newAccessToken;
                        }
                        else{
                            String url = getAuthUrl();
                            return url;
                        }
                    }
                    else{
                        System.debug('else part 1');
                        return 'Token exist';
                    }
                }
                else{
                    System.debug('Else part 2');
                    if(integrationUserDetails[0].Refresh_Token__c != null ){
                        String newAccessToken = getRefreshToken();  //refresh token to access token
                        return newAccessToken;
                        
                    }else {
                        String url = getAuthUrl();
                        return url;
                    }
                }
            }
            else{
                String url = getAuthUrl();
                return url;

            }

        } 
        catch (Exception e) {
            System.debug('GetUserInfo exception :' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
//  @AuraEnabled (cacheable=true) : To set cacheable=true , a method must only get data. It can't mutate data.
/******************************************************************************* 
*    Description     :      This method is use for authentication (get Auth url)
*
*    Arguments       :      No arguments
*     
*    Return Types    :      String
*
*********************************************************************************/
    @AuraEnabled  
    public static string getAuthUrl(){
        system.debug('Key is :' + key);
        System.debug('Secret is :' + secret);
        system.debug('RedirectURI :' + RedirectURI);
        try {
            String authuri = '';
            authuri = 'https://www.dropbox.com/oauth2/authorize?'+
            'client_id='+key+
            '&response_type=code'+
            '&redirect_uri='+RedirectURI+
            '&token_access_type=offline';
            System.debug('Auth Uri :' + authuri);
            return authuri;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
/********************************************************************************** 
*    Description     :      This method is used to get access token using auth code
*
*    Arguments       :      String authcode
*     
*    Return Types    :      String
*
************************************************************************************/
    @AuraEnabled
    public static string getAccessToken(String authCode){
        try {
            System.debug('Code is :' + authcode);
            System.debug('Key :' + key);
            System.debug('Secret :' + secret);
            System.debug('RedirectUri :' + RedirectURI);
            Map<String,String> valuesMap = new Map<String,String>();
            String messageBody ='code='+authCode+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+RedirectURI+'&grant_type=authorization_code'; 
            System.debug('Message Body :' + messageBody);
            valuesMap.put('Method', 'POST');
            valuesMap.put('Content-type', 'application/x-www-form-urlencoded');
            valuesMap.put('EndPoint', 'https://api.dropboxapi.com/oauth2/token');
            valuesMap.put('Body', messageBody);
            valuesMap.put('MethodName', 'getAccessToken');
            String response = DropboxService_Class.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;
        } 
        catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
/************************************************************************************ 
*    Description     :      This method is used to get access token via Refresh Token
*
*    Arguments       :      No arguments
*     
*    Return Types    :      String
*
*************************************************************************************/
    @AuraEnabled
    public static string getRefreshToken(){
        try {
            List<Integration_Access__c> record = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            String refreshToken = record[0].Refresh_Token__c;
            System.debug('Refresh Token  :' + refreshToken);
            Map<String,String> valuesMap = new Map<String,String>();
            String messageBody = 'refresh_token='+refreshToken+'&client_id='+key+'&client_secret='+secret+'&grant_type=refresh_token'; 
            System.debug('Message Body :' + messageBody);
            valuesMap.put('Method', 'POST');
            valuesMap.put('EndPoint', 'https://api.dropboxapi.com/oauth2/token');
            valuesMap.put('Body', messageBody);
            valuesMap.put('MethodName', 'getRefreshToken');
            String response = DropboxService_Class.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;
        } catch (Exception e) {
            system.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }   
/************************************************************************************** 
*    Description     :      This method is used to fetch files and folders from dropbox
*
*    Arguments       :      No arguments
*     
*    Return Types    :      List of Wrapper Class
*
*************************************************************************************/    
    @AuraEnabled
   // List<DropBoxWrapperClass.DropBoxData>  List<DropBoxWrapperClass.entries>
    public static List<DropBoxWrapperClass.entries> getData(String parentId){
        
        try {
            List<Integration_Access__c> record = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            String accessToken = record[0].Access_Token__c;
            System.debug('Access Token  :' + accessToken);

            Map<String,String> valuesMap = new Map<String,String>();
            String body ='{\"include_deleted\":false,\"include_has_explicit_shared_members\":false,\"include_media_info\":false,\"include_mounted_folders\":true,\"include_non_downloadable_files\":true,\"path\":"'+parentId+'",\"recursive\":false}';
            System.debug('Message Body :' + body);
            valuesMap.put('Method', 'GET');
            valuesMap.put('EndPoint','https://api.dropboxapi.com/2/files/list_folder');
            valuesMap.put('Content-type', 'application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +accessToken);
            valuesMap.put('Body', body);
            valuesMap.put('MethodName', 'getData');
            HttpResponse response = DropboxService_Class.dropboxData(valuesMap);
            System.debug('Dropbox Data Response is :' + response);
            
            if(response.getStatusCode() == 200){
                String resp = response.getBody();
                String getTag = resp.replace('.tag', 'tag');
                System.debug('Response : ' + resp);
                System.debug('Tag is :' + getTag);
                DropBoxWrapperClass.DropBoxData data = (DropBoxWrapperClass.DropBoxData)JSON.deserialize(getTag, DropBoxWrapperClass.DropBoxData.class);
                System.debug('Entries :' + data.entries);
                return data.entries;
            }
            else{
                System.debug('Else part of dropbox data');
                // delete record;
                // getUserInfo();
                System.debug('Bad Request');
                

                return null;
            }
            
          
        } catch (Exception e) {
            System.debug('GetData Exception :'+ e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
/*********************************************************************************** 
*    Description     :      This method is used to create new folder in dropbox 
*
*    Arguments       :      String , String
*     
*    Return Types    :      String
*
*************************************************************************************/ 
    @AuraEnabled
    public static String createFolder(String folderName , String path){
        System.debug('Hii from CreateFolder!!!!');
        System.debug('Folder Name :' + folderName);
        try {
            List<Integration_Access__c> record = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            String accessToken = record[0].Access_Token__c;
            System.debug('Access Token  :' + accessToken);

            Map<String,String> valuesMap = new Map<String,String>();
            String body ='{ "path": "' + path + '/' + folderName + '", "autorename": false }';
            valuesMap.put('Method', 'POST');
            valuesMap.put('EndPoint','https://api.dropboxapi.com/2/files/create_folder');
            valuesMap.put('Content-type', 'application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +accessToken);
            valuesMap.put('Body', body);
            valuesMap.put('MethodName', 'createFolder');
            String response = DropboxService_Class.createNewFolder(valuesMap);
            System.debug('Create New Folder Response is :' + response);
            return response;
            // if(response.getStatusCode() == 200){

            // }
            
        } catch (Exception e) {
            System.debug('Create folder Exception :' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
/*********************************************************************************** 
*    Description     :      This method is used to delete folder from dropbox 
*
*    Arguments       :      String 
*     
*    Return Types    :      String
*
*************************************************************************************/ 
    @AuraEnabled
    public static string deleteFolder(String path){
        try {
            List<Integration_Access__c> record = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            String accessToken = record[0].Access_Token__c;
            System.debug('Access Token  :' + accessToken);

            Map<String,String> valuesMap = new Map<String,String>();
            String body = '{ "path": "' + path + '"}';
            valuesMap.put('Method', 'POST');
            valuesMap.put('EndPoint','https://api.dropboxapi.com/2/files/delete_v2');
            valuesMap.put('Content-type', 'application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +accessToken);
            valuesMap.put('Body', body);
            valuesMap.put('MethodName', 'deleteFolder');
            String response = DropboxService_Class.deleteFileAndFolder(valuesMap);
            System.debug('Delete file And Folder Response is :' + response);
            return response;
           
        } catch (Exception e) {
            System.debug('Delete Exception :'+ e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
/*********************************************************************************** 
*    Description     :      This method is used to download file from dropbox 
*
*    Arguments       :      String
*     
*    Return Types    :      String
*
*************************************************************************************/ 
    @AuraEnabled
    public static string downloadDropboxFile(String path){
        try {
            List<Integration_Access__c> record = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            String accessToken = record[0].Access_Token__c;
            System.debug('Access Token  :' + accessToken);

            Map<String,String> valuesMap = new Map<String,String>();
            String body = '{"path": "' + path + '"}';
            valuesMap.put('Method', 'POST');
            valuesMap.put('EndPoint','https://api.dropboxapi.com/2/files/get_temporary_link');
            valuesMap.put('Content-type', 'application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +accessToken);
            valuesMap.put('Body', body);
            valuesMap.put('MethodName', 'downloadDropboxFile');
            String response = DropboxService_Class.downloadFile(valuesMap);
            System.debug('Download file Response is :' + response);
            return response;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
/*********************************************************************************** 
*    Description     :      This method is used to upload file in dropbox 
*
*    Arguments       :      String , String, String
*     
*    Return Types    :      String
*
*************************************************************************************/ 
    @AuraEnabled
    public static string UploadFile(String path, String fileName, String fileBody){
        try {
            List<Integration_Access__c> record = [
                SELECT Id, Access_Token__c, Refresh_Token__c , 	ExpireTime__c, userId__c 
                FROM Integration_Access__c 
                WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'DropBox'
            ];
            String accessToken = record[0].Access_Token__c;
            System.debug('Access Token  :' + accessToken);

            String boundary = '----------FILEBOUNDARY';
            String bodyEncoded = fileBody;
            Blob bodyEncoded2 = EncodingUtil.base64Decode(bodyEncoded);
         

            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            req.setHeader('Authorization', 'Bearer' + ' ' +accessToken);
            req.setHeader('Content-Type', 'application/octet-stream');
            req.setHeader('Content-length', String.valueOf(bodyEncoded.length()));
        
        
            String body = '{"autorename":false, "mode":"add","mute":false,"path":"' + path + '/'+ fileName +'","strict_conflict":false}';
            req.setHeader('Dropbox-API-Arg', body);
            req.setBodyAsBlob(bodyEncoded2);

            Http h = new Http();
            HttpResponse resp = h.send(req);
            System.debug('request body : '+resp.getBody());
            String result = resp.getBody();
            return result;

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}