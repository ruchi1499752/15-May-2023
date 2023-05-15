@isTest
public class ContactTriggerHandle_Test{
	@testSetup
    public static void setup(){
        List<Contact> testConts = TestDataFactoryForContact.createContact(20);
        insert testConts;
        
        
       // insert testConts;
    }
    
    @isTest static void testInsertCase1(){
        List<Contact> testConts1 = TestDataFactoryForContact.createContactForTwoAccount(50, 0);
    
        System.assertEquals(0, testConts1[1].Sequence_Number__c);
        
        
        
    }
    
    @isTest
    static void testDeleteCase1(){
       List<Contact> delCont = [select id, lastName, Sequence_Number__c from Contact];
        delete delcont;
        System.debug(delCont.size());
        System.assertEquals(19, delCont.size());
                         
    }
    @isTest static void testDeleteCase2(){
		List<Contact> conList = [Select id, lastName,Sequence_Number__c from Contact limit 2];
        delete conList;
        System.assertEquals(2, conList.size());
		        
    }
    @isTest static void testUndeleteCase(){
        
        List<Contact> delList = [Select id, lastName,Sequence_Number__c from Contact];
        delete delList;
        undelete delList;
        System.assertEquals(19, delList.size());
        
        
        
        //List<Contact> unDelList = [Select id,lastName,Sequence_Number__c from Contact];
        //undelete unDelList;
        //System.assertEquals(unDelList.size() == 0, false);
       
    }
    @isTest static void testUpdateCase1(){
        List<Contact> conList = [Select id,LastName,Sequence_Number__c from Contact];
        
        List<Contact> updateSequence = new List<Contact>();
        updateSequence.add(new Contact(id = conList[0].id, Sequence_Number__c = 4));
        updateSequence.add(new Contact(id = conList[1].id, Sequence_Number__c = 3));
        update updateSequence;
        
        
        System.assertEquals(2, updateSequence.size());
       
        //List<Contact> updateConList = [Select id,LastName,Sequence_Number__c from Contact where AccountID =: conList];
        //
       
        
        
    }
  /*  @isTest static void testUpdateCase2(){
        List<Contact> conList = TestDataFactoryForContact.createContact(10);
        
        conList[1].Sequence_Number__c = 4;
        update conList[1];
        
         List<Contact> testList = [SELECT LastName, Sequence_Number__c, AccountId FROM Contact Where AccountId =:conList[0].AccountId ORDER BY Sequence_Number__c ASC];
         System.assertEquals(1, testList[0].Sequence_Number__c);
        
    }*/
   /* @isTest static void testUpdationOnMultipleAccount(){
        
        List<Contact> conList1 = TestDataFactoryForContact.createContactForTwoAccount(20);	//20
        List<Contact> conList2 = TestDataFactoryForContact.createContactForTwoAccount(5);	//5
        
        List<Contact> updateSequence = new List<Contact>();
       
        updateSequence.add(new Contact(id = conList1[0].id, Sequence_Number__c = 4));
        updateSequence.add(new Contact(id = conList1[0].id, Sequence_Number__c = 1));
        updateSequence.add(new Contact(id = conList2[1].id, Sequence_Number__c = 2));
        
        update updateSequence;
       
        System.assertEquals(18, conList1.size());
        System.assertEquals(4, conList2.size());
        
        
    }*/
    
    
    
    
    
}