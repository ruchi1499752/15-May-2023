@isTest
public class AccountTriggerTest {
    @isTest static void TestCreateNewAccountInBulk() {
        List<Account> acc = new List<Account>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i, BillingState= 'CA');
            acc.add(acct);
        }
         Test.startTest();
        insert acc;                               
        Test.stopTest();
        
         List<Account> verifyAccts = [SELECT Id,BillingState, ShippingState FROM Account];
        for(Account ac : verifyAccts){
            System.assertEquals('CA', ac.ShippingState	);  
        }
       
    }
}