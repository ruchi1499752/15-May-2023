public class CreateCSVFIle {
	public static void createCsv(){
        String csvColumnHeader;
        List<String> csvRowValues = new List<String>();
        String parentId;
        for(Account acc : [SELECT Id, Name, Type, AccountNumber, CreatedDate FROM Account]){
            String formattedDate = acc.CreatedDate.format('M/d/yyyy h:mm:ss a z');
            System.debug('formattedDate :' + formattedDate);
            String accountName = acc.Name != null ? String.valueOf(acc.Name).escapeCsv() : '';
            System.debug('accountName :' + accountName);
            String accountType = acc.Type != null ? acc.Type : '';
            System.debug('accountType :' + accountType);
            String accountNumber = acc.AccountNumber != null ? acc.AccountNumber : '';
            System.debug('accountNumber :' + accountNumber);
            
            String csvRowVal = formattedDate + ',' + accountName + ',' + accountType + ',' + accountNumber;
            System.debug('csvRowVal :' + csvRowVal);
            csvRowValues.add(csvRowVal);
            parentId = acc.Id;
        }
            csvColumnHeader = 'Date, Name, Type, Account Number\n';
            String csvFile = csvColumnHeader + String.join(csvRowValues,'\n');
        	System.debug('csvFile :' + csvFile);
 
            //send email
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            Messaging.EmailFileAttachment attach1 = new Messaging.EmailFileAttachment();
            blob b;
            if(Test.isRunningTest()) { 
                System.debug('Inside If');
                b = blob.valueOf('Unit.Test');
            } else {
                b = Blob.valueOf(csvFile);
                System.debug('Inside else');
            }                        
 
            attach1.setFileName('test.csv');
            attach1.setBody(b);
            message.setFileAttachments(new Messaging.EmailFileAttachment[]{attach1});
            String[] toAddresses = new String[] {'ruchi@briskminds.com'}; 
            message.setToAddresses(toAddresses); 
            message.setSubject('how-to-create-or-generate-a-csv-file-in-apex-salesforce'); 
            message.setHtmlBody('This email is for testing purpose of Create csv files');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
 
        }
}