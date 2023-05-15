global with sharing class googleDriveWrapper {
    @AuraEnabled public String respCode;
    @AuraEnabled public String respBody;

    public class downloadLink{
        @AuraEnabled public String webContentLink;
    }

}