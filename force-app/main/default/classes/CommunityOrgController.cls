public class CommunityOrgController {

// Method to query all uploaded files
    @AuraEnabled
    public static List<ContentVersion> getAllFiles(){
        try {

            User res = [Select Name,Username, ContactId from user where id =: userInfo.getUserId()];
            List<ContentDocumentLink> contentDocumentLinks = 
            [
                SELECT ContentDocumentId ,LinkedEntityId
                FROM ContentDocumentLink 
                WHERE LinkedEntityId IN (SELECT ContactId FROM user where id =: userInfo.getUserId())
            ];
        
            List<ContentVersion> contentVersions = new List<ContentVersion>();
            if(contentDocumentLinks.size() > 0)
            {
                List<Id> contentDocumentLinkIds = new List<Id>();
                for (ContentDocumentLink contentDocumentLink : contentDocumentLinks )
                    contentDocumentLinkIds.add(contentDocumentLink.ContentDocumentId);

                contentVersions = [SELECT Id,ContentDocumentId,Title, FileType,isLatest FROM ContentVersion WHERE ContentDocumentId in :contentDocumentLinkIds and FileType!='SNOTE' and IsLatest = true];
                
            } 
            System.debug('Size of ContentVersion :' + contentVersions.size());
            return contentVersions; 
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }    
    
// Method to upload file under the current user's Contact
   @AuraEnabled
    public static string fileUpload(String base64, String filename){
        //try {
            
            User res = [Select Name,Username, ContactId from user where id =: userInfo.getUserId()];
            ContentVersion cv = new ContentVersion();   
            cv.VersionData = EncodingUtil.base64Decode(base64); // VersionData contains the file content.
            cv.Title = filename;    // Title represents the name of the file.
            cv.PathOnClient = filename; //PathOnClient represents the complete path of the document
            INSERT cv;

            String Versid = 
            [   SELECT ContentDocumentId 
             	FROM ContentVersion 
                WHERE Id =: cv.id
            ].ContentDocumentId;
           
            ContentDocumentLink Doclink = new ContentDocumentLink();
            Doclink.ContentDocumentId = Versid;
            Doclink.LinkedEntityId = res.ContactId;
            Doclink.sharetype = 'I';    // ShareType is either 'V', 'C', or 'I' // V = Viewer, C = Collaborator, I = Inferred
            INSERT Doclink;
        
            return 'File Upload';
 
        /*} catch (Exception e) {
            System.debug('Exception :' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }*/
    }

// Method to upload file to the API Org 
    @AuraEnabled
    public static Integer uploadFileToApiOrg(String base64, String filename ){
        try {
            String Method = 'POST';    
            String endPoint ='callout:IntegrationUser/services/apexrest/uploadFile';
            System.debug('ENDPOINT :::' + endPoint); //callout:IntegrationUser/services/apexrest/uploadFile
            String body = '{"filename" : "' + filename + '","base64" : "' + base64 +'"}';
            Map<String,String> header = new Map<string,String>();
            header.put('Content-Type', 'application/json;charset=UTF-8');
            HttpResponse resp = CommunityOrgSeviceClass.httpCallout(Method, endPoint, body, header);
            System.debug('Response is :' + resp.getBody());
            //return resp.getBody();
            return resp.getStatusCode();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}