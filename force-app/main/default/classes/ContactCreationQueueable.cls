public class ContactCreationQueueable implements queueable {
    private List<Account> accList;
    public ContactCreationQueueable(List<Account> expectingAccountFromTrigger){
        System.debug('Inside Constructor');
        accList = expectingAccountFromTrigger;
        System.debug('AccList :' + accList);
    }
    public void execute(queueableContext qe){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            Contact con = new contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            conList.add(con);
        }
        System.debug('ConList :' + conList);
        System.debug('ConList :' + conList.size());
        if(conList.Size() > 0){
            INSERT conList;
        }
    }
}