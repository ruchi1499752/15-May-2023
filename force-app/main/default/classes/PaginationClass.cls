public class PaginationClass {
    public ApexPages.StandardSetController sc{get;set;}
    public integer size{get;set;}
    public List<SelectOption> pageSize{set;get;}
    public integer noOfRec{get;set;}
    
    public PaginationClass(){
        
        String qry = 'select name, id , Industry, Rating from Account';
        sc = new ApexPages.StandardSetController(Database.getQueryLocator(qry));
        
        //Set the Page Size
        recordSize();
        noOfRec = sc.getResultSize();
        System.debug(noOfRec);
        
        pageSize = new List<selectOption>();
        pageSize.add(new selectOption('5','5'));
        pageSize.add(new selectOption('10','10'));
        pageSize.add(new selectOption('15','15'));
        pageSize.add(new selectOption('20','20'));
       
        	
        
        
    }
    
 
    public List<Account> getAccRec(){
        List<Account> acc = new List<Account>();
        for(Account a : (List<Account>)sc.getRecords()){
            acc.add(a);
        }
        return acc;
        
    }
    
    public void recordSize(){
        size= 10;
        sc.setPageSize(size);
    }
    public void first(){
        sc.first();
    }
    public void pre(){
        sc.previous();
    }
    public void next(){
        sc.next();
    }
    public void lst(){
        sc.last();
    }
    
     //Changes the size of pagination
     public PageReference refreshPageSize() {
        sc.setPageSize(size);
        return null;
   }

   	
}