public class CustomPagination
{
    public List<Account> acc{get;set;}
    public String options;
    public List<SelectOption> lst{get;set;}
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 10;
    
    public CustomPagination(){
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
	public List<account> getacclist(){
        
		List<account> acc = [SELECT Name, id, Industry, Rating, Type FROM account LIMIT :LimitSize OFFSET :OffsetSize];
		System.debug('Values are ' + acc);
		return acc;
	}
	public void FirstPage(){
		OffsetSize = 0;
		System.debug(offsetSize);    
    }
    public void previous(){
     
    	OffsetSize = OffsetSize - LimitSize;
    }	
	public void next(){
        
		OffsetSize = OffsetSize + LimitSize;
     	System.debug(OffsetSize);
	}
   public void LastPage(){
		//OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
       OffsetSize = totalRecs - LimitSize;
	}
	/*public boolean getprev()
	{
		if(OffsetSize == 0)
			return true;
		else
			return false;
	}	
	public boolean getnxt()
	{
		if((OffsetSize + LimitSize) > totalRecs)
			return true;
		else
			return false;
	}*/
}