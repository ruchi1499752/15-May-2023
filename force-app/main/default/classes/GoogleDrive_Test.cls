@isTest
public class GoogleDrive_Test {
    /*@testSetup static void setup() {
		 List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        if(!result.isEmpty()){
            INSERT result;
        } 
    }*/
    @isTest
    public static void TestForNoUserExist(){
      test.startTest();
      googleDriveController.getUserInfo();
      test.stopTest();
    }
     @isTest
    public static void TestForUserExist(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(-1), userId__c = userinfo.getUserId()));
        if(!result.isEmpty()){
            INSERT result;
        }   
        test.startTest();
         googleDriveController.getUserInfo();
        //System.assertEquals('Access Token Exist', res);
        test.stopTest();
    }
    
    @isTest
    public static void TestForUserExistOne(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(1), userId__c = userinfo.getUserId()));
        if(!result.isEmpty()){
            INSERT result;
        }   
        test.startTest();
         googleDriveController.getUserInfo();
//        System.assertEquals('Access Token Exist', res);
        test.stopTest();
    }
    @isTest
    public static void TestRefreshToken(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='',Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        if(!result.isEmpty()){
            INSERT result;
        }
        test.startTest();
       	String res = googleDriveController.getUserInfo();
        System.assertEquals('Access Token Exist', res);
     
    }
    
     @isTest
    public static void Test_Tokens_Not_Exist(){
       List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='',Refresh_Token__c = '', userId__c = userinfo.getUserId()));
        if(!result.isEmpty()){
            INSERT result;
        }
        test.startTest();
       	googleDriveController.getUserInfo();
        //System.assertEquals('Access Token Exist', 'Access Token Exist');
        
        test.stopTest();
        
        
    }
    
    
    
    @isTest
    public static void createAuthURL_Test(){
        Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
        test.startTest();
        String res = googleDriveController.createAuthURL();
        //System.assertEquals(res,'https://accounts.google.com/o/oauth2/v2/auth?');
        test.stopTest();
    }
    @isTest
    public static void getAccessToken_Test(){
        Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
        test.startTest();
        String res = googleDriveController.getAccessToken('34DRG$');
        System.assertEquals(res,'Access Token Exist');
        test.stopTest();
    }
    @isTest
    public static void getRefreshToken_Test(){
        Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
        result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        
        
        test.startTest();
        String res = googleDriveController.getRefreshToken();
        System.assertEquals(res,'Access Token Exist');
        test.stopTest();
        
    }
    @isTest
    public static void getFilesAndFolders_Test(){
        Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
        result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        test.startTest();
        String res = googleDriveController.getFiles('1OLSTQRsd3Dt0NAQ4kab9FCnfYGkTCAMi');
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        System.assertEquals('LWC', m.get('name'));
      	System.debug('NAme is :' + m.get('name'));
        System.debug('Files and Folder Response :' + res);
          
        //System.assertEquals('name', 'Aura);
        test.stopTest();
        
    }
    @isTest
    public static void createFolder_Test(){
        Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
        result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
         insert result;
        test.startTest();
        String res = googleDriveController.createFolder('Integration','16Z_mPLQW6PMI1w8aZ803zhRyJvTucSFb');
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        System.assertEquals('application/vnd.google-apps.folder', m.get('mimeType'));
        
        test.stopTest();
        
    }
    @isTest
    public static void  deleteFolder_Test(){
        Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
        result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        test.startTest();
        String res = googleDriveController.deleteFolder('1OLSTQRsd3Dt0NAQ4kab9FCnfYGkTCAMi');
       // Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        //System.assertEquals('application/vnd.google-apps.folder', m.get('mimeType'));
        
        
        
        //System.assertEquals();
        test.stopTest();
        
    }
     @isTest
    public static void  downloadFileData_Test(){
        Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
        List<Integration_Access__c> result = new List<Integration_Access__c>(); 
        result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
         insert result;
        test.startTest();
        String res = googleDriveController.downloadFileData('1OLSTQRsd3Dt0NAQ4kab9FCnfYGkTCAMi');
        //System.assertEquals();
        test.stopTest();
        
    }
    @isTest
    public static void uploadFile_Test(){
         Test.setMock(HttpCalloutMock.class, new GoogleDrive_MockTest());
         List<Integration_Access__c> result = new List<Integration_Access__c>(); 
         result.add(new Integration_Access__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
         insert result;
         test.startTest();
         String res = googleDriveController.uploadFile('fhgbhjgbhgbjfgbj','FileBoundary');
         Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
         System.assertEquals('flower2.jpg', m.get('title'));
         test.stopTest();
        
        
        
    }
    
    
    
   
    
    
}