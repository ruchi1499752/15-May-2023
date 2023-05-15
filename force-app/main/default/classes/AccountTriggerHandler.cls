public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accList){
        List<Account> ac = new List<Account>();
        for(Account acc : accList){
            if(acc.ShippingState != acc.BillingState){
             	acc.ShippingState = acc.BillingState;
            }
                
        }
        
    }
}