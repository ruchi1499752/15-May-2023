public class FlowExample2 {
	//label is a record parameter
        @InvocableMethod(label='Send Email to contact' description='Send Email to contact')
    	public static void sendEmailToContact(List<String> ids){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = ids;
        message.subject = 'Your case has been recieved';
        message.plainTextBody = 'Your case has been recieved!..';
        message.setSaveAsActivity(true);
        
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>{message};
        Messaging.SendEmailResult[] result = Messaging.sendEmail(messages);
        if(result[0].success){
            System.debug('The Email was send successfully.');
        }else{
            System.debug('The Email failed to send .' + result[0].errors[0].message);
        }
        //List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =: ids AND StageName = 'Closed Won'];
        //delete oppList; 
    }
}