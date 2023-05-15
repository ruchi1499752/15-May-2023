public with sharing class AccController {
    public AccController() {

    }
    @AuraEnabled
    public static List<Account> getAccountData(){
        try {
            System.debug('Hello ');
            System.debug('Rucha');
            return [
                SELECT Id, Name, AccountNumber, Industry
                FROM Account
                WITH SECURITY_ENFORCED
                LIMIT 10
            ];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void getName(String str){
        try {
            System.debug('NAME ::' + str);
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}