@isTest
public class ContactBatchTest {
	@testSetup
    static void setup(){
        Account acc = new Account(Name='TestAccount 1');
        INSERT acc;
        
        List<Contact> ConList = new List<Contact>();
        for(integer i=1; i<=50; i++){
            conList.add(new Contact(LastName = 'con'+i, AccountId = acc.id, Status__c ='Ready for approval', CreatedDate= DateTime.Now().addDays(-1)));
            //CreatedDate= Date.today().addDays(-1)
        }
        if(!conList.isEmpty()){
            INSERT conList;
        }
		System.debug(conList);
		       
        
    }
    
    @isTest static void testContact(){
        Test.startTest();
        ContactBatchClass bc = new ContactBatchClass();
        Database.executeBatch(bc, 100);
        
        for(Contact con : [SELECT Id,Status__c FROM Contact]){
            System.assertEquals('Ready for Approval', con.Status__c);
        }
        Test.stopTest();

    }
    @isTest static void testschedule(){
        Test.startTest();
        ContactBatchClass bc = new ContactBatchClass();
        String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, bc);
        Test.stopTest();

        
    }
}

/*
 Datetime yesterday = Datetime.now().addDays(-1);
System.debug(yesterday);

Date yesterday1 = Date.today().addDays(-1);
System.debug(yesterday1);
 */