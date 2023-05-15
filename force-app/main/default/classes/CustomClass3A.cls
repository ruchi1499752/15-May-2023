public class CustomClass3A {
    public List<Account> acc{get;set;}
    public ID i{get;set;}
    public CustomClass3A(){
        acc = [select name, id, industry, rating from Account];
    }
    public void saveRec(){
        //insert acc;
        //i = acc.ID;
    	update acc;
        
        
    }
}