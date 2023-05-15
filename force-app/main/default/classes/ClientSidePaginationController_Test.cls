@isTest
public class ClientSidePaginationController_Test {
	@TestSetup
    static void createAccounts(){
        List<Account> accList = ClientSideTestDataFactory.createAccounts(10);
        List<Contact> conList = ClientSideTestDataFactory.createContacts(20);
    }
    @isTest
    public static void getObjectName_Test(){
        Map<String,String> objectMap = new Map<String,String>();
        objectMap = ClientSidePaginationController.getObjectName();
        System.assertEquals(objectMap.containsKey('Account'), true);
    }
    @isTest
    public static void getObjectName_Account_Test(){
        Map<String,String> objectMap = new Map<String,String>();
        objectMap = ClientSidePaginationController.getObjectName();
        System.assertEquals(objectMap.containsKey('Abc'), false);
    }
     @isTest
    public static void getObjectName_Contact_Test(){
        Map<String,String> objectMap = new Map<String,String>();
        objectMap = ClientSidePaginationController.getObjectName();
        System.assertEquals(objectMap.containsKey('Con'), false);
    }
    @isTest
    public static void getFields_Test(){
        Map<String,String> fieldMap = new Map<String,String>();
        fieldMap = ClientSidePaginationController.getFields('Account');
        System.assertEquals(fieldMap.containsKey('Rating'), true);
        
    }
    @isTest
    public static void getData_Test(){
        List<Account> accList = [SELECT Name, Rating, Type FROM Account];
        List<String> fields = new List<String>{'name','rating'};
        List<SObject> result = ClientSidePaginationController.getData('Account', fields);
        
        System.assertEquals(result, accList);
        
        
        
    }
}