@isTest
public class BoxController_Test {
	@isTest
    public static void getUserInfo_Test(){
        
        test.startTest();
        BoxController.getUserInfo();
      	test.stopTest();
        
    }
    @isTest
    public static void getUserInfo_TestForUserExist(){
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856',ExpireTime__c = System.now().addHours(-1),  userId__c = userinfo.getUserId()));
        insert result;
        
        test.startTest();
        BoxController.getUserInfo();
      	test.stopTest();
        
    }
    @isTest
    public static void getUserInfo_TestForAccessToken(){
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='', Refresh_Token__c = 'jhjdfkvd7856',  userId__c = userinfo.getUserId()));
        insert result;
        
        test.startTest();
        BoxController.getUserInfo();
      	test.stopTest();
        
    }
    @isTest
    public static void getUserInfo_TestForRefreshToken(){
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = '',  userId__c = userinfo.getUserId()));
        insert result;
        
        test.startTest();
        BoxController.getUserInfo();
      	test.stopTest();
        
    }
    
   
    
     @isTest
    public static void getUserInfo_RefreshToken_Test(){
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        if(result[0].Refresh_Token__c != null){
            System.assertEquals('Token Exist', 'Token Exist');
        }
       
    }
    @isTest
    public static void createAuthURL_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        test.startTest();
        String res = BoxController.createAuthURL();
        //System.assertEquals(res,'https://accounts.google.com/o/oauth2/v2/auth?');
        test.stopTest();
    }
     @isTest
    public static void requestAccessToken_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        test.startTest();
        String res = BoxController.requestAccessToken('34DRG$');
        System.assertEquals('Token Exist', res);
        test.stopTest();
    }
    /* @isTest
    public static void requestAccessToken_TestOne(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        test.startTest();
        String res = BoxController.requestAccessToken();
        //System.assertEquals('Token Exist', res);
        test.stopTest();
    }*/
    @isTest
    public static void refreshAccessToken_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        
        
        test.startTest();
        String res = BoxController.refreshAccessToken();
        System.assertEquals('Token Exist', res);
     
        test.stopTest();
        
    }
     @isTest
    public static void getAllfilesAndFolders_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        test.startTest();
        String res = BoxController.getAllfilesAndFolders('1OLSTQRsd3Dt0NAQ4kab9FCnfYGkTCAMi');
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        System.assertEquals('LWC', m.get('name'));
      	System.debug('NAme is :' + m.get('name'));
        System.debug('Files and Folder Response :' + res);
          
        //System.assertEquals('name', 'Aura);
        test.stopTest();
        
    }
    @isTest
    public static void createFolder_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
         insert result;
        test.startTest();
        String res = BoxController.createFolder('Box', '2343535353');
        Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        System.assertEquals('application/vnd.google-apps.folder', m.get('mimeType'));
        
        test.stopTest();
        
    }
    @isTest
    public static void  deleteFolder_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        test.startTest();
        String res = BoxController.deleteFolder('1OLSTQRsd3Dt0NAQ4kab9FCnfYGkTCAMi');
       // Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        //System.assertEquals('application/vnd.google-apps.folder', m.get('mimeType'));
        
        
        
        //System.assertEquals();
        test.stopTest();
        
    }
     @isTest
    public static void  deleteFile_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
        insert result;
        test.startTest();
        String res = BoxController.deleteFile('1OLSTQRsd3Dt0NAQ4kab9FCnfYGkTCAMi');
       // Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(res);
        //System.assertEquals('application/vnd.google-apps.folder', m.get('mimeType'));
        
        
        
        System.assertEquals('200', res);
        test.stopTest();
        
    }
    @isTest
    public static void  downloadBoxFile_Test(){
        Test.setMock(HttpCalloutMock.class, new Box_MockClass());
        List<Box_Integration__c> result = new List<Box_Integration__c>(); 
        result.add(new Box_Integration__c(Access_Token__c ='fjkerfre', Refresh_Token__c = 'jhjdfkvd7856', userId__c = userinfo.getUserId()));
         insert result;
        test.startTest();
        String res = BoxController.downloadBoxFile('1OLSTQRsd3Dt0NAQ4kab9FCnfYGkTCAMi');
        //System.assertEquals();
        test.stopTest();
        
    }
    
    
}