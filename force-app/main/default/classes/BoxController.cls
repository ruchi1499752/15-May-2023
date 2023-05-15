public with sharing class BoxController {
    //API Secret Key
    public static  String key = '7xx3tfnsbnbhu35r5tbgm3yjg4lzyhn1';
    public static String uri = 'https://drive-integration-developer-edition.ap27.force.com/s/box';
    //API Secret
    private static string secret = 'etHc7bEYgCPwuiASAnbGhreoIzV63BnW';

    @AuraEnabled
    public static string getUserInfo(){
        System.debug('User Info Method Call');
        try {
            System.debug('try block');
            List<Box_Integration__c> integrationUserDetails = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c WHERE userId__c =: userInfo.getUserId()];
            
            if(integrationUserDetails.isEmpty()){
                System.debug('null check');
                String authCode = createAuthURL();
                return authCode;
            }
            else{
                System.debug('Else part run');
                System.debug('Access Token : ' + integrationUserDetails[0].Access_Token__c);

                if(integrationUserDetails[0].Access_Token__c != null ){
                    System.debug('Else part 1');
                    if(integrationUserDetails[0].ExpireTime__c < System.now()){
                        System.debug('Else part 2');
                        if(integrationUserDetails[0].Refresh_Token__c != null){
                            System.debug('Else part 3');
                            String newAccessToken = refreshAccessToken();
                            return newAccessToken;
                        }
                        else{
                            String authUrl = createAuthURL();
                            return authUrl;
                        }
                    }
                    else{
                        System.debug('TestCase 4');
                        return 'Token Exist';
                
                    }
                }
                else{
                    System.debug('Else part');
                    if(integrationUserDetails[0].Refresh_Token__c != null ){
                        String newAccessToken = refreshAccessToken();
                        return newAccessToken;
                    }else{
                        String authCode = createAuthURL();
                        return authCode;
                    }
                }
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
   
    public static String createAuthURL() {
      
        String authuri = '';
        authuri = 'https://account.box.com/api/oauth2/authorize?'+
        'client_id='+key+
        '&response_type=code'+
        '&redirect_uri='+uri;
         System.debug('auth url is : ' + authuri);
         return authuri;
      
    }
    @AuraEnabled
    public static String requestAccessToken(String code){
        System.debug('Code : ' + code);
        try {
            
            String messageBody ='code='+code+'&access_type=offline'+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+uri+'&grant_type=authorization_code';
            Map<String,String> valuesMap = new Map<String,String>();
            valuesMap.put('Method', 'POST');
            valuesMap.put('EndPoint','https://api.box.com/oauth2/token');
            valuesMap.put('Content-type', 'application/x-www-form-urlencoded');
            valuesMap.put('Content-length',  String.valueOf(messageBody.length()));
            valuesMap.put('Body', messageBody);
            valuesMap.put('MethodName', 'requestAccessToken');
            String response =BoxServiceClass.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string refreshAccessToken(){
        System.debug('Hii from RefreshAccessToken ');
        try {
            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            String refreshToken = record[0].Refresh_Token__c;
            System.debug('Refresh Token :' + refreshToken);

            Map<String,String> valuesMap = new Map<String,String>();
            String messageBody = 'refresh_token='+refreshToken+'&client_id='+key+'&client_secret='+secret+'&grant_type=refresh_token';
            valuesMap.put('Method', 'POST');
            valuesMap.put('EndPoint','https://api.box.com/oauth2/token');
            valuesMap.put('Content-type', 'application/x-www-form-urlencoded');
            valuesMap.put('Body', messageBody);
            valuesMap.put('MethodName', 'refreshAccessToken');
            String response =BoxServiceClass.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string getAllfilesAndFolders(String folderId){
        System.debug('Hii from getAllfilesAndFolders');
        try {
            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            String accessToken = record[0].Access_Token__c;
            System.debug('BoxData : Access Token :' + accessToken);

            Map<String,String> valuesMap = new Map<String,String>();
            valuesMap.put('Method', 'GET');
            valuesMap.put('EndPoint','https://api.box.com/2.0/folders/'+folderId+'/items');
            valuesMap.put('Content-type','application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
            valuesMap.put('MethodName', 'getAllfilesAndFolders');
            String response =BoxServiceClass.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string createFolder(String folderName, String parentId){
        try {
            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            String accessToken = record[0].Access_Token__c;
            System.debug('Create folder Access Token :' + accessToken );
            
            Map<String,String> valuesMap = new Map<String,String>();
            valuesMap.put('Method', 'POST');
            valuesMap.put('EndPoint','https://api.box.com/2.0/folders');
            valuesMap.put('Content-type','application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
            //The root folder of a Box account is always represented by the id “0”.
            //string messageBody= '{"name": "'+folderName+'","parent" : {"id": "0"}}';
            string messageBody= '{"name": "'+folderName+'","parent" : {"id": "'+parentId+'"}}';
            /* if(parentId != null) {
          		messageBody = '{"name" : "'+ folderName +'","parents" : ["id": "'+ parentId +'"]}';
        	}*/
            valuesMap.put('Body', messageBody);

            valuesMap.put('MethodName', 'createFolder');
            String response =BoxServiceClass.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string deleteFolder(String folderId){
        try {
            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            String accessToken = record[0].Access_Token__c;
            System.debug('Delete folder Access Token :' + accessToken );

            Map<String,String> valuesMap = new Map<String,String>();
            valuesMap.put('Method', 'DELETE');
            valuesMap.put('EndPoint','https://api.box.com/2.0/folders/'+ folderId);
            valuesMap.put('Content-type','application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
            valuesMap.put('MethodName', 'deleteFolder');
            String response =BoxServiceClass.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string deleteFile(String fileId){
        try {
            System.debug('File id :' + fileId);

            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            System.debug(record.size());
            System.debug(record[0].Access_Token__c);
            String accessToken = record[0].Access_Token__c;

            System.debug('Delete file Access Token :' + accessToken );
            Map<String,String> valuesMap = new Map<String,String>();
            valuesMap.put('Method', 'DELETE');
            valuesMap.put('EndPoint','https://api.box.com/2.0/files/'+fileId);
            valuesMap.put('Content-type','application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
            valuesMap.put('MethodName', 'deleteFile');
            String response =BoxServiceClass.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string downloadBoxFile(String fileId){
        try {
            System.debug('File id :' + fileId);
            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            String accessToken = record[0].Access_Token__c;
            System.debug('Delete file Access Token :' + accessToken );

            Map<String,String> valuesMap = new Map<String,String>();
            valuesMap.put('Method', 'GET');
            valuesMap.put('EndPoint','https://api.box.com/2.0/files/'+fileId+'/content');
            valuesMap.put('Content-type','application/json');
            valuesMap.put('Authorization', 'Bearer' + ' ' +  accessToken);
            valuesMap.put('MethodName', 'downloadBoxFile');
            String response =BoxServiceClass.handleRequest(valuesMap);
            System.debug('Access Token Response is :' + response);
            return response;

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Code to upload files to BOX.COM
    @AuraEnabled
    //String fileName, String folderId 
    public static string uploadFile(String base64, String fileName, String folderId){
        System.debug('Hii from uploadFile Method ');
        try {
            List<Box_Integration__c> record = [SELECT Id, Access_Token__c, Refresh_Token__c , ExpireTime__c, userId__c FROM Box_Integration__c where userId__c =: userInfo.getUserId()];
            String accessToken = record[0].Access_Token__c;
            System.debug('Delete file Access Token :' + accessToken );

            blob base64EncodeFile = base64EncodeFileContent(EncodingUtil.base64Decode(base64), fileName);
            String boundary = '------------------6478FileBoundary';
            String fileBody = '{"name":"' + fileName + '", "parent":{"id":"' + folderId + '"}}';
            System.debug('File Body is :' + fileBody);

            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+folderId);
            req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
            req.setHeader('Authorization', 'Bearer '+ accessToken);
            req.setHeader('Content-length', String.valueOf(fileBody.length()));
            req.setBody(fileBody);
           // req.setBodyAsBlob(base64EncodeFile);
            
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('===== Response==='+ res.getBody());
            String resp = res.getBody();
            return resp;
            //System.debug('Download File: StatusCode :' + res.getStatusCode());
            //return String.valueOf(res.getStatuscode()); 
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    public static blob base64EncodeFileContent(Blob file_body, String file_name){
        String boundary = '----------------------------741e90d31eff';
        String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+file_name+'";\nContent-Type: application/octet-stream';
        String footer = '--'+boundary+'--';             
        String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
        while(headerEncoded.endsWith('='))
        {
            header+=' ';
            headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
        }
        String bodyEncoded = EncodingUtil.base64Encode(file_body);
        Blob bodyBlob = null;
        String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
  
        if(last4Bytes.endsWith('==')) {
            last4Bytes = last4Bytes.substring(0,2) + '0K';
            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
        } else if(last4Bytes.endsWith('=')) {
            last4Bytes = last4Bytes.substring(0,3) + 'N';
            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
            footer = '\n' + footer;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);              
        } else {
            footer = '\r\n' + footer;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
        }
  
        return bodyBlob;
    }
}