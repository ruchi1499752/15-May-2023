public with sharing class LMSAccountController {
    public LMSAccountController() {

    }
    @AuraEnabled
    public static List<Account> getAccoutData(){
        try {
            List<Account> accList = [SELECT Name, Phone, rating, Industry FROM Account LIMIT 20];
            return accList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}