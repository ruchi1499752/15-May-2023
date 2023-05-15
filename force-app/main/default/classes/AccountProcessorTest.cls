@isTest
public class AccountProcessorTest {
    @isTest
    public static void testAccountProcessor(){
        Account a = new Account();
        a.Name = 'TestAccount';
        INSERT a;
        
        Contact con = new Contact();
        con.FirstName = 'JAva';
        con.LastName = 'Programming';
        con.AccountId = a.Id;
        
        INSERT con;
        
        List<Id> accListId = new List<Id>();
        accListId.add(a.Id);
       
        Test.startTest();
        AccountProcessor.countContacts(accListId);
        Test.stopTest();
        
        Account acc = [SELECT Number_Of_Contacts__c FROM Account WHERE Id =: a.Id];
        System.assertEquals(Integer.valueOf(acc.Number_Of_Contacts__c), 1);
        
    }
}