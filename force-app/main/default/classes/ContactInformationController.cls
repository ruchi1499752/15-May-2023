public class ContactInformationController {
	 @AuraEnabled
    public static contact insertContact(string ParentAccountId,string FirstName,string LastName)
    {
        system.debug('Test');
        contact con=new contact();
        con.firstName = FirstName;
        con.lastName = LastName;
        con.accountid = ParentAccountId;
        insert con;
        System.debug('Contact Inserted');
        return con;
         
    }
}