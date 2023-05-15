@isTest
public class DropboxControllerTest {
    @testSetup
    public static void makeData(){
        String client_id = 'td2c997d9rausam';
        String client_secret = 'm1vkd6gkwwgdy2g';
        String redirect_uri = 'https://drive-integration-developer-edition.ap27.force.com/s/dropbox';
    }
    @isTest
    public static void TestForNoUserExist(){
      test.startTest();
      DropboxController.getUserInfo();
      test.stopTest();
    }
    @isTest
    public static void TestForUserExist(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(), RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }   
        test.startTest();
         DropboxController.getUserInfo();
        test.stopTest();
    }
     @isTest
    public static void Test_AccessTokenIsNull(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(),RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }   
        test.startTest();
         String res = DropboxController.getUserInfo();
        System.assertEquals(res,'Token Exist');
        test.stopTest();
    }
      @isTest
    public static void Test_BothTokenIsNull(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='', Refresh_Token__c = '',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(),RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }   
        test.startTest();
         DropboxController.getUserInfo();
        //System.assertEquals('Access Token Exist', res);
        test.stopTest();
    }
      @isTest
    public static void Test_AccessTokenExpire(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fdjfbh', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(-4), userId__c = userinfo.getUserId(),RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }   
        test.startTest();
        String res = DropboxController.getUserInfo();
        System.assertEquals(res,'Token Exist');
        test.stopTest();
    }
      @isTest
    public static void Test_RefreshTokenExpire(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fdjfbh', Refresh_Token__c = '',ExpireTime__c = System.now().addHours(-4), userId__c = userinfo.getUserId(),RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }   
        test.startTest();
        String res = DropboxController.getUserInfo();
       // System.assertEquals(res,'Token Exist');
        test.stopTest();
    }
    
    
    @isTest
    public static void getAuthUrl_Test(){
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        test.startTest();
        String url = DropboxController.getAuthUrl();
        System.assertEquals(url ,'https://www.dropbox.com/oauth2/authorize?client_id=td2c997d9rausam&response_type=code&redirect_uri=https://drive-integration-developer-edition.ap27.force.com/s/dropbox&token_access_type=offline');
        test.stopTest();
    }
    
    @isTest
    public static void getAccessToken_Test(){
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(), RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        } 
        Test.startTest();
        String res = DropboxController.getAccessToken('8NyoAAAAAAAAAXIGYdYrFVw5J_coeVIuDkoo');
       	system.assertEquals(res ,'Token exist');
        Test.stopTest();
    }
    
   @isTest
    public static void getRefreshToken_Test(){
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='hfghfgh', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(), RecordTypeId = '0125j000001ZrpQAAS' ));
        if(!result.isEmpty()){
            INSERT result;
        }   
        Test.startTest();
        String res = DropboxController.getRefreshToken();
        system.assertEquals(res ,'Token exist');
        Test.stopTest();
    }
    @isTest
    public static void getData_Test(){
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='hfghfgh', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(), RecordTypeId = '0125j000001ZrpQAAS' ));
        if(!result.isEmpty()){
            INSERT result;
        }   
        Test.startTest();
        List<DropBoxWrapperClass.entries> res = DropboxController.getData('0');
        //System.assertEquals(expected, actual)
        Test.StopTest();
    }
    @isTest
    public static void createFolder_Test(){
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='hfghfgh', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(),  RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }  
        Test.startTest();
        String response = DropboxController.createFolder('LWC', '/LWC');
        System.assertEquals(response, '{"name": "LWC", "path_lower": "/lwc", "path_display": "/LWC", "id": "id:rc4S8MISSMAAAAAAAAAAVw"}');
        Test.StopTest();
        
    }
    @isTest
    public static void deleteFolder_Test(){
        
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='hfghfgh', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(),  RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }
        Test.startTest();
        String res = DropboxController.deleteFolder('/lwc');
        System.assertEquals(res,'Folder was deleted');
        Test.stopTest();
    }
    
    @isTest
    public static void downloadDropboxFile_Test(){
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='hfghfgh', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(),  RecordTypeId = '0125j000001ZrpQAAS'));
        if(!result.isEmpty()){
            INSERT result;
        }
        Test.startTest();
        String res = DropboxController.downloadDropboxFile('/flower2.jpg');
        System.assertEquals(res, '{"metadata": {"name": "flower2.jpg", "path_lower": "/flower2.jpg", "path_display": "/flower2.jpg", "id": "id:rc4S8MISSMAAAAAAAAAAUg", "client_modified": "2022-06-30T06:39:31Z", "server_modified": "2022-06-30T06:39:31Z", "rev": "015e2a4883f2b840000000270067f50", "size": 5391, "is_downloadable": true, "content_hash": "56faa06dbebe7d248d3db326f0de4ab210288118607c93c187a2840a240ba4f4"}, "link": "https://ucc7f8291c8868af0c4071128e2c.dl.dropboxusercontent.com/cd/0/get/BoLYZr_lwGLnwEO6VPI0W9wFCem-36y32FfGH4cqJk-ooSMR_AECx7VaH2GpVWZnqosW2NbVWriNHNzgQXn-UD-ZfWURNNbikkkVe7aQREVUF3K3uRm51o_Pec8tElkzk5UpS0PFhgkuHnH1n9M2ZaP3LNGsljJ2wkZaAGFoGyhuQq0lCDlK5YhAIB4CpN4WSe8/file"}');
        Test.stopTest();
    }
    
    @isTest
    public static void UploadFile_Test(){
        Test.setMock(HttpCalloutMock.class, new DropboxMockClass());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
        result.add(new Integration_Access__c(Access_Token__c ='hfghfgh', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(4), userId__c = userinfo.getUserId(),  RecordTypeId = '0125j000001ZrpQAAS'));
    	if(!result.isEmpty()){
            INSERT result;
        }
        Test.startTest();
        String res = DropboxController.UploadFile('/ruchi', 'Screenshot_2.png', 'jfdbhjbhb');
        System.assertEquals(res, '{"name": "Screenshot_2.png", "path_lower": "/screenshot_2.png", "path_display": "/Screenshot_2.png", "id": "id:rc4S8MISSMAAAAAAAAAAgw", "client_modified": "2022-07-03T05:28:46Z", "server_modified": "2022-07-03T05:28:46Z", "rev": "015e2dfe4c106460000000270067f50", "size": 24125, "is_downloadable": true, "content_hash": "1c72e7d77c2cdbea8b6e7238689366ee6ac2186e14f6b49a2a36946521669cb5"}');
       // System.assertEquals(res,'{"name": "Screenshot_2.png", "path_lower": "/screenshot_2.png", "path_display": "/Screenshot_2.png", "id": "id:rc4S8MISSMAAAAAAAAAAgw", "client_modified": "2022-07-03T05:28:46Z", "server_modified": "2022-07-03T05:28:46Z", "rev": "015e2dfe4c106460000000270067f50", "size": 24125, "is_downloadable": true, "content_hash": "1c72e7d77c2cdbea8b6e7238689366ee6ac2186e14f6b49a2a36946521669cb5"}');
        //Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        //System.assertEquals('Screenshot_2.png', m.get('name'));
        Test.stopTest();
    }
    
    
    
}