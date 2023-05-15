public class accountClass {
    
    public static void fun(){
        // Create the account sObject 
	Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
// Insert the account by using DML
	insert acct;
        System.debug('Account record inserted....');
        
        Id i = 'a005j000009IMhs';
    System.debug(i);
	
    }
    
    
}