public class AccountProcessor {
    
    @future 
    public static void countContacts(List<Id> accountIds){
        List<Account> accList = [SELECT Id, Number_Of_Contacts__c ,(SELECT Id FROM Contacts) FROM Account WHERE Id in : accountIds];
        
        for(Account acc : accList){
            acc.Number_Of_Contacts__c = acc.Contacts.size();
        }
        UPDATE accList;
    }

}