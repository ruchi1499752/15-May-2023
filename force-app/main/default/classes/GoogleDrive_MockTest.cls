@isTest
public with sharing class GoogleDrive_MockTest implements HttpCalloutMock{
    
    public HTTPResponse respond(HTTPRequest req) {
        String method = req.getMethod();
        System.debug('Method is ' + method);
        String endPoint = req.getEndpoint();
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        
        
        res.setBody('{"kind": "drive#file","id": "1vDmGPcyzCHc471SxBwYUqOXoxzxBwoFi","name": "LWC","mimeType": "application/vnd.google-apps.folder"}');
      // Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(res.getBody());
        //res.setStatusCode(200);
       
        //For AccessToken
        if(req.getEndpoint() == 'https://example.com/example/test'){
            
        	String code = 'klgbkfbjlfjv55875464';
            String key = '896464981308-ha1q6p6l53nlq3j70btun10hg0t13ro4.apps.googleusercontent.com';
            String secert = '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';
            String redirect_uri = 'https://drive-integration-developer-edition.ap27.force.com/s/google-drive';
            String body = 'code='+code+'&access_type=offline'+'&client_id='+key+'&client_secret='+secert+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        	req.setBody(body);
            res.setStatusCode(200);
             
        }
        //for RefreshToken
        else if(req.getEndpoint() ==  'https://accounts.google.com/o/oauth2/token'){
            
            String refreshToken = 'klgbkfbjlfjv55875464';
            String key = '896464981308-ha1q6p6l53nlq3j70btun10hg0t13ro4.apps.googleusercontent.com';
            String secert = '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';
            String redirect_uri = 'https://drive-integration-developer-edition.ap27.force.com/s/google-drive';
            String Body = 'refresh_token='+refreshToken+'&client_id='+key+'&client_secret='+secert+'&redirect_uri='+redirect_uri+'&grant_type=refresh_token';
          	req.setBody(body);
            res.setStatusCode(200);
        }
        //For AllFilesAndFolder
        else if(req.getEndpoint() == 'https://www.googleapis.com/drive/v3/files?q=\'root\'%20in%20parents&trashed=false'){
          	req.setBody('{"kind": "drive#file","id": "1vDmGPcyzCHc471SxBwYUqOXoxzxBwoFi","name": "Aura","mimeType": "application/vnd.google-apps.folder"}');
         	
            res.setStatusCode(200);
            //return body;
            
        }
        //For createFolder
        else if(req.getEndpoint() == 'https://www.googleapis.com/drive/v3/files'){
            req.setBody('{"kind": "drive#file","id": "1vDmGPcyzCHc471SxBwYUqOXoxzxBwoFi","name": "LWC","mimeType": "application/vnd.google-apps.folder"}');
         	
            res.setStatusCode(200);
        }
        //For Delete Folder
        else if(req.getEndpoint() == 'https://www.googleapis.com/drive/v2/files/16Z_mPLQW6PMI1w8aZ803zhRyJvTucSFb'){
            res.setStatusCode(200);
        }
        //For Delete File
        else if(req.getEndpoint() == 'https://www.googleapis.com/drive/v2/files/16Z_mPLQW6PMI1w8aZ803zhRyJvTucSFb'){
            res.setStatusCode(200);
        }
        // For DownloadFileData
        else if(req.getEndpoint() == 'https://www.googleapis.com/drive/v2/files/16Z_mPLQW6PMI1w8aZ803zhRyJvTucSFb'){
            res.setBody('{"kind": "drive#file","id": "1puvUXF1KStQi2myNE0TLV9G80T1U2NBx","etag": "\"MTY1NDcwMzk0NzAwMA\"","selfLink": "https://www.googleapis.com/drive/v2/files/1puvUXF1KStQi2myNE0TLV9G80T1U2NBx","webContentLink": "https://drive.google.com/uc?id=1puvUXF1KStQi2myNE0TLV9G80T1U2NBx&export=download","alternateLink": "https://drive.google.com/file/d/1puvUXF1KStQi2myNE0TLV9G80T1U2NBx/view?usp=drivesdk","embedLink": "https://drive.google.com/file/d/1puvUXF1KStQi2myNE0TLV9G80T1U2NBx/preview?usp=drivesdk","iconLink": "https://drive-thirdparty.googleusercontent.com/16/type/text/plain","thumbnailLink": "https://lh6.googleusercontent.com/kGDuFGYLPircySpx9GV9hNp4tBk__HoH0-fub4vjz6kKUrkESCvQ-wH5ccFp7pBZzIvLfGSMojhQmpc=s220","title": "8June.txt",}');
          	res.setStatusCode(200);                          
        }
        else if(req.getEndpoint() == 'https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart'){
            res.setBody('{ "kind": "drive#file","id": "1UdIh4wwg8dfMb7-J0a5bz05E0lOJNnv6","title": "flower2.jpg","mimeType": "image/jpeg"}');
        }
        
         return res;
        
       

        

        
        
        // Create a fake response.
        // Set response values, and 
        // return response.

    }


}