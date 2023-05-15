@isTest
public class CommunityOrgController_Test {
	@isTest
    public static void uploadFileToApiOrg_Test(){
        Test.setMock(HttpCalloutMock.class, new CommunityOrgMockClass());
        Test.startTest();
        Integer res = CommunityOrgController.uploadFileToApiOrg('heejfjse','flower.jpg');
        System.assertEquals(res, 200);
       // System.assertEquals(expected, actual)
        Test.stopTest();    
    }
   	@isTest
    public static void fileUpload_Test(){
        Test.startTest();
         /*User res = [Select Name,Username, ContactId from user where id ='0055j0000076AocAAE'];
        Blob b = EncodingUtil.base64Decode('hhjgjb578rtjkgr');
        ContentVersion cv = new ContentVersion(Title = 'fgjhgfj', PathOnClient = 'fjjbbfb', VersionData = b);
        INSERT cv;
        ContentDocumentLink Doclink = new ContentDocumentLink(LinkedEntityId = '0035j00000RMYGAAA5',ContentDocumentId = cv.Id );
        Doclink.LinkedEntityId = '0035j00000RMYGAAA5';
        Doclink.ContentDocumentId = '0695j00000AqdLwAAJ';
        INSERT Doclink;*/
        
        String result = CommunityOrgController.fileUpload('base64','flower.jpg');
        System.assertEquals(result, 'File Upload');
        Test.stopTest();
    }
    @isTest
    public static void getAllFiles_Test(){
      
        
        Test.startTest();
        List<ContentVersion> result = CommunityOrgController.getAllFiles();
        
        //System.assertEquals(expected, actual)
        //System.assertEquals(0, result.size());
        Test.stopTest();
    }
    
}