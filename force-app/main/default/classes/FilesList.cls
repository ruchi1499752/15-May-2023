public with sharing class FilesList {
    public FilesList() {

    }
    @AuraEnabled
    public static void getAllFiles(){
        User res = [Select Name,Username, ContactId from user where id =: userInfo.getUserId()];
            System.debug('User Id :' + res.Id);
            System.debug('Contact Id :' + res.ContactId); 
            System.debug('User Name :' + res.Username); 
            System.debug('Name :' + res.Name); 


            List<ContentDocumentLink> contentDocumentLinks = 
            [
                SELECT ContentDocumentId ,LinkedEntityId
                FROM ContentDocumentLink 
                WHERE LinkedEntityId IN (SELECT ContactId FROM user where id = '0055j0000076AocAAE')
            ];
            System.debug('RTGTRHTHT' + contentDocumentLinks);
            System.debug('File Size ===>' + contentDocumentLinks.size());
    }
}