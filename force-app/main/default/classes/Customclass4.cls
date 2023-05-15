public class Customclass4 {
	public List<Account>acc{get;set;}
    public String options;
    public List<SelectOption> lst{get;set;}
    //public List<Account> v1{get;set}
    
   
   
    public CustomClass4(){
        acc = [select name, id, industry, rating from Account];
       // options='';
        lst = new List<SelectOption>();
        lst.add(new SelectOption('','----None----'));
        lst.add(new SelectOption('A','My Accounts'));
        lst.add(new SelectOption('B','All Accounts'));
        lst.add(new SelectOption('C','Recently Viewed Accounts'));
        lst.add(new SelectOption('D','New This Week'));
        lst.add(new SelectOption('E','New Last Week'));
       
        
    }
    public String getoptions(){
        return options;
    }
    public void setoptions(String options){
        if(options == 'A'){
            //acc = [select id, name, industry, rating From Account OwnerId ='0055j000004f4tnAAA'];
        }
        else if(options == 'B'){
            acc = [select id, name, industry, rating From Account];
        }
        else if(options == 'C'){
            acc = [select id, name, industry, rating from Account order by LastViewedDate DESC];
        }
        else if(options == 'D'){
            acc = [select id, name, industry, rating from Account where CreatedDate = THIS_WEEK ];
        }
        else if(options == 'E'){
            // acc = [select id, name, industry, rating from Account where CreatedDate != THIS_WEEK order by CreatedDate desc];
            acc = [select id, name, industry, rating from Account where CreatedDate = LAST_WEEK ];
        }
    }
   
    public void saveRec(){
        update acc;
        
        
    }
}