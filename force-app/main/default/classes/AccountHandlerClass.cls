public class AccountHandlerClass {
    public static void beforeInsertAccount(List<Account> acc){
        for(Account a : acc){
            if(a.name == 'Riya'){
                a.phone = '98765432';
            } 
        }
        
    }
    public static void afterAccountInsert(){
        
    }
}