public class PicklistClass {
    public String objList{get;set;}
     public List<SelectOption> lst{get;set;}
    
    public PicklistClass(){
        lst = new List<SelectOption>();
        lst.add(new SelectOption('','---None---'));
        lst.add(new SelectOption('Account_Obj','Account'));
        lst.add(new SelectOption('Contact_Obj','Contact'));
        lst.add(new SelectOption('Position_Obj','Position'));
        
       
    }
    
    /*public Account setobjList(String objList){
        if(objList == 'Account_Obj'){
            List<Account> acc = [select name ,id from Account];
            return acc;
        }
    }*/
}