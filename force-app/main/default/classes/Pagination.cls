public class Pagination
{
    public List<Account> AccList{get;set;}
    public String options;
    public List<SelectOption> lst{get;set;}
	private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 10;
    Public integer pageSize{get;set;}
    Public integer ResultSize{get;set;}
    Public integer PageNumber{get;set;}
    public integer size{get;set;}
     public List<SelectOption> paginationSizeOptions{get;set;}
    
    
    
  
    	
    
    //ApexPages.StandardController sc = new ApexPages.StandardController(sObject);
    
    public Pagination(){
        PageNumber = 1;
        pageSize = 10;
        AccList = new List<Account>();
        AccRec();
         //acc = [select name, id, industry, rating from Account];
       // options='';
        lst = new List<SelectOption>();
        lst.add(new SelectOption('','----None----'));
        lst.add(new SelectOption('A','My Accounts'));
        lst.add(new SelectOption('B','All Accounts'));
        lst.add(new SelectOption('C','Recently Viewed Accounts'));
        lst.add(new SelectOption('D','New This Week'));
        lst.add(new SelectOption('E','New Last Week'));
        
        
    	totalRecs = [select count() from account];
    }
    
    public List<account> AccRec(){
        
		AccList = [SELECT Name, id, Industry, Rating, Type FROM account LIMIT :LimitSize OFFSET :OffsetSize];
		System.debug('Values are ' + AccList);
		return AccList;
	}
    
     public String getoptions(){
        return options;
    }
    
    /*public void setoptions(String options){
        if(options == 'A'){
            //acc = [select id, name, industry, rating From Account OwnerId ='0055j000004f4tnAAA'];
        }
        else if(options == 'B'){
            AccList = [select id, name, industry, rating From Account];
        }
        else if(options == 'C'){
            AccList = [select id, name, industry, rating from Account order by LastViewedDate DESC];
        }
        else if(options == 'D'){
            AccList = [select id, name, industry, rating from Account where CreatedDate = THIS_WEEK ];
        }
        else if(options == 'E'){
            // acc = [select id, name, industry, rating from Account where CreatedDate != THIS_WEEK order by CreatedDate desc];
            AccList = [select id, name, industry, rating from Account where CreatedDate = LAST_WEEK ];
        }
    }*/
    

	public void FirstPage(){
		OffsetSize = 0;
        AccRec();
        PageNumber = 1;
        
		System.debug('First Page : '+ offsetSize);    
    }
    public void previous(){
     
    	OffsetSize = OffsetSize - LimitSize;
        AccRec();
        PageNumber = PageNumber - 1;
        System.debug('Previous : ' + OffsetSize);
    }                                  	
	public void next(){
        
		OffsetSize = OffsetSize + LimitSize;
   		AccRec();
        PageNumber = PageNumber + 1;
        	
     	System.debug('Next Page : ' + OffsetSize);
	}
   public void LastPage(){
		//OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
       OffsetSize = (totalRecs - LimitSize);
       AccRec();
       PageNumber = 10;
       System.debug('Last Page : '+ OffsetSize);
   }
	/*public boolean getprev()
	{
		if(OffsetSize == 0)
			return true;
		else
			return false;
	}*/	
	/*public boolean getnxt()
	{
		if((OffsetSize + LimitSize) > totalRecs)
			return true;
		else
			return false;
	}*/
    
    
    
     public List<SelectOption> getPerPageRecord(){
        
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));
        return paginationSizeOptions;
    }
    
    
    /*public void Psize(String size){
        if(size == '5'){
            this.size = 5;
            accList =  [select id, name, industry, rating from Account limit 5];
            
            
        }
        
    }*/
    
    
    public void setPSize(String size){
        LimitSize = this.size;
        if(size == '5'){
            //LimitSize = this.size;
          this.size = 5;
          accList =  [select id, name, industry, rating from Account limit 5]; 
        }
        else if(size == '10'){
            
             this.size = 10;
          accList =  [select id, name, industry, rating from Account limit 10]; 
        }
        else if(size == '20'){
            this.size = 20;
          accList =  [select id, name, industry, rating from Account limit 20]; 
        }
        else if(size == '50'){
            this.size = 50;
          accList =  [select id, name, industry, rating from Account limit 50]; 
        }else if(size == '100'){
            this.size = 100;
          accList =  [select id, name, industry, rating from Account limit 100]; 
        }
    }
    
    
    public String getPSize(){
        return '10';
        
    }
    
    
    
    /*ApexPages.StandardSetController setCon = new ApexPages.StandardSetController(AccList);
    public void PaginationUsingStandardSetControl(){
        Pagesize=10;
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));
    }
    //Changes the size of pagination
    public PageReference refreshPageSize() {
         setCon.setPageSize(Pagesize);
         return null;
    }*/
   
    
}