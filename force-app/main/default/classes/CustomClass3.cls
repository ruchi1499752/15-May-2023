public class CustomClass3 {
    //List<Account> acc{get;set;}
    List<Account> acc{get;set;}
    
    public CustomClass3(){
        acc = [select name, id, industry, rating from Account];
    }
    
    /*public List<Account> getrecord(){
        List<Account> acc = [select name, id, industry, rating from Account];
        return acc;
    }*/
    
    public void save(){
        //List<Account> acc = [select name, id, industry, rating from Account where id =:ApexPages.CurrentPage().getparameters().get('id')];
        insert acc;
        
    }
    public void quick(){
        insert acc;
    }
   
    
}