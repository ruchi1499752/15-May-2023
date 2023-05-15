@istest
public class ServerSidePagination_Test {
    @testSetup
    static void setup(){
       Account acc = new Account(Name='TestAccount 1');
        INSERT acc;
        
        List<Contact> conList = new List<Contact>();
        for(integer i=1; i<=50; i++){
            conList.add(new Contact(LastName = 'con'+i, AccountId = acc.id));
            
        }
        if(!conList.isEmpty()){
            INSERT conList;
        }
		System.debug(conList);
    }
    @isTest
    static void getRecordsTest(){
        Test.startTest();
        String qry = 'SELECT Id, Name FROM Contact';
        List<Contact> conList = ServerSidePaginationController.getRecords(qry);
        System.assertEquals(conList[0].Name, 'con1');
        System.debug('Inside getRecordTest');
        Test.stopTest();
       
        
    }
    @isTest
    static void TotalRecordsTest(){
        Integer cnt = [SELECT count() From Contact];
        System.debug('Count of Contact' + cnt );
        ServerSidePaginationController.getTotalRecords();
        System.assertEquals(50, cnt);
      
    }
   
    
    
	
}