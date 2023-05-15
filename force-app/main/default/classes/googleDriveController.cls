/*============================================================================================
Description : Class (googleDriveController) is to integrate Googledrive with salesforce
Created By : Ruchi Chourasia
Created Date : 

===============================================================================================*/
public with sharing class googleDriveController {
    //API Secret Key
    //private static string key = '896464981308-ha1q6p6l53nlq3j70btun10hg0t13ro4.apps.googleusercontent.com';
    private static String key = Drive__mdt.getInstance('GoogleDrive').AppKey__c;   //Accessing specific record: : ObjectName__mdt.getInstance('RecordName');
    //API Secret
    //private static string secret = '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';
    private static String secret = Drive__mdt.getInstance('GoogleDrive').AppSecret__c;
    //API Redirect. Lightning Tab or Lightning community URL
    private static string redirect_uri = 'https://drive-integration-developer-edition.ap27.force.com/s/google-drive';
    private static string authUrl='https://accounts.google.com/o/oauth2/auth';
    private static string scope='https://www.googleapis.com/auth/drive';
    private static string tokenUrl='https://oauth2.googleapis.com/token';

    @AuraEnabled
    public static String getUserInfo(){
     // System.debug('Key is :' + key1);
      System.debug('Hello from getuserInfo');
      List<Drive__mdt> result = [SELECT AppKey__c, AppSecret__c FROM Drive__mdt];
      system.debug(result); 
      try {
        List<Integration_Access__c> integrationUserDetails = [
          SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c,Contact__c 
          FROM Integration_Access__c 
          WHERE userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'
        ];

        if(integrationUserDetails.isEmpty()){
          String authCode = createAuthURL();
          return authCode;
        }
        else{
         if(integrationUserDetails[0].Access_Token__c != null ){ //Acess Token not null
              if(integrationUserDetails[0].ExpireTime__c < System.now()){
                  
                
                if(integrationUserDetails[0].Refresh_Token__c != null ){
             
                  String newAccessToken = getRefreshToken();  //refresh token to access token
                  return newAccessToken;
                  //return 'refresh token to access token';
                }else {
                  String authCode = createAuthURL();
                  return authCode;
                }
              }
              else{
              
                return 'Access Token Exist';
              }
            }else{
             
              if(integrationUserDetails[0].Refresh_Token__c != null ){
                
                String newAccessToken = getRefreshToken();  //refresh token to access token
                return newAccessToken;
                
              }else {
                String authCode = createAuthURL();
                return authCode;
              }
              
          }
          
        }
      }catch(Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    } 
/******************************************************************************* 
*    Description     :      This method is use for authentication (get Auth url)
*
*    Arguments       :      No arguments
*     
*    Return Types    :      String
*
*********************************************************************************/      
  public static String createAuthURL() {
    String key = EncodingUtil.urlEncode(key,'UTF-8');
    String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
    String authuri = '';
    authuri = 'https://accounts.google.com/o/oauth2/auth?'+
    'client_id='+key+
    '&response_type=code'+
    '&scope=https://www.googleapis.com/auth/drive'+
    '&redirect_uri='+uri+
    '&access_type=offline'+
    '&prompt=consent';
     return authuri;
  }

   /* 
    Http Class : use this class to initiate an http request and response.
    HttpRequest Class : use this class to programmatically create HTTP request like Get ,POST,PUT and DELETE.
    HttpResponse Class : Use this class to handle the HTTP response return by HTTP.

    */
/********************************************************************************** 
*    Description     :      This method is used to get access token using auth code
*
*    Arguments       :      String authcode
*     
*    Return Types    :      String
*
************************************************************************************/
  @AuraEnabled
  public static String getAccessToken(String code){
    //Getting access token from google

    String messageBody = 'code='+code+'&access_type=offline'+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
    Map<String,String> valuesMap = new Map<String,String>();
    valuesMap.put('EndPoint', 'https://accounts.google.com/o/oauth2/token');
    valuesMap.put('Method', 'POST');
    valuesMap.put('content-type', 'application/x-www-form-urlencoded');
    valuesMap.put('Content-length',  String.valueOf(messageBody.length()));
    valuesMap.put('Body', messageBody);
    valuesMap.put('MethodName' , 'getAccessToken');
    String response = GoogleDriveServiceController.handleRequest(valuesMap);
    System.debug('Access Token Response is :' + response);
    return response;

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
  public static String getRefreshToken(){
    System.debug('Call Refresh Token method');
    List<Integration_Access__c> record = [select Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, Contact__c from Integration_Access__c where userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
    String refreshToken = record[0].Refresh_Token__c;
    String messageBody = 'refresh_token='+refreshToken+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=refresh_token';
    Map<String,String> valuesMap = new Map<String,String>();
    valuesMap.put('Method', 'POST');
    valuesMap.put('EndPoint', 'https://accounts.google.com/o/oauth2/token');
    valuesMap.put('content-type', 'application/x-www-form-urlencoded');
    valuesMap.put('Content-length',  String.valueOf(messageBody.length()));
    valuesMap.put('Body',messageBody);
    valuesMap.put('MethodName' , 'getRefreshToken');
    String response = GoogleDriveServiceController.handleRequest(valuesMap);
    return response;
  }

/****************************************************************************************** 
*    Description     :      This method is used to fetch files and folders from googleDrive
*
*    Arguments       :      No arguments
*     
*    Return Types    :      String
*
*******************************************************************************************/  
    @AuraEnabled
    public static String getFiles(String parentId){
      List<Integration_Access__c> record = [select Id, Access_Token__c,ExpireTime__c, Refresh_Token__c , Contact__c from Integration_Access__c where userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
      String accessToken = record[0].Access_Token__c;
      Map<String,String> valuesMap = new Map<String,String>();
      valuesMap.put('Method', 'GET');
      valuesMap.put('EndPoint', 'https://www.googleapis.com/drive/v3/files?q=\''+parentId+'\'+in+parents');
      valuesMap.put('Authorization', 'Bearer' + ' ' +accessToken);
      valuesMap.put('content-type', 'application/x-www-form-urlencoded');
      valuesMap.put('MethodName' , 'getFiles');
      String response = GoogleDriveServiceController.handleRequest(valuesMap);
      return response;
    }
/*********************************************************************************** 
*    Description     :      This method is used to create new folder in googledrive
*
*    Arguments       :      String , String
*     
*    Return Types    :      String
*
*************************************************************************************/     
    @AuraEnabled
    public static String createFolder(String folderName , String parentId) {
      System.debug('Create Folder Method Call');
      List<Integration_Access__c> record = [select Id, Access_Token__c,ExpireTime__c, Refresh_Token__c , Contact__c from Integration_Access__c where userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
      String accessToken = record[0].Access_Token__c;
      String body = '{"name" : "'+ folderName +'","mimeType" : "application/vnd.google-apps.folder"}';
      if(parentId != null) {
        body = '{"name" : "'+ folderName +'","mimeType" : "application/vnd.google-apps.folder","parents" : ["'+ parentId +'"]}';
      }
      Map<String,String> valuesMap = new Map<String,String>();
      valuesMap.put('Method', 'POST');
      valuesMap.put('EndPoint', 'https://www.googleapis.com/drive/v3/files?q=\''+parentId+'\'+in+parents');
      valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
      valuesMap.put('content-type', 'application/json');
      valuesMap.put('Body', body);
      valuesMap.put('MethodName' , 'createFolder');
      String response = GoogleDriveServiceController.handleRequest(valuesMap);
      return response;

    }
/*********************************************************************************** 
*    Description     :      This method is used to delete folder from googledrive
*
*    Arguments       :      String 
*     
*    Return Types    :      String
*
*************************************************************************************/     
    @AuraEnabled
    public static string deleteFolder(String folderId){
      List<Integration_Access__c> record = [select Id, Access_Token__c,ExpireTime__c, Refresh_Token__c , Contact__c from Integration_Access__c where userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
      String accessToken = record[0].Access_Token__c;
      Map<String,String> valuesMap = new Map<String,String>();
      valuesMap.put('Method','DELETE');
      valuesMap.put('EndPoint', 'https://www.googleapis.com/drive/v2/files/'+folderId);
      valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
      valuesMap.put('MethodName' , 'deleteFolder');
      String response = GoogleDriveServiceController.handleRequest(valuesMap);
      return response;

    }
/*********************************************************************************** 
*    Description     :      This method is used to download file from googledrive
*
*    Arguments       :      String 
*     
*    Return Types    :      String
*
*************************************************************************************/   
    @AuraEnabled
    public static string downloadFileData(String fileId){
      List<Integration_Access__c> record = [select Id, Access_Token__c,ExpireTime__c, Refresh_Token__c , Contact__c from Integration_Access__c where userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
      String accessToken = record[0].Access_Token__c;
      Map<String,String> valuesMap = new Map<String,String>();
      valuesMap.put('Method','GET');
      valuesMap.put('EndPoint', 'https://www.googleapis.com/drive/v2/files/'+ fileId);
      valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
      valuesMap.put('MethodName' , 'downloadFileData');
      String response = GoogleDriveServiceController.handleRequest(valuesMap);
      System.debug('Download file Response :' + response);
      return response;

    }
/*********************************************************************************** 
*    Description     :      This method is used to upload file in googledrive
*
*    Arguments       :      String , String
*     
*    Return Types    :      String
*
*************************************************************************************/     
      
    @AuraEnabled
    public static String uploadFile(String fileBody, String boundary){
      List<Integration_Access__c> record = [select Id, Access_Token__c,ExpireTime__c, Refresh_Token__c , Contact__c from Integration_Access__c where userId__c =: userInfo.getUserId() AND RecordType.name = 'Google Drive'];
      String accessToken = record[0].Access_Token__c;
      Map<String,String> valuesMap = new Map<String,String>();
      valuesMap.put('Method','POST');
      valuesMap.put('EndPoint', 'https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart');
      valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
      valuesMap.put('content-type', 'multipart/mixed; boundary="' + boundary + '"');
      valuesMap.put('Content-length', String.valueOf(fileBody.length()));
      valuesMap.put('Body', fileBody);
      valuesMap.put('MethodName' , 'uploadFile');
      String response = GoogleDriveServiceController.handleRequest(valuesMap);
      System.debug('Download file Response :' + response);
      return response;
     
    }   
}