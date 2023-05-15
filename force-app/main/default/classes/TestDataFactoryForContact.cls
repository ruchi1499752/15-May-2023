@isTest
public class TestDataFactoryForContact {
    
    public static List<Contact> createContact(integer numCont){
        Account acct = new Account(Name = 'TestAccount 1');
        insert acct;
        
        List<Contact> conList = new List<Contact>();
        for(Integer i =1; i<numCont; i++){
            conList.add(new Contact(LastName = 'con'+i, AccountId = acct.id));
        }
       
       	return conList;
    }
    
    public static List<Contact> createContactForTwoAccount(integer num, integer seq){
        Account acc1 = new Account(Name ='TestAcc1' );
        insert acc1;
        
        Account acc2 = new Account(Name ='TestAcc2');
        insert acc2;
        
        List<Contact> conList= new List<Contact>();
        for(Integer i =1; i<=num; i++){
            conList.add(new Contact(LastName ='TestAcc1Con'+i ,Sequence_Number__c = seq, AccountId = acc1.id));
            //conList.add(new Contact(LastName ='TestAcc2Con'+i ,Sequence_Number__c = seq, AccountId = acc2.id));
        }
         
        if(!conList.isEmpty()){
            insert conList;
        }
        return conList;
       
        
    } 
    
}