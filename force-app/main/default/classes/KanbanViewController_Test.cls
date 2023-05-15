@isTest
public class KanbanViewController_Test {
	@TestSetup
    static void createAccounts(){
        List<Account> accList = KanbanTestDataFactory.createAccounts(10);
        List<Contact> conList = KanbanTestDataFactory.createContacts(20);
    }
    
    @isTest
    public static void getObjectName_Account_Test(){
        Map <String, String> objectMap = new Map<String,String>();
        objectMap = KanbanViewController.getObjectNames();
        System.assertEquals(objectMap.containsKey('Account'), true);
        
    }
    @isTest
    public static void getObjectName_Contact_Test(){
        Map <String, String> objectMap = new Map<String,String>();
        objectMap = KanbanViewController.getObjectNames();
        System.assertEquals(objectMap.containsKey('Contact'), true);
        
    }
    
    @isTest
    public static void getFields_Test(){
        Map<String, String> fieldMap = new Map<String,String>();
        fieldMap = KanbanViewController.getFields('Account');
        System.assertEquals(fieldMap.containsKey('Rating'), true);
    }
    
    @isTest
    public static void KanbanPicklist_Values_Test(){
        List<Account> accList = [SELECT Id,Name,Rating FROM Account LIMIT 10];
        kanbanViewController.KanbanPicklist_Values('Account','Rating');
        System.assertEquals(accList.size(), 10);
        
    }
    @isTest
    public static void KanbanPicklist_Values_Contact_Test(){
        List<Contact> conList = [SELECT Id,LastName,Salutation FROM Contact LIMIT 20];
        kanbanViewController.KanbanPicklist_Values('Contact','Salutation');
        System.assertEquals(conList.size(), 20);
        
    }
    @isTest
    public static void updatePickListValue_Test(){
        List<Account> accList = [SELECT Id,Name,Rating FROM Account LIMIT 10];
        KanbanViewController.updatePickListValue(accList[0].Id, 'Rating', 'Hot');
        System.assertEquals(accList.size(), 10);
        
    }
}