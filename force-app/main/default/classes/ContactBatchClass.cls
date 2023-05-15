public class ContactBatchClass implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    public Integer noOfRecordsProcessed = 0;

       
    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('start batch');
        String query ='SELECT id, AccountId, Sequence_Number__c, Status__c,	Birthdate, Description, CreatedDate FROM Contact where CreatedDate =TODAY';
        System.debug(query);
        return Database.getQueryLocator(query);
        
    }
   	public void execute(Database.BatchableContext bc, List<Contact> recordList){
        System.debug('execute batch');
        // process each batch of records
       	List<Contact> contactToUpdateList = new List<Contact>();
        
        for(Contact con :recordList){
            con.Status__c = 'Ready for Approval';
            contactToUpdateList.add(con);
            noOfRecordsProcessed += 1;
        }
        UPDATE contactToUpdateList;		
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('recordsProcessed : ' + noOfRecordsProcessed);
        System.debug('finish batch');
        
        String fieldsName ='Id, Birthdate, Description, CreatedDate, Sequence_Number__c, Status__c \n';
        
        String str ='';
        List<Contact> conList = [SELECT id, AccountId, Sequence_Number__c, Status__c, Birthdate, Description, CreatedDate FROM Contact WHERE CreatedDate = TODAY];
        for(Contact c : conList){
            fieldsName +=  c.id + ',' + c.Birthdate + ',"' + c.Description + '",' + c.CreatedDate + ','+  c.Sequence_Number__c + ',' + c.Status__c + '\n';
          
        }
        System.debug(fieldsName);
        System.debug('Email Process Start');

       /* Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddress = new List<String>();
        toAddress.add('ruchi@briskminds.com');
        mail.setToAddresses(toAddress);
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Process has completed');
        mail.setTargetObjectId( UserInfo.getUserId() );
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('filename.csv');
        attachment.setContentType('text/csv');
        attachment.setBody(Blob.valueOf(fieldsName) );
        mail.setFileAttachments( new Messaging.EmailFileAttachment[]{ attachment } );
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });*/
       
         // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        // sets the paramaters of the email object
        List<String> emailTo = new List<String>();
        emailTo.add('ruchi@briskminds.com');
        email.setToaddresses(emailTo);
        email.setSubject('Batch Contact records');
        email.setPlainTextBody('batch Apex : Batch Process Complete');
        
        Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
        csvAttachment.setFileName('Contact.csv');
        Blob csvBlob = blob.valueOf(fieldsName);
        csvAttachment.setBody(csvBlob);
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachment});
        // Sends the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        
      	//Messaging.SingleEmailMessage[] emailList = new List<Messaging.SingleEmailMessage>();
       	//emailList.add(email);
      	//Messaging.sendEmail(emailList);
     
    }
     // Scheduler Method to scedule the class
    public void execute(SchedulableContext ctx) {
        Database.executeBatch(new ContactBatchClass());
    }
}