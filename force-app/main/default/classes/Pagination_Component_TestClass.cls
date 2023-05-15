@isTest
public class Pagination_Component_TestClass {
    
	@isTest 
    static void TestDisplayData(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.RecordsPerPageslist = 10;
        List<Account>  acc = new List<Account>();
        acc.add(new Account(name='Test'));
        insert acc;
         
       	pg.fields = 'name,industry';
        pg.obj = 'Account';
		pg.displayData();
        System.assert(!pg.wrapList.isEmpty());
        System.debug(pg.wrapList);
    }
    
    @isTest static void testAlphabet(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.alphabet = new List<String>();
        pg.alphabet.add('A');
       // pg.alphabet();
    }
    
    @isTest static void testAlphaSearchRecord(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        
        pg.alphaSearchRecord = 'All';
        pg.RecordsPerPageslist = 10;
        List<Account>  acc = new List<Account>();
        acc.add(new Account(name='Test'));
        insert acc;
         
       	pg.fields = 'name,Industry';
        pg.obj = 'Account';
        pg.alphaSearch();
        System.debug(pg.wrapList);
    }
    @isTest static void testAlphaSearchRecord1(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        
        pg.alphaSearchRecord = 'A';
        pg.RecordsPerPageslist = 10;
        List<Account>  acc = new List<Account>();
        acc.add(new Account(name='Test'));
        insert acc;
         
       	pg.fields = 'name,Industry';
        pg.obj = 'Account';
        pg.alphaSearch();
        //pg.fetchRecords();
        System.debug(pg.wrapList);
    }
    @isTest static void testchangePageNumber(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
     	pg.changePageNumber();
        pg.fetchRecords();
    }
    @isTest static void testUpdateRecordSize(){
    	Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.RecordsPerPageslist = 10; 
        
        //std = new ApexPages.StandardSetController(Database.query(qry));
 		pg.updateRecordSize();
    }
    @isTest static void testSortExpression(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.sortDirection = 'ASC';
        pg.RecordsPerPageslist = 10;
        
        pg.sortExpression();

    }
    @isTest static void testFirstButton(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.first();
        
    }
    @isTest static void testPreviousButton(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.pre();
        
    }
    @isTest static void testNextButton(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.next();
        
    }
    @isTest static void testLastButton(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        pg.last();
        
    }
    
    
    @isTest static void testFetchRecords(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        //List<account> accountList = [SELECT Name FROM Account];
        //ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(accountList);
        pg.fetchRecords();
        System.assert(!pg.wrapList.isEmpty());
    }
    @isTest static void testMaintainState(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
        
       	pg.maintainState();
    }
    
    @isTest static void testDeleteSelectedRecords(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
       	pg.deleteSelectedRecords();
    }
    @isTest static void testCreateCsvfiles(){
        Pagination_Component_Class pg = new Pagination_Component_Class();
       	pg.CreateCsvfiles();
    }
    
    
    
    
}