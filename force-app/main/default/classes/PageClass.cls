public class PageClass{
	public List<Account> acc{get;set;}
    public ApexPages.StandardSetController std{get;set;}
    public integer RecordsPerPageslist{get;set;}
    public List<String> alphabet{get;set;}
    public String alphaSearchConct{get;set;} 
    public Integer PageNumber{get;set;}
    public list<SelectOption> RecordsPerPageOptionList{get;set;}
    list<SelectOption>  options{get;set;}
    
   // public ApexPages.StandardSetController std{get;set;}
    
    public PageClass(){
       	RecordsPerPageslist=10;
        Rec();
        
        RecordsPerPageOptionList = RecordsPerPageOptions();
        alphabets();
    }
    public void Rec(){
        acc = new List<Account>();
        acc = [select name, id , phone, website, Rating from Account limit 10];

		std = new ApexPages.StandardSetController(acc);//Instantiating a standard set controller
      
        
        std.getRecords();	//to display records on vf page
      
        RecordsPerPageOptions();
        std.setPageSize(RecordsPerPageslist); 
        /*for(Account a : acc){
            System.debug(a);
        }*/
        
    }
    
    public List<String> alphabets(){
        alphabet = new List<String>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Others','All'};
    	//alphaSearch();
        return alphabet;
        
    }
    public void alphaSearch(){                                                              //To update contact list as per the alphabet selected by the user

        if (alphaSearchConct=='All'){
            acc = [select name, id , phone, website, Rating from Account];
        }
        else{
            acc = [select name, id , phone, website, Rating from Account WHERE name Like:alphaSearchConct+'%'];
        }
            
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(acc);
        std= ssc;
       
	}  
    
   public integer PageNum(){
        std.setPageNumber(3);// To navigate to the page number entered by the user
        this.PageNumber=std.getPageNumber();
        return this.PageNumber;
        
        
    }
    
    
    
    public list<SelectOption> RecordsPerPageOptions(){              //To display a drop down list on vf page  
            options = new list<SelectOption>();
            options.add(new selectOption('5','5'));
            options.add(new selectOption('10','10'));
            options.add(new selectOption('15','15'));
            options.add(new selectOption('20','20'));
            
            return options;
    }
    
    
    
    
}