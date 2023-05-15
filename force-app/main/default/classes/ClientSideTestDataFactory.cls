public class ClientSideTestDataFactory {
	 public static List<Account> createAccounts(Integer numOfAccount){
        List<Account> accList = new List<Account>();
        for(Integer i =1 ;i<= numOfAccount; i++){
            accList.add(new Account(Name = 'Account'+i , Rating = 'Hot'));
        }
        if(!accList.isEmpty()){
            INSERT accList;
        }
        return accList;
    }
    public static List<Contact> createContacts(Integer numOfContact){
        Account acc = new Account(Name= 'Account 1');
        insert acc;
        
        List<Contact> conList = new List<Contact>();
        for(Integer i = 1; i<=numOfContact; i++){
            conList.add(new Contact(LastName = 'Con'+ i, AccountId = acc.Id));
        }
        if(!conList.isEmpty()){
            INSERT conList;
        }
        return conList;
    }
}