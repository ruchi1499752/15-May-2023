trigger ContactTrigger on Contact (before insert) {
    
    List<Contact> conList = new List<Contact>();
    
    for(Contact con : Trigger.New){
        if(con.AccountId != null){
            conList = [select id from contact where Accountid =: con.AccountId];
            con.Sequence_Number__c = conList.size()+ 1; 
            
        }
        
        /*if(con.Sequence_Number__c == null){
            con.Sequence_Number__c.addError('Can not blank Sequence Number');
        }
        else{
            con.Sequence_Number__c = 1;
        }*/
    }
}